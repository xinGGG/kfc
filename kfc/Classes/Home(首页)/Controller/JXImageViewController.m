//
//  JXImageViewController.m
//  kfc
//
//  Created by xing on 15/6/17.
//  Copyright (c) 2015年 ljx. All rights reserved.
//

#import "JXImageViewController.h"
#import "goods.h"
#import "UIImage+Extension.h"
#import "UIImageView+WebCache.h"
#import "UMSocial.h"

@interface JXImageViewController ()<UMSocialUIDelegate>
@property (weak, nonatomic) IBOutlet UIButton *titleLabel;
@property (nonatomic,weak)UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIButton *shareBtn;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@end

@implementation JXImageViewController

///保存到相册
- (IBAction)saveClick:(id)sender {
    UIImageWriteToSavedPhotosAlbum(self.imgView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

///分享功能 - 友盟
- (IBAction)shareClick:(id)sender {
    [self shareView:@"推荐一个图片" Image:self.imgView.image];
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
///收藏
- (IBAction)saveListClick:(id)sender {

}

///保存到手机相册的后续操作
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已存入手机相册" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil,nil];
        [alert show];
        
    }else{
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil, nil];
        [alert show];
    }
    
}

- (IBAction)backClick:(id)sender {
    [self closeActive];
}


- (void)setGood:(goods *)good{
    
    _good = good;
    
    NSURL *imgUrl = [NSURL URLWithString:good.i];
    
    [self.imgView sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"a"] options:SDWebImageRetryFailed|SDWebImageLowPriority];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self closeBtn];
    self.view.backgroundColor = [UIColor blackColor];
    [self.saveBtn setBackgroundImage:[UIImage resizeImgWithName:@"imgBtn"] forState:UIControlStateNormal];
    [self.shareBtn setBackgroundImage:[UIImage resizeImgWithName:@"imgBtn"] forState:UIControlStateNormal];
    [self.titleLabel setBackgroundImage:[UIImage resizeImgWithName:@"imgBtn"] forState:UIControlStateNormal];

}
- (void)closeActive{

    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)viewDidLayoutSubviews{
    self.closeBtn.frame = self.view.frame;

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
