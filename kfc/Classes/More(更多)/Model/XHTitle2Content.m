//
//  XHTitle2Content.m
//  XinHeEdu
//
//  Created by xing on 15/6/5.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import "XHTitle2Content.h"

@implementation XHTitle2Content
+(instancetype)modelWithTitle :(NSString *)title content:(NSString *)content{

    XHTitle2Content *model = [[self alloc]init];
    
    model.title = title;
    
    model.content = content;
    
    return model;
}

@end
