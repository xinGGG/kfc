//
//  KFC.h
//  kfc
//
//  Created by xing on 15/6/15.
//  Copyright (c) 2015年 ljx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KFC : NSObject

//最后更新时间
@property (nonatomic,copy)NSString *e;
//优惠有效期
@property (nonatomic,copy)NSString *s;
//array 计算价格总和
@property (nonatomic,strong)NSArray *fp;
//商品信息
@property (nonatomic,strong)NSArray *m;

//- (instancetype)initWithDict:(NSDictionary *)dict;
//+ (instancetype)kfcWithDict:(NSDictionary *)dict;
@end
