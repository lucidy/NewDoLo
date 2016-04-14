//
//  PlayerTableViewCell.m
//  NewDoLo
//
//  Created by 李志强 on 16/4/13.
//  Copyright © 2016年 男孩无衣. All rights reserved.
//

#import "PlayerTableViewCell.h"

@implementation PlayerTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.contentView.backgroundColor = [UIColor clearColor];
        
        _headImageView = [UIImageView new];
        _headImageView.image = [UIImage imageNamed:@"placeholder.png"];
        
        _titleLabel = [UILabel new];
        _titleLabel.backgroundColor = [UIColor clearColor];
        
        _dateLabel = [UILabel new];
        _dateLabel.backgroundColor = [UIColor clearColor];
        
        _flagView = [UIView new];
        _flagView.backgroundColor = [UIColor clearColor ];

        _borderView = [UIView new];
        _borderView.backgroundColor = [UIColor clearColor];
        
        CALayer * layer = [_borderView layer];
        layer.borderColor = [[UIColor orangeColor] CGColor];
        layer.borderWidth = 1.0f;
        
        // 将所有的视图一次性添加到父视图上, 注意这里是添加到了tableView的contentView上去了.
        [self.contentView sd_addSubviews:@[_headImageView,_titleLabel,_dateLabel,_flagView,_borderView]];
        
        // 开始对每个子视图进行约束.
        _borderView.sd_layout
        .topSpaceToView(self.contentView,5)
        .bottomSpaceToView(self.contentView,5)
        .leftSpaceToView(self.contentView,5)
        .rightSpaceToView(self.contentView,5);
        
        _headImageView.sd_layout
        .widthIs(75)
        .heightIs(75)
        .topSpaceToView(self.contentView, 10) // 距顶端
        .leftSpaceToView(self.contentView, 10); // 举例左端
        
        _flagView.sd_layout
        .rightSpaceToView(self.contentView, 10)
        .topSpaceToView(self.contentView,10)
        .bottomSpaceToView(self.contentView,10)
        .widthIs(75);

        _titleLabel.sd_layout
        .topEqualToView(_headImageView) // 和_view0等高
        .leftSpaceToView(_headImageView, 10) // 左边距离_view0 10个像素
        .rightSpaceToView(_flagView, 10) // 右边
        .heightRatioToView(_headImageView, 0.4); // 高度是_view0的0.4倍.
        
        _dateLabel.sd_layout
        .topSpaceToView(_titleLabel,25)
        .rightSpaceToView(_flagView, 10)
        .leftEqualToView(_titleLabel)
        .autoHeightRatio(0);

        //***********************高度自适应cell设置步骤************************
        [self setupAutoHeightWithBottomView:_dateLabel bottomMargin:10];
    }
    return self;
}

-(void)setModel:(PlayerListModel *)model
{
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.icon]];
    _titleLabel.text = model.name;
    _dateLabel.text = model.detail;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
