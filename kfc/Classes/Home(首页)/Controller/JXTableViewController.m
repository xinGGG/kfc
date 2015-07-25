//
//  JXTableViewController.m
//  kfc
//
//  Created by xing on 15/6/16.
//  Copyright (c) 2015年 ljx. All rights reserved.
//

#import "JXTableViewController.h"
#import "UIImageView+WebCache.h"
#import "KFC.h"
#import "goods.h"
#import "KFCTableViewCell.h"
#import "Reachability.h"
#import "MBProgressHUD+MJ.h"
#import "MJRefresh.h"
#import "MJChiBaoZiHeader.h"
#import "JXImageViewController.h"
#import "JXNavigationViewController.h"
#import "JXErrorView.h"
#import "NSArray+Log.h"
#import "UMSocial.h"
#import "JXResourceTool.h"
#import "JXConnectionTool.h"
@interface JXTableViewController ()<KFCTableViewCellDelegate,JXErrorViewDelegate,UMSocialUIDelegate>
//数据源
@property (nonatomic,strong)NSMutableArray *dataList;
//购物车价格
@property (nonatomic,strong)NSMutableArray *price;
//网络监测
@property (nonatomic,strong)Reachability *reachabilityManager;
//上一次更新的时间
@property (nonatomic,strong)NSString *lastDate;
//有效期的时间
@property (nonatomic,strong)NSString *endDate;
//无数据提示
@property (nonatomic,weak)JXErrorView *errorView;
///分享图片
@property (nonatomic,strong)UIImage *shareImage;
//收藏的列表
@property (nonatomic,weak)NSMutableArray *saveList;

@end

@implementation JXTableViewController

#pragma mark - 初始化
//网络加载
- (Reachability *)reachabilityManager
{
    // http://baidu.com/iamge/123.png
    // 协议头://主机地址/路径
    if (_reachabilityManager == nil) {
        _reachabilityManager = [Reachability reachabilityWithHostName:@"baidu.com"];
    }
    return _reachabilityManager;
}

- (JXErrorView *)errorView{
    
    if (_errorView==nil) {
        JXErrorView *view = [JXErrorView errorView];
        view.delegate = self;
        _errorView = view;
        CGRect frame =self.view.frame;
        frame.origin.y = 0;
        _errorView.frame = frame;
        _errorView.hidden = NO;
        [self.view addSubview:_errorView];
    }
    
    return _errorView;
}

- (NSMutableArray *)price {
    if (_price ==nil) {
        _price = [NSMutableArray array];
    }
    return _price;
}

-(void)setDataList:(NSMutableArray *)dataList{
    
    _dataList = dataList;
    
    [self.tableView reloadData];
    
    [self.refreshControl endRefreshing];
    
}
- (NSMutableArray *)saveList {
    
    if (_saveList ==nil) {
        _saveList = [NSMutableArray array];
    }
    return _saveList;
}
#pragma mark - 控制器生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setup];
    [self setupRefresh];
}

//解档
- (void)viewDidAppear:(BOOL)animated {
    
    __weak __typeof(self) weakself = self;
    
    [JXResourceTool readDataList:^(NSMutableArray *arrM) {
         weakself.dataList = arrM;
    }];
    [super viewDidAppear:animated];
    
}
//归档
- (void)viewDidDisappear:(BOOL)animated{
    [JXResourceTool setupDataList:self.dataList saveSuccessful:nil];
    [super viewDidDisappear:animated];
}

