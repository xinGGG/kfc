//
//  XHSettingMainViewController.m
//  XinHeEdu
//
//  Created by xing on 15/6/6.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import "XHSettingMainViewController.h"
#import "MBProgressHUD+MJ.h"
#import "XHSettingItem.h"
#import "XHSettingCustom.h"
#import "XHSettingGroups.h"

#import "XHSettingItemSwitch.h"
#import "XHSettingItemArrow.h"
#import "XHSettingItemSwitch.h"

#import "XHFeedbackViewViewController.h"
#import "XHSettingViewController.h"
#import "XHAboutViewController.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"

typedef enum {
    ClearDataTypeImage=1,

    ClearDataTypeList=2,
    ClearDataTypeAll=3,
} ClearDataType;

@interface XHSettingMainViewController ()<UIActionSheetDelegate>
@property (nonatomic,assign)ClearDataType clearType;
@end

@implementation XHSettingMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
//    XHSettingItem *item1 = [XHSettingItemArrow itemWithTitle:@"用户反馈" desVC:[XHFeedbackViewViewController class]];
//    XHSettingItem *item2 = [XHSettingItemArrow itemWithTitle:@"设置" desVC:[XHSettingViewController class]];
        XHSettingItem *item3 = [XHSettingItemArrow itemWithTitle:@"关于" desVC:[XHAboutViewController class]];
    
    XHSettingGroups *group1 = [XHSettingGroups arrayWithItems:@[item3]];
    [self.items addObject:group1];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"清除图片缓存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = 1;
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    CGRect frame = CGRectMake(10, 0, screenW-20, 44);
    XHSettingItem *itemBtn = [XHSettingCustom itemCustomView:button frame:frame];
    
//    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button1 setTitle:@"清理数据" forState:UIControlStateNormal];
//    [button1 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [button1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    button1.tag = 2;
//    XHSettingItem *itemBtn1 = [XHSettingCustom itemCustomView:button1 frame:frame];
    XHSettingGroups *group2= [XHSettingGroups arrayWithItems:@[itemBtn]];
    [self.items addObject:group2];
    
//    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button2 setTitle:@"初始化" forState:UIControlStateNormal];
//    [button2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [button2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    button2.tag = 3;
//    XHSettingItem *itemBtn2 = [XHSettingCustom itemCustomView:button2 frame:frame];
//    XHSettingGroups *group3= [XHSettingGroups arrayWithItems:@[itemBtn2]];
//    [self.items addObject:group3];
    
    
}

- (void)btnClick:(UIButton *)sender{
    
    NSString *title = [NSString stringWithFormat:@"请问确定%@",sender.currentTitle];
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:title delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"清除" otherButtonTitles:nil, nil];
    sheet.delegate =self;
    [sheet showInView:self.view];
    self.clearType = sender.tag;
    NSLog(@"%d",self.clearType);
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex) {
        return;
    }
    else {
        switch (self.clearType) {
            case ClearDataTypeList:
                [self redata];
                break;
            case ClearDataTypeImage:
                [self cancelAllCache];
                break;
            case ClearDataTypeAll:
                [self redata];
                [self cancelAllCache];
                break;
            default:
                break;
        }
    

    }
}
///清空 - 刷新
- (void)redata {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:nil forKey:@"lastDate"];
    
}
- (void)cancelAllCache{
    [[[SDWebImageManager sharedManager] imageCache] clearDisk];
    [[[SDWebImageManager sharedManager] imageCache] clearMemory];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [MBProgressHUD showSuccess:@"清理完成"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
