//
//  XHSettingTableViewCell.h
//  XinHeEdu
//
//  Created by xing on 15/6/4.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XHSettingItem;
@class XHSettingCustom;
@interface XHSettingTableViewCell : UITableViewCell

+ (instancetype)cellWithTableView :(UITableView *)tableView;
@property (nonatomic,strong)XHSettingItem *item;
@property (nonatomic,strong)XHSettingCustom *customView;
@end
