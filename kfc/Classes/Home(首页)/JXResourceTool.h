//
//  JXResourceTool.h
//  kfc
//
//  Created by xing on 15/7/12.
//  Copyright (c) 2015年 ljx. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^saveSuccessful)();
typedef void(^readSuccessful)(NSMutableArray *arrM);

@interface JXResourceTool : NSObject
+ (void)setupDataList:(NSMutableArray *)dataList saveSuccessful:(saveSuccessful)block;
+ (void)readDataList:(readSuccessful)block;

@end
