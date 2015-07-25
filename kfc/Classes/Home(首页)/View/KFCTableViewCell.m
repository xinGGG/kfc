//
//  KFCTableViewCell.m
//  kfc
//
//  Created by xing on 15/6/15.
//  Copyright (c) 2015年 ljx. All rights reserved.
//

#import "KFCTableViewCell.h"
#import "goods.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Extension.h"

#import "UIColor+flat.h"
#import "FeEqualize.h"

@interface KFCTableViewCell ()

@property (weak, nonatomic) IBOutlet UIButton *saveList;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIButton *imgClickBtn;

@property (strong, nonatomic) FeEqualize *equalizer;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;

@property (nonatomic,weak)UITableView *tableView;

@property (nonatomic,assign)CGFloat CellWith;

@property (nonatomic,assign)BOOL isLoading;
@end

@implementation KFCTableViewCell
- (IBAction)shareClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(shareCellBtnClick:)]) {
        [self.delegate shareCellBtnClick:self];
    }
}

- (IBAction)addListClick:(id)sender {
    
    NSString *addListBtn = nil;
    UIImage *icon = nil;

    UIButton *btn = (UIButton *)sender;
    if (self.good.isInList) {
        
        addListBtn  = [NSString stringWithFormat:@"  收藏"];
        icon = [UIImage imageNamed:@"addLists"];
    }else {
        addListBtn  = [NSString stringWithFormat:@"  已收藏"];
        icon = [UIImage imageNamed:@"addList"];
    }
    [btn setTitle:addListBtn forState:UIControlStateNormal];
    [btn setImage:icon forState:UIControlStateNormal];
    
    if ([self.delegate respondsToSelector:@selector(addListBtnClick:)]) {
        [self.delegate addListBtnClick:self];
    }
}

+ (instancetype)cell:(UITableView *)tableView{
    
    static NSString *ID = @"cell";
    
    KFCTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell ==nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"KFCTableViewCell" owner:self options:nil] lastObject];
    }
    cell.CellWith = tableView.frame.size.width;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (IBAction)imgClick:(id)sender {
    NSLog(@"点击");
    if ([self.delegate respondsToSelector:@selector(TabelCellImageClick:)]) {
        [self.delegate TabelCellImageClick:self];
    }
}

- (void)setGood:(goods *)good {
    
    _good = good;
    
    if (good.c.count){
    NSString *price = [NSString stringWithFormat:@"%@   优惠价格￥%@元   优惠劲省%@元",good.c[0],good.p,good.s];
    self.titleLabel.text = price;
    }else {
     NSString *price = [NSString stringWithFormat:@"  优惠价格￥%@元   优惠劲省%@元",good.p,good.s];
        self.titleLabel.text = price;

    }
    NSString *addListBtn = nil;
    UIImage *icon = nil;
    if (good.isInList) {
        addListBtn  = [NSString stringWithFormat:@"  已收藏"];
        icon = [UIImage imageNamed:@"addList"];
    }else {
        addListBtn  = [NSString stringWithFormat:@"  收藏"];
        icon = [UIImage imageNamed:@"addLists"];
    }
    [self.addList setTitle:addListBtn forState:UIControlStateNormal];
    [self.addList setImage:icon forState:UIControlStateNormal];
    
    NSURL *imgUrl = [NSURL URLWithString:good.i];
    
    [self.imgClickBtn removeTarget:self action:@selector(imgClick:) forControlEvents:UIControlEventTouchUpInside];
    if (self.isLoading) {
        self.activity.hidden = !self.isLoading;
    }else {
        self.activity.hidden = YES;
    }
    
    [self.img sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"a"] options:SDWebImageRetryFailed|SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.activity.hidden = NO;
        self.isLoading = YES;

    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        self.activity.hidden = YES;
        self.isLoading = NO;

        [self.imgClickBtn addTarget:self action:@selector(imgClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }];
    
}

- (void)checkLoading{
    
    self.activity.hidden = self.isLoading;

}

- (void)awakeFromNib {
    // Initialization code
    
    [self.addList setBackgroundImage:[UIImage resizeImgWithName:@"btn"] forState:UIControlStateNormal];
    [self.saveList setBackgroundImage:[UIImage resizeImgWithName:@"btn"] forState:UIControlStateNormal];
    
    [self.imgClickBtn.layer setBorderWidth:1.0];   //边框宽度
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.5, 0.5, 0.5, 0.2 });
    
    [self.imgClickBtn.layer setBorderColor:colorref];//边框颜色
    
    self.activity.hidden = YES;

}
- (void)layoutSubviews {
    CGRect bounds = self.bounds ;
    bounds.size.width = self.CellWith;
    self.bounds = bounds;
    self.img.contentMode = UIViewContentModeScaleToFill;


}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
