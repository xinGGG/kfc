//
//  JXListTableViewCell.h
//  一元夺宝
//
//  Created by xing on 15/5/22.
//  Copyright (c) 2015年 xing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  goods,JXListTableViewCell;

@protocol ListTableViewCellDelegate <NSObject>
- (void)ListCountChangeClick:(JXListTableViewCell *)cell ;
@end

@interface JXListTableViewCell : UITableViewCell
@property (nonatomic,weak)id <ListTableViewCellDelegate> delegate;
@property (nonatomic,strong) goods *good;
+ (instancetype)ListCell:(UITableView *)tableView;
@end
