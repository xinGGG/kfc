//
//  XHSettingGroups.m
//  XinHeEdu
//
//  Created by xing on 15/6/4.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import "XHSettingGroups.h"
@implementation XHSettingGroups
+(instancetype)arrayWithItems:(NSArray *)items{
    XHSettingGroups *group =[[XHSettingGroups alloc]init];
    group.items = items;
    return group;
}
@end
