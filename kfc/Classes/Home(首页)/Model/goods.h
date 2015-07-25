//
//  goods.h
//  kfc
//
//  Created by xing on 15/6/15.
//  Copyright (c) 2015年 ljx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface goods : NSObject

//"c": [
//      "伴鸡伴虾堡"
//      ],
//"h": 283,
//"i": "http://youhui.kfc.com.cn/UploadFile/image/20150526/20150526100032_2444.jpg",
//"l": "http://youhui.kfc.com.cn/UploadFile/image/20150526/20150526100032_2444.jpg",
//"p": 17.5,
//"s": 1.5,
//"t": "C10"

///商品名字
@property (nonatomic,strong)NSArray *c;
///图片1
@property (nonatomic,copy)NSString *i;
///图片2
@property (nonatomic,copy)NSString *l;
///现在价格
@property (nonatomic,copy)NSNumber *p;
///节省金额
@property (nonatomic,copy)NSNumber *s;
///编号代码
@property (nonatomic,copy)NSString *t;

@property(nonatomic,copy)NSString *h;
///是否添加到购物车
@property (nonatomic,assign)BOOL isInList;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)goodsWithDict:(NSDictionary *)dict;

+ (instancetype)shopName:(NSArray *)c image1:(NSString*)i image2:(NSString *)l price:(NSNumber *)p lessPrice:(NSNumber *)s id:(NSString *)t;
@end
