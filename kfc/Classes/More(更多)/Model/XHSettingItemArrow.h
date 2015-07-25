//
//  XHSettingItemArrow.h
//  XinHeEdu
//
//  Created by xing on 15/6/4.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import "XHSettingItem.h"

@interface XHSettingItemArrow : XHSettingItem
@property (nonatomic,assign)Class desVC;
+ (instancetype)itemWithTitle:(NSString *)title desVC:(Class)desVC;
@end
