//
//  JXErrorView.h
//  kfc
//
//  Created by xing on 15/6/17.
//  Copyright (c) 2015年 ljx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JXErrorView;
@protocol JXErrorViewDelegate <NSObject>

@optional
-(void)errorViewClick:(JXErrorView *)errorView;
@end
@interface JXErrorView : UIView
+ (JXErrorView *)errorView;
@property (nonatomic,weak)id <JXErrorViewDelegate> delegate;
@end
