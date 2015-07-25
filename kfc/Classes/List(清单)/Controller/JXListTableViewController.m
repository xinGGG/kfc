//
//  JXListTableViewController.m
//  一元夺宝
//
//  Created by xing on 15/5/22.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import "JXListTableViewController.h"
#import "JXListTableViewCell.h"
#import "IQKeyboardManager.h"
#import "goods.h"
#import "MBProgressHUD+MJ.h"
#import "JXErrorView.h"
#import "JXEmptyView.h"
#import "JXImageViewController.h"
#import "JXResourceTool.h"
#define textFont [UIFont systemFontOfSize:14];
@interface JXListTableViewController ()<UITextFieldDelegate,ListTableViewCellDelegate,UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,weak)UIButton *keyBoardFinsh;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,weak)UIButton *submitBtn;
@property(nonatomic,weak)UILabel *desLabel;
@property(nonatomic,weak)UILabel *buyNumTotalLabel;
@property (nonatomic,assign)NSInteger desNum;
@property (nonatomic,assign)NSInteger buyNum;

//数据源
@property (nonatomic,strong)NSMutableArray *dataList;
//收藏数据
@property (nonatomic,strong)NSMutableArray *listOfList;
//空购物车提示
@property (nonatomic,weak)JXEmptyView *emptyView;

@end
#define screenH self.view.bounds.size.height;
#define screenW self.view.bounds.size.width;
@implementation JXListTableViewController
- (JXEmptyView *)emptyView{
    if (_emptyView==nil) {
        JXEmptyView *view = [JXEmptyView emptyView];
        _emptyView = view;
        CGRect frame =self.view.frame;
        frame.origin.y = 0;
        _emptyView.frame = frame;
        _emptyView.hidden = NO;
        [self.view addSubview:_emptyView];
    }
    return _emptyView;
}
- (NSMutableArray *)dataList {
    if (_dataList==nil) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}
