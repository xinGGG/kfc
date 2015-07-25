//
//  XHAboutViewController.m
//  XinHeEdu
//
//  Created by xing on 15/6/6.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import "XHAboutViewController.h"
//#import "XHNavigationController.h"
#import "XHWebViewForWWW.h"
#import "MBProgressHUD+MJ.h"
#import "JXNavigationViewController.h"
@interface XHAboutViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *logo;

@end

@implementation XHAboutViewController
//- (IBAction)wwwClick:(id)sender {
//
//    XHWebViewForWWW *web = [[XHWebViewForWWW alloc]init];
//    web.view.backgroundColor =[UIColor whiteColor];
//    XHNavigationController *nav = [[XHNavigationController alloc] initWithRootViewController:web];
//    [self presentViewController:nav animated:YES completion:nil];
//}
- (IBAction)callClick:(id)sender {
    XHWebViewForWWW *web = [[XHWebViewForWWW alloc]init];
    web.view.backgroundColor =[UIColor whiteColor];
    JXNavigationViewController *nav = [[JXNavigationViewController alloc] initWithRootViewController:web];
    [self presentViewController:nav animated:YES completion:nil];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (!buttonIndex)return;
#warning 真机调试 拨打电话
    
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:@"tel:020-8382115"];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
//    NSLog(@"正在拨打电话");
//        [MBProgressHUD  showSuccess:@"拨打电话"];

}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.logo.layer.cornerRadius = 16.0f;
    self.logo.layer.masksToBounds = YES;
    
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
