//
//  UIImage+Extension.m
//  网易彩票练习No2
//
//  Created by xing on 15/6/1.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)
+ (UIImage *)resizeImgWithName:(NSString *)name{

    UIImage *img = [UIImage imageNamed:name];
    CGFloat height = img.size.height*0.5;
    CGFloat width = img.size.width*0.5;
    return [img resizableImageWithCapInsets:UIEdgeInsetsMake(height, width, height, width) resizingMode:UIImageResizingModeStretch];

}
@end
