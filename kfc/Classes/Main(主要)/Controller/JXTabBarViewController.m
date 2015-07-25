//
//  JXTabBarViewController.m
//  kfc
//
//  Created by xing on 15/6/16.
//  Copyright (c) 2015年 ljx. All rights reserved.
//

#import "JXTabBarViewController.h"
#import "JXNavigationViewController.h"
#import "JXTableViewController.h"
#import "XHSettingMainViewController.h"
#import "JXListTableViewController.h"
@interface JXTabBarViewController ()
@property (nonatomic,weak)UIView *backView;
@end
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)

@implementation JXTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 49)];
    backView.backgroundColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    self.backView = backView ;
    [self.tabBar insertSubview:backView atIndex:0];
    self.tabBar.opaque = YES;
    
    self.view.backgroundColor = [UIColor whiteColor];
    //添加按钮
    JXTableViewController *MessageVC = [[JXTableViewController alloc]init];
    [self addChildViewController:MessageVC WithTitle:@"优惠券" image:@"tabbar1"];
//    //添加按钮
    JXListTableViewController *GoodsListVC = [[JXListTableViewController alloc]init];
    [self addChildViewController:GoodsListVC WithTitle:@"收藏" image:@"tabbar2"];
    //添加按钮
    XHSettingMainViewController *SettingListVC = [[XHSettingMainViewController alloc]init];
    [self addChildViewController:SettingListVC WithTitle:@"设置" image:@"tabbar3"];

}

- (void)addChildViewController:(UIViewController *)vc WithTitle:(NSString *)title image:(NSString *)itemName{
    //设置tabbar 属性
    vc.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:[NSString stringWithFormat:@"%@s",itemName]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    vc.tabBarItem.selectedImage = [[UIImage imageNamed:[NSString stringWithFormat:@"%@",itemName]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    
    //设置tabbaritem 属性
    NSDictionary *norDict = [NSDictionary dictionary];
    norDict = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:12],NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    [vc.tabBarItem setTitleTextAttributes:norDict forState:UIControlStateNormal];
    
    //设置tabbaritem - select 属性
    NSDictionary *selDict = [NSDictionary dictionary];
    selDict = @{NSForegroundColorAttributeName:[UIColor colorWithRed:44/255.0 green:244/255.0 blue:206/255.0 alpha:1]};
    [vc.tabBarItem setTitleTextAttributes:selDict forState:UIControlStateSelected];
    
    //包装到navigation 里面
    JXNavigationViewController *nav = [[JXNavigationViewController alloc]initWithRootViewController:vc];
    [self addChildViewController:nav];
}
- (void)viewDidLayoutSubviews{
   self.backView.frame =CGRectMake(0, 0, SCREEN_WIDTH, 49);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
