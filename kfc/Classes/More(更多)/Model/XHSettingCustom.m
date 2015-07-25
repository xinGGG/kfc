//
//  XHSettingCustom.m
//  XinHeEdu
//
//  Created by xing on 15/6/4.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import "XHSettingCustom.h"

@implementation XHSettingCustom
+ (instancetype)itemCustomView:(UIView *)customView frame:(CGRect)frame{
    XHSettingCustom *item = [[self alloc]init];
    item.custom = customView ;
    item.customFrame = frame;
    return item;
}
@end
