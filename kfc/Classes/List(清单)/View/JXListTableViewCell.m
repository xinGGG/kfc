//
//  JXListTableViewCell.m
//  一元夺宝
//
//  Created by xing on 15/5/22.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import "JXListTableViewCell.h"
#import "goods.h"
#import "UIImageView+WebCache.h"
@interface JXListTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *goodsImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UITextField *buyNumField;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation JXListTableViewCell

+ (instancetype)ListCell:(UITableView *)tableView{
    
    return [[[NSBundle mainBundle]loadNibNamed:@"JXListTableViewCell" owner:self options:nil]lastObject];
}
- (void)setGood:(goods *)good{
    _good = good;
    NSURL *imgUrl = [NSURL URLWithString:good.i];
    [self.goodsImgView sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageNamed:@"a"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
    
    //    ///商品名字
    //    @property (nonatomic,strong)NSArray *c;
    //    ///图片1
    //    @property (nonatomic,copy)NSString *i;
    //    ///图片2
    //    @property (nonatomic,copy)NSString *l;
    //    ///现在价格
    //    @property (nonatomic,copy)NSNumber *p;
    //    ///节省金额
    //    @property (nonatomic,copy)NSNumber *s;
    //    ///编号代码
    //    @property (nonatomic,copy)NSString *t;
    //
    //    @property(nonatomic,copy)NSString *h;
    NSString *titleStr = [NSString stringWithFormat:@"%@",good.t];
    self.titleLabel.text = titleStr;
    NSMutableString *contentStr = [NSMutableString string];
    for (NSString *str in good.c) {
        [contentStr appendFormat:[NSString stringWithFormat:@"%@\n",str]];
    }
    
    NSString *priceStr =[NSString stringWithFormat:@"价格 : %@ 元",good.p];
    self.priceLabel.text = priceStr;
    
    self.contentLabel.text = contentStr;
//    self.totalLabel.text =   [NSString stringWithFormat:@"%@",goods.totalNum];
//    self.lastNumLabel.text = [NSString stringWithFormat:@"%@",goods.lastNum];
//    self.buyNumLabel.text = [NSString stringWithFormat:@"%@",goods.NowNum];
    
}

- (IBAction)addNumClick:(id)sender {
    if (self.buyNumField.text.length == 0) {
        return ;
    }else if([self.buyNumField.text integerValue]>1){
        NSInteger nowNum = [self.buyNumField.text integerValue]+1;
        self.buyNumField.text = [NSString stringWithFormat:@"%ld",(long)nowNum];
    }
    if ([self.delegate respondsToSelector:@selector(ListCountChangeClick:)]) {
        [self.delegate ListCountChangeClick:self];
    }

}

- (IBAction)subNumClick:(id)sender {
    if (self.buyNumField.text.length == 0) {
        return ;
    }else if([self.buyNumField.text integerValue]>1){
        NSInteger nowNum = [self.buyNumField.text integerValue]-1;
        self.buyNumField.text = [NSString stringWithFormat:@"%ld",(long)nowNum];
    }
    if ([self.delegate respondsToSelector:@selector(ListCountChangeClick:)]) {
        [self.delegate ListCountChangeClick:self];
        NSLog(@"ene");
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)awakeFromNib {
    // Initialization code
    
}


@end
