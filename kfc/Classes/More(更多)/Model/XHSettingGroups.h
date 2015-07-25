//
//  XHSettingGroups.h
//  XinHeEdu
//
//  Created by xing on 15/6/4.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHSettingGroups : NSObject
//每组头部文字
@property (nonatomic,strong) NSString *headerTitle;;
//每组脚步文字
@property (nonatomic,strong) NSString *footerTitle;
//每组含有的item模型
@property (nonatomic,strong) NSArray *items;
//快速创建items
+(instancetype)arrayWithItems:(NSArray *)items;
@end
