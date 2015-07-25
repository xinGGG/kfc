//
//  XHSettingItem.m
//  XinHeEdu
//
//  Created by xing on 15/6/4.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import "XHSettingItem.h"

@implementation XHSettingItem
+ (instancetype)itemWithTitle:(NSString *)title {
    XHSettingItem *item = [[self alloc]init];
    item.title = title;
    return item;
}

@end
