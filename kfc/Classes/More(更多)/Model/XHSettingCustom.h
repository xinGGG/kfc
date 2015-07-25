//
//  XHSettingCustom.h
//  XinHeEdu
//
//  Created by xing on 15/6/4.
//  Copyright (c) 2015年 xing. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "XHSettingItem.h"

@interface XHSettingCustom : XHSettingItem
@property (nonatomic,strong)UIView *custom;
@property (nonatomic,assign)CGRect customFrame;

//自定义cell的内容view
+ (instancetype)itemCustomView:(UIView *)customView frame:(CGRect)frame;

@end
