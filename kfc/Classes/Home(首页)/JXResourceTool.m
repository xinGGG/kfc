//
//  JXResourceTool.m
//  kfc
//
//  Created by xing on 15/7/12.
//  Copyright (c) 2015年 ljx. All rights reserved.
//

#import "JXResourceTool.h"

@implementation JXResourceTool
+ (void)setupDataList:(NSMutableArray *)dataList saveSuccessful:(saveSuccessful)block{
    
//存档 本表格的数据源
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filedPath = [docPath stringByAppendingPathComponent:@"dataList.data"];
    [NSKeyedArchiver archiveRootObject:dataList toFile:filedPath];
    
    if (block) {
        block();
    }
}

+ (void)readDataList:(readSuccessful)block{
    //解档 本表格的数据源
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filedPath = [docPath stringByAppendingPathComponent:@"dataList.data"];
    
    NSMutableArray *arrM = [NSKeyedUnarchiver unarchiveObjectWithFile:filedPath];
    if (block) {
        block(arrM);
    }
}


@end
