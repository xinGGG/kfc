//
//  JXConnectionTool.h
//  kfc
//
//  Created by xing on 15/7/12.
//  Copyright (c) 2015年 ljx. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^connectionBlock)(NSURLResponse *response, NSData *data, NSError *connectionError);
@interface JXConnectionTool : NSObject
+ (instancetype)connectionWithBlock:(connectionBlock)block;

@end
