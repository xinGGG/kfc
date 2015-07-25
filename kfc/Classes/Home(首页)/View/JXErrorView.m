//
//  JXErrorView.m
//  kfc
//
//  Created by xing on 15/6/17.
//  Copyright (c) 2015年 ljx. All rights reserved.
//

#import "JXErrorView.h"

@implementation JXErrorView

+ (JXErrorView *)errorView{

    JXErrorView *view = [[[NSBundle mainBundle]loadNibNamed:@"JXErrorView" owner:self options:nil] lastObject];
    return view;
}
- (IBAction)btnClick:(id)sender {
    if ([self.delegate respondsToSelector:@selector(errorViewClick:)]) {
        [self.delegate errorViewClick:self];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
