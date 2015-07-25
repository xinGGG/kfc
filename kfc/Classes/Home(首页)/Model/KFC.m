//
//  KFC.m
//  kfc
//
//  Created by xing on 15/6/15.
//  Copyright (c) 2015年 ljx. All rights reserved.
//

#import "KFC.h"
#import "goods.h"
@implementation KFC

//- (instancetype)initWithDict:(NSDictionary *)dict{
//    if (self = [super init]) {
//        
//        [self setValuesForKeysWithDictionary:dict];
//      
//        NSMutableArray *arrM = [NSMutableArray array];
//        for (NSDictionary *dict in self.m) {
//            goods *good = [goods goodsWithDict:dict];
//            [arrM addObject:good];
//        }
//        self.m = arrM;
//    }
//    return self;
//}
//
//+ (instancetype)kfcWithDict:(NSDictionary *)dict{
//    return  [[self alloc]initWithDict:dict];
//}



//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.e forKey:@"e"];
    [encoder encodeObject:self.s forKey:@"s"];
    [encoder encodeObject:self.fp forKey:@"fp"];
    [encoder encodeObject:self.m forKey:@"m"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.e = [decoder decodeObjectForKey:@"e"];
        self.s = [decoder decodeObjectForKey:@"s"];
        self.fp = [decoder decodeObjectForKey:@"fp"];
        self.m = [decoder decodeObjectForKey:@"m"];
    }
    return self;
}
@end
