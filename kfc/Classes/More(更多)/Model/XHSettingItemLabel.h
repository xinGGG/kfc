//
//  XHSettingItemLabel.h
//  XinHeEdu
//
//  Created by xing on 15/6/4.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import "XHSettingItem.h"

@interface XHSettingItemLabel : XHSettingItem
@property(nonatomic,copy) NSString *value;

+ (instancetype)settingItemWithTitle:(NSString *)title defaults:(NSString *)defaults;
@end
