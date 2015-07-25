//
//  XHTitle2Content.h
//  XinHeEdu
//
//  Created by xing on 15/6/5.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XHTitle2Content : NSObject
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *content;
+(instancetype)modelWithTitle :(NSString *)title content:(NSString *)content;
@end
