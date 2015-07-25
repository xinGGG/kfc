//
//  XHSettingTableViewCell.m
//  XinHeEdu
//
//  Created by xing on 15/6/4.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import "XHSettingTableViewCell.h"
#import "XHSettingItem.h"
#import "XHSettingItemArrow.h"
#import "XHSettingItemLabel.h"
#import "XHSettingItemSwitch.h"
#import "XHSettingCustom.h"
@interface XHSettingTableViewCell()
// 箭头
@property(nonatomic,strong) UIImageView *arrowView;
// 开关
@property(nonatomic,strong) UISwitch *switchView;
// 分割线
@property(nonatomic,strong) UIView *lineView;
// 文本标签
@property(nonatomic,strong) UILabel *labelView;
// 自定义View标签
@property(nonatomic,strong) UIView *cusView;
@end
@implementation XHSettingTableViewCell
- (UIView *)cusView {
    
    if (_cusView ==nil) {
        _cusView =[[UIView alloc]init];
    }
    return _cusView;
}
- (UILabel *)labelView {
    if (_labelView == nil) {
        _labelView = [[UILabel alloc] init];
        _labelView.font = [UIFont systemFontOfSize:16];
        _labelView.textAlignment = NSTextAlignmentRight;
//        _labelView.textColor = CZColor(119,73,45);
        _labelView.frame = CGRectMake(0, 0, 80, 20);
    }
    return _labelView;
}

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
//        _lineView.backgroundColor = CZColor(233, 228, 209);
        _lineView.alpha = 0.3;
    }
    return _lineView;
}

- (UISwitch *)switchView {
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchView;
}

- (void)valueChanged:(UISwitch *)sender{
    XHSettingItemSwitch *item = (XHSettingItemSwitch *)_item;
    item.on = sender.on;
}
+ (instancetype)cellWithTableView :(UITableView *)tableView{
    
    static NSString *ID = @"setting";
    XHSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID ];
    if (cell ==nil) {
        cell = [[XHSettingTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ( self =[super initWithStyle:style reuseIdentifier:reuseIdentifier] ) {
        
//设置cell 的样式
 
        self.lineView.backgroundColor =[UIColor lightGrayColor];
    }
    return self;
}

-  (void)setItem:(XHSettingItem *)item {

    _item = item;
    
    self.textLabel.text = item.title;
    
    
    if (item.icon) {
        
        self.imageView.image = [UIImage imageNamed:item.icon];
    }
    self.selectionStyle = UITableViewCellSelectionStyleDefault;

    if ([_item isKindOfClass:[XHSettingItemArrow class]]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }else if([_item isKindOfClass:[XHSettingCustom class]]){
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType =UITableViewCellAccessoryNone;
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        XHSettingCustom *cusView = (XHSettingCustom *)_item;
        [self.contentView addSubview:cusView.custom];
        self.cusView = cusView.custom;
        cusView.custom.frame =(CGRect) cusView.customFrame;

    }else if([_item isKindOfClass:[XHSettingItemSwitch class]]){
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType =UITableViewCellAccessoryNone;
        self.accessoryView = self.switchView;
        XHSettingItemSwitch *swi = (XHSettingItemSwitch *)_item;
        self.switchView.on = swi.on;
    }else if([_item isKindOfClass:[XHSettingItemLabel class]]){
        self.accessoryView = self.labelView;
        XHSettingItemLabel *lab = (XHSettingItemLabel *)_item;
        self.labelView.text = lab.value;
        }
    else {
        self.accessoryType = nil;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
}

- (void)didMoveToSuperview {
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
