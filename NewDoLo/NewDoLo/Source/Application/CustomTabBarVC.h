//
//  CustomTabBarVC.h
//  CustomTab
//
//  Created by Student on 16/3/14.
//  Copyright © 2016年 Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabBarVC : UIViewController

- (void)viewdidControl;

//正常状态下的图片数组
@property (nonatomic, strong)NSArray * nomalImageArray;

//高亮状态下的图片数组
@property (nonatomic, strong)NSArray * hightlightedImageArray;

//添加两个属性，selectedIndex用来记录选中的是那一个视图（或button），viewControllers数组用来存放button点击对应的视图控制器
@property (nonatomic, assign)NSInteger selectedIndex;

@property (nonatomic, strong)NSArray * viewControllers;

@property (nonatomic, strong)UIView * customView;

@property (nonatomic, strong)UIImageView * customImageView;

//5个button
@property (nonatomic, strong)UIButton * oneBtn;

@property (nonatomic, strong)UIButton * twoBtn;

@property (nonatomic, strong)UIButton * threeBtn;
@end
