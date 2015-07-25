//
//  XHSettingItem.h
//  XinHeEdu
//
//  Created by xing on 15/6/4.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^operationBlock)();
@interface XHSettingItem : NSObject
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)NSString *icon;
@property (nonatomic,copy)operationBlock block;

+ (instancetype)itemWithTitle:(NSString *)title;

@end