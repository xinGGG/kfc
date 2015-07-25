//
//  XHSettingItemLabel.m
//  XinHeEdu
//
//  Created by xing on 15/6/4.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import "XHSettingItemLabel.h"

@implementation XHSettingItemLabel
+ (instancetype)settingItemWithTitle:(NSString *)title defaults:(NSString *)defaults{
    
    XHSettingItemLabel *item = [self itemWithTitle:title];
    if (item.value.length == 0 || item.value == nil) {
        item.value = defaults;
    }
    return item;
}
@end
