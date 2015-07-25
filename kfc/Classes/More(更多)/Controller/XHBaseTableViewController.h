//
//  XHBaseTableViewController.h
//  XinHeEdu
//
//  Created by xing on 15/6/4.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XHSettingGroups.h"
#import "XHSettingItem.h"
#import "XHSettingItemArrow.h"
#import "XHSettingItemLabel.h"
#import "XHSettingItemSwitch.h"
#import "XHSettingCustom.h"
@interface XHBaseTableViewController : UITableViewController
@property (nonatomic,strong) NSMutableArray *items;

@end
