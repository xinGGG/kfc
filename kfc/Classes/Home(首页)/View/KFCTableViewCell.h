//
//  KFCTableViewCell.h
//  kfc
//
//  Created by xing on 15/6/15.
//  Copyright (c) 2015年 ljx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class goods,KFCTableViewCell;

@protocol KFCTableViewCellDelegate <NSObject>

///图片点击代理方法
- (void)TabelCellImageClick:(KFCTableViewCell *)cell;
- (void)shareCellBtnClick:(KFCTableViewCell *)cell;
- (void)addListBtnClick:(KFCTableViewCell *)cell;
@end

@interface KFCTableViewCell : UITableViewCell
///快速创建cell
+ (instancetype)cell:(UITableView *)tableView;
///商品模型导入
@property (nonatomic,strong)goods *good;
///cell图片
@property (weak, nonatomic) IBOutlet UIImageView *img;
///cell图片点击代理
@property (nonatomic,weak)id <KFCTableViewCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIButton *addList;

//@property (nonatomic,assign)NSInteger index;

@end
