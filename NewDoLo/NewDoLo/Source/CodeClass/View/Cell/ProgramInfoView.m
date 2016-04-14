//
//  ProgramInfoView.m
//  NewDoLo
//
//  Created by 李志强 on 16/4/14.
//  Copyright © 2016年 男孩无衣. All rights reserved.
//

#import "ProgramInfoView.h"

@interface ProgramInfoView ()
// 图片
@property(nonatomic,strong) UIImageView * programImageView;
// 时长
@property(nonatomic,strong) UILabel * timeLabel;
// 标题
@property(nonatomic,strong) UILabel * titleLabel;
// 时间
@property(nonatomic,strong) UILabel * dateLabel;
@end

@implementation ProgramInfoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_setup];
    }
    return self;
}

-(void)p_setup
{
    _programImageView = [UIImageView new];
    _programImageView.image = [UIImage imageNamed:@"placeholder.png"];
    
    _timeLabel = [UILabel new];
    _timeLabel.backgroundColor = [UIColor greenColor];
    
    _titleLabel = [UILabel new];
    _timeLabel.backgroundColor = [UIColor yellowColor];
    
    _dateLabel = [UILabel new];
    _dateLabel.backgroundColor = [UIColor blueColor];

    [self sd_addSubviews:@[_programImageView,_timeLabel,_titleLabel,_dateLabel]];
    
    _programImageView.sd_layout
    .topSpaceToView(self, 10)
    .leftSpaceToView(self, 10)
    .rightSpaceToView(self, 10)
    .heightIs(self.frame.size.height - 20);
    
    _timeLabel.sd_layout
    .leftEqualToView(_programImageView)
    .widthRatioToView(_programImageView,0.5)
    .heightIs(30)
    .topSpaceToView(_programImageView, 10);
    
    _dateLabel.sd_layout
    .leftSpaceToView(_timeLabel,0)
    .rightSpaceToView(self,10)
    .heightRatioToView(_timeLabel,1)
    .topEqualToView(_timeLabel);
    
    _titleLabel.sd_layout
    .leftEqualToView(_programImageView)
    .widthRatioToView(_programImageView,1)
    .topSpaceToView(_timeLabel, 10)
    .heightIs(30);
}

-(void)setProgramModel:(ProgramListModel *)programModel
{
    [_programImageView sd_setImageWithURL:[NSURL URLWithString:programModel.thumb]];
    _titleLabel.text = programModel.title;
    _dateLabel.text = programModel.date1;
    _timeLabel.text = programModel.time;
}

@end