- (void)setupRefresh{
    
    //    __weak UITableView *tableView = self.tableView;
    
    self.tableView.header = [MJChiBaoZiHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshAction)];
    
    // 马上进入刷新状态
        [self.tableView.header beginRefreshing];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    
    self.tableView.header.autoChangeAlpha = YES;
    [self refreshAction];
    
}
- (void)setup{
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    

    //布局
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.backgroundColor = [UIColor colorWithRed:248/255.0 green:248/255.0 blue:248/255.0 alpha:1];
    
    //刷新按钮
//    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithTitle:@"清理数据" style:UIBarButtonItemStyleDone target:self action:@selector(redata)];
//    self.navigationItem.leftBarButtonItem = btn;
    //刷新按钮
    UIBarButtonItem *btnr = [[UIBarButtonItem alloc]initWithTitle:@"刷新" style:UIBarButtonItemStyleDone target:self action:@selector(errorViewClick:)];
    self.navigationItem.rightBarButtonItem = btnr;
    
    
}
#pragma  mark - 刷新
- (void)refreshAction {

    __weak __typeof(self) weakSelf = self;

    [JXConnectionTool connectionWithBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            //判断日期是否需要更新
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            if ([[defaults stringForKey:@"lastDate"] isEqualToString:dict[@"s"]]){
                //等于 不需要更新
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf checkDataList];
                    [MBProgressHUD showSuccess:@"已是最新数据"];
                    [weakSelf.tableView.header endRefreshing];
                });
            }else
                {
                //需要更新
                //解析-》商品模型
                NSMutableArray *m = dict[@"m"];
                weakSelf.lastDate = dict[@"s"];
                weakSelf.endDate = dict[@"e"];
                NSMutableArray *arrM = [NSMutableArray array];
                for (NSDictionary *dictM in m) {
                    goods *good = [goods goodsWithDict:dictM];
                    if (!good.c) {
                        good.c = @[@"空"];
                    };
                    [arrM addObject:good];
                }
                
                weakSelf.dataList = arrM;
                
                if (weakSelf.lastDate) {//判断是否有数据导入
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:weakSelf.lastDate forKey:@"lastDate"];
                };
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weakSelf.tableView.header endRefreshing];
                    [weakSelf checkDataList];
                    [weakSelf.tableView reloadData];
                    [JXResourceTool setupDataList:weakSelf.dataList saveSuccessful:nil];
                    [MBProgressHUD hideHUD];

                });
            }
        }else {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [MBProgressHUD showError:@"加载失败"];
                [weakSelf.tableView.header endRefreshing];
                [weakSelf checkDataList];
            });
        }
        
    
    }];
    
}
///检测数据源是否有数据
- (void)checkDataList{
    if (!self.dataList) {
        [self showErrorView];
    }else {
        [self hideErrorView];
    }
}

///无数据提示页面 显示
- (void)showErrorView{
    self.errorView.hidden = NO;
}

///无数据提示页面 隐藏
- (void)hideErrorView{
    self.errorView.hidden = YES;
}

///清空 - 刷新
- (void)redata {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"lastDate"];
    self.dataList =nil;
    [self checkDataList];

}



#pragma mark tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    KFCTableViewCell *cell = [KFCTableViewCell cell:tableView ];
    
    goods *good = self.dataList[indexPath.row];
    
    cell.good = good;
    
    cell.delegate = self;
    
    cell.tag = indexPath.row;
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 330;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //    KFCTableViewCell *cell = [[KFCTableViewCell alloc]init];
    return 330;
}

#pragma mark - cell delegate
//点击展示大图
- (void)TabelCellImageClick:(KFCTableViewCell *)cell{
    JXImageViewController *imgVC = [[JXImageViewController alloc]init];
    [self presentViewController:imgVC animated:YES completion:^{
        goods *good = self.dataList[cell.tag];
        imgVC.good = good;
    }];
}

//分享按钮
- (void)shareCellBtnClick:(KFCTableViewCell *)cell{
    self.shareImage = cell.img.image;
    [self shareView:@"给大家分享" Image:self.shareImage];
    
}
//加入清单
- (void)addListBtnClick:(KFCTableViewCell *)cell{

    goods *good = self.dataList[cell.tag];
    
    good.isInList = !good.isInList;

}

//网络错误或无法获取数据时候----画面点击刷新
- (void)errorViewClick:(JXErrorView *)errorView {
    [self refreshAction];
    [self.tableView.header beginRefreshing];
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
#warning 每次打开该控制器，都检查dataList.count
    
    // Dispose of any resources that can be recreated.
}

#pragma mark - 分享
- (void)shareView:(NSString *)title Image:(UIImage *)image {
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"507fcab25270157b37000010"
                                      shareText:title
                                     shareImage:image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone,UMShareToQQ,UMShareToRenren,UMShareToDouban,UMShareToEmail,UMShareToSms,nil]
                                       delegate:self];
}
@end
