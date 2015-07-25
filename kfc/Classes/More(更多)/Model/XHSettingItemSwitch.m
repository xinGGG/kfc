//
//  XHSettingItemSwitch.m
//  XinHeEdu
//
//  Created by xing on 15/6/4.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import "XHSettingItemSwitch.h"

@implementation XHSettingItemSwitch
- (void)setOn:(BOOL)on {
    _on =on;
    NSUserDefaults *defauls = [NSUserDefaults standardUserDefaults];
    [defauls setBool:on forKey:self.title];
    [defauls synchronize];
}
-(void)setTitle:(NSString *)title {
    
    [super setTitle:title];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    _on = [defaults boolForKey:title];
    
}
@end
