//
//  JXEmptyView.m
//  kfc
//
//  Created by xing on 15/6/20.
//  Copyright (c) 2015年 ljx. All rights reserved.
//

#import "JXEmptyView.h"

@implementation JXEmptyView

+ (JXEmptyView *)emptyView{
    
    JXEmptyView *view = [[[NSBundle mainBundle]loadNibNamed:@"JXEmptyView" owner:self options:nil] lastObject];
    return view;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
