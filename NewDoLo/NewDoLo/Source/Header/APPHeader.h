//
//  APPHeader.h
//  ProjectMusic
//
//  Created by young on 15/7/31.
//  Copyright (c) 2015年 young. All rights reserved.
//  这里存放普通的app宏定义和声明等信息.

#ifndef Project_APPHeader_h
#define Project_APPHeader_h

// 屏幕尺寸宏
#define kScreenWidth  CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)
#define kScreenFrame [UIScreen mainScreen].bounds

#define kBackbroundColorAlpha [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2]

// 自定义tabbar
#import "CustomTabBarVC.h"

// 基类
#import "BaseTableView.h"
#import "BaseListViewController.h"

// 页面控制器
#import "DotaPlayerListViewController.h"
#import "LOLPlayerListViewController.h"
#import "SettingViewController.h"

// Cell
#import "PlayerTableViewCell.h"

// Model
#import "PlayerListModel.h"

// 数据请求方法单例类
#import "GetDataTool.h"
#define kGetDataTool [GetDataTool shareGetDataTool]

// SDWebImage
#import "UIImageView+WebCache.h"



#endif
