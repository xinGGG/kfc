//
//  goods.m
//  kfc
//
//  Created by xing on 15/6/15.
//  Copyright (c) 2015年 ljx. All rights reserved.
//

#import "goods.h"

@implementation goods
- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)goodsWithDict:(NSDictionary *)dict{
    return [[self alloc]initWithDict:dict];
}



+ (instancetype)shopName:(NSArray *)c image1:(NSString*)i image2:(NSString *)l price:(NSNumber *)p lessPrice:(NSNumber *)s id:(NSString *)t isInList:(BOOL)isInList{
    goods *good = [[goods alloc]init];
    good.c = c;
    good.i = i ;
    good.l = l;
    good.p = p;
    good.s = s;
    good.t = t;
    good.isInList =isInList;
    return good;
 }

//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.c forKey:@"c"];
    [encoder encodeObject:self.i forKey:@"i"];
    [encoder encodeObject:self.l forKey:@"l"];
    [encoder encodeObject:self.p forKey:@"p"];
    [encoder encodeObject:self.s forKey:@"s"];
    [encoder encodeObject:self.t forKey:@"t"];
    [encoder encodeObject:self.h forKey:@"h"];
    [encoder encodeBool:self.isInList forKey:@"isInList"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.c = [decoder decodeObjectForKey:@"c"];
        self.i = [decoder decodeObjectForKey:@"i"];
        self.l = [decoder decodeObjectForKey:@"l"];
        self.p = [decoder decodeObjectForKey:@"p"];
        self.s = [decoder decodeObjectForKey:@"s"];
        self.t = [decoder decodeObjectForKey:@"t"];
        self.h = [decoder decodeObjectForKey:@"h"];
        self.isInList = [decoder decodeBoolForKey:@"isInList"];
    }
    return self;
}

@end
