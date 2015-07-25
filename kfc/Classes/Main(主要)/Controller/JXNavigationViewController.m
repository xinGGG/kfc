//
//  JXNavigationViewController.m
//  kfc
//
//  Created by xing on 15/6/16.
//  Copyright (c) 2015年 ljx. All rights reserved.
//

#import "JXNavigationViewController.h"

@interface JXNavigationViewController ()

@end

@implementation JXNavigationViewController
+ (void)initialize
{
    if (self == [JXNavigationViewController class]) {
        //获取所有导航栏
        UINavigationBar *bar = [UINavigationBar appearance];
        //设置导航栏背景颜色
        bar.barTintColor =   [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];

        bar.opaque = YES;
        bar.translucent = NO;
        //导航栏主题颜色
        bar.tintColor = [UIColor whiteColor];
        NSMutableDictionary *barStyle = [NSMutableDictionary dictionary];
        barStyle[NSForegroundColorAttributeName] = [UIColor whiteColor];
        barStyle[NSFontAttributeName] =[UIFont systemFontOfSize:18];
        [bar setTitleTextAttributes:barStyle];
        
        UIBarButtonItem *item = [UIBarButtonItem appearance];
        NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
        dictM[NSForegroundColorAttributeName] = [UIColor whiteColor];
        dictM[NSFontAttributeName] = [UIFont systemFontOfSize:15];
        [item setTitleTextAttributes:dictM forState:UIControlStateNormal];        
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.viewControllers.count >0){
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)                                                      forBarMetrics:UIBarMetricsDefault];

    [super pushViewController:viewController animated:animated];
    
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
