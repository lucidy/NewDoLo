//
//  PlayerTableViewCell.h
//  NewDoLo
//
//  Created by 李志强 on 16/4/13.
//  Copyright © 2016年 男孩无衣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlayerListModel.h"

// 这个cell做iPhone和iPad的适配
// 使用SDAutoLayout做代码约束

@interface PlayerTableViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView * headImageView;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * dateLabel;
@property(nonatomic,strong)UIView * flagView;
@property(nonatomic,strong)UIView * borderView;
@property(nonatomic,strong)PlayerListModel * model;
@end
