//
//  DotaProgramViewController.h
//  NewDoLo
//
//  Created by 李志强 on 16/4/14.
//  Copyright © 2016年 男孩无衣. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iCarousel.h"

@interface DotaProgramViewController : BaseListViewController
@property(nonatomic,strong)NSString * playerID;
@property(nonatomic,strong)iCarousel *carousel;
@property(nonatomic,assign) BOOL reloadingFlag;
@end
