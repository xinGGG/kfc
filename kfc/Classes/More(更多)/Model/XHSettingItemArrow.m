//
//  XHSettingItemArrow.m
//  XinHeEdu
//
//  Created by xing on 15/6/4.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import "XHSettingItemArrow.h"
@implementation XHSettingItemArrow

+ (instancetype)itemWithTitle:(NSString *)title desVC:(Class)desVC{
    
    XHSettingItemArrow *item = [self itemWithTitle:title];
    item.desVC = desVC ;
    return item;
}

@end