- (NSMutableArray *)listOfList {
    if (_listOfList ==nil) {
        _listOfList = [NSMutableArray array];
    }
    return _listOfList;
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        CGSize size  = self.view.bounds.size;
        CGFloat sizeW = size.width;
//        CGFloat sizeH = size.height-170;
        CGFloat sizeH = size.height-114;
        _tableView.frame = CGRectMake(0, 0,sizeW, sizeH);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //        _tableView.backgroundColor = [UIColor ];
        _tableView.tableFooterView = [[UIView alloc]init];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (UIView *)bottomView{
    if (_bottomView ==nil) {
        _bottomView = [[UIView alloc]init];
        
        CGFloat padding = 10;
        CGFloat viewH = 60;
        CGSize size  = self.view.bounds.size;
        CGFloat sizeW = size.width;
        CGFloat sizeY = size.height - viewH-114;
        _bottomView.frame = CGRectMake(0, sizeY, sizeW, viewH);
        _bottomView.backgroundColor = [UIColor colorWithRed:0.95    green:0.95 blue:0.95 alpha:1];
        
        UILabel *desLabel = [[UILabel alloc]init];
        CGFloat desW = sizeW /3;
        desLabel.frame = CGRectMake(padding,0 , desW, viewH);
        desLabel.textColor = [UIColor lightGrayColor];
        desLabel.font = textFont;
        [_bottomView addSubview:desLabel];
        self.desLabel = desLabel;
        
        UILabel *buyNumTotalLabel = [[UILabel alloc]init];
        CGFloat buyNumX = desW+padding;
        buyNumTotalLabel.frame = CGRectMake(buyNumX,0 , desW, viewH);
        buyNumTotalLabel.textColor = [UIColor redColor];
        [_bottomView addSubview:buyNumTotalLabel];
        buyNumTotalLabel.font = textFont;
        
        self.buyNumTotalLabel = buyNumTotalLabel;
        
        UIButton *submitBtn = [[UIButton alloc]init];
        CGFloat submitBtnX = desW*2;
        submitBtn.frame = CGRectMake(submitBtnX, 0, desW, viewH);
        [submitBtn setImage:[UIImage imageNamed:@"bill_submit"] forState:UIControlStateNormal];
        [_bottomView addSubview:submitBtn];
        self.submitBtn = submitBtn;
        
        [self.view addSubview:_bottomView];
    }
    return _bottomView;
}


#pragma mark - 控制器生命周期处理缓存数据
//解档
- (void)viewDidAppear:(BOOL)animated {
    //获取数据
    [JXResourceTool readDataList:^(NSMutableArray *arrM) {
        self.dataList = arrM;
    }];
    //处理收藏列表
    self.listOfList = [self readListOfListToArray:_dataList otherArray:_listOfList];
    [self checkDataList];
    [self.tableView reloadData];
    [super viewDidAppear:animated];
}

//归档
- (void)viewDidDisappear:(BOOL)animated{
    [self setupListOfList];
    [JXResourceTool setupDataList:self.dataList saveSuccessful:nil];
    [super viewDidDisappear:animated];
}

//存档 本表格的数据源
-(void)setupListOfList{
    for (goods *listGoods in _listOfList) {
        
        for (goods *dataGoods in _dataList) {
            if([dataGoods.t isEqualToString:listGoods.t]){
                dataGoods.isInList = listGoods.isInList;
            }
        }
    }
}

//解档 本表格的数据源
- (NSMutableArray *)readListOfListToArray:(NSMutableArray *)arrM otherArray:(NSMutableArray *)arrOther{
    //获取带有加入收藏标记的产品
    [arrOther removeAllObjects];
    for (goods *temp  in arrM) {
        if (temp.isInList) {
            [arrOther addObject:temp];
        }
    }
    return arrOther;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor redColor];
    
    //刷新按钮
    UIBarButtonItem *btn = [[UIBarButtonItem alloc]initWithTitle:@"清空" style:UIBarButtonItemStyleDone target:self action:@selector(alertView)];
    self.navigationItem.leftBarButtonItem = btn;
    
    [self tableView];
//    [self bottomView];
    //    [self mathBuyCount];
    NSLog(@"%ld---%ld",(long)self.buyNum,(long)self.desNum);
    
       [self addObserver:self forKeyPath:@"listOfList" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
#warning  解决数据传输 之后的数据修改问题 （主体部分）
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 通知中心检测数据
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    if ([keyPath isEqualToString:@"listOfList"])
    {
        
        if (_listOfList.count == 0) {
            [self checkDataList];
        }
        else
        {
            [self checkDataList];
        }
    }
}

- (void)checkDataList{
    if (!self.listOfList.count) {
        [self showErrorView];
    }else {
        [self hideErrorView];
    }
}

///无数据提示页面 显示
- (void)showErrorView{
    self.emptyView.hidden = NO;
}
///无数据提示页面 隐藏
- (void)hideErrorView{
    self.emptyView.hidden = YES;
}

-(void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath context:(void *)context
{
    [self removeObserver:self forKeyPath:@"listOfList" context:context];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)ListCountChangeClick:(JXListTableViewCell *)cell {

}



///清空数组
- (void)redataOfGoodsList {

    for (goods *temp in self.listOfList) {
        temp.isInList = NO;
    }
    [self setupListOfList];
    [self.listOfList removeAllObjects];
    [self.tableView reloadData];
    [self checkDataList];
}
#pragma  mark - alertView delegate
- (void)alertView{
    UIActionSheet *alert = [[UIActionSheet alloc]initWithTitle:@"请问确定清空收藏数据吗" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"清空" otherButtonTitles:nil, nil];
    [alert showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"%d",buttonIndex);
    if (buttonIndex) {
        return;
    }
    [self redataOfGoodsList];

}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.listOfList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    JXListTableViewCell *cell = [JXListTableViewCell ListCell:tableView];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.good = self.listOfList[indexPath.row];
    cell.delegate = self;
    // Configure the cell...
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JXListTableViewCell *cell = [JXListTableViewCell ListCell:tableView];
    return  cell.frame.size.height;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        goods *good = self.listOfList[indexPath.row];
        good.isInList = NO;
        [self setupListOfList];
        // Delete the row from the data source
        [self.listOfList removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self checkDataList];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    JXImageViewController *imgVC = [[JXImageViewController alloc]init];
    [self presentViewController:imgVC animated:YES completion:^{
        goods *good = self.listOfList[indexPath.row];
        imgVC.good = good;
    }];
}


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
