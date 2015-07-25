//
//  XHWebViewForWWW.m
//  XinHeEdu
//
//  Created by xing on 15/6/6.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import "XHWebViewForWWW.h"
#import "MBProgressHUD+MJ.h"
@interface XHWebViewForWWW ()<UIWebViewDelegate>

@end
@implementation XHWebViewForWWW
- (void)loadView {
    self.view =[[UIWebView alloc]init];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style: UIBarButtonItemStyleDone target:self action:@selector(back)];
    
    UIWebView *webV = (UIWebView *)self.view;
    webV.delegate = self;
    NSString *path =@"http://xinggg.digitcv.com/";
    NSURL *url = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webV loadRequest:request];

}
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showSuccess:@"加载中"];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUD];
}
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
