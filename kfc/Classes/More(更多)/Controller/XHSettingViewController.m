//
//  XHSettingViewController.m
//  XinHeEdu
//
//  Created by xing on 15/6/6.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import "XHSettingViewController.h"
#import "MBProgressHUD+MJ.h"
@interface XHSettingViewController ()

@end

@implementation XHSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    XHSettingItem *item1 =  [XHSettingItemSwitch itemWithTitle:@"信息震动通知" ];
    XHSettingItem *item2 = [XHSettingItemSwitch itemWithTitle:@"消息声音通知" ];

    
    XHSettingGroups *group1 = [XHSettingGroups arrayWithItems:@[item1,item2]];
    [self.items addObject:group1];
    
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
