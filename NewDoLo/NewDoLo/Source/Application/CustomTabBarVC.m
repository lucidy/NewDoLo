//
//  CustomTabBarVC.m
//  CustomTab
//
//  Created by Student on 16/3/14.
//  Copyright © 2016年 Student. All rights reserved.
//

#import "CustomTabBarVC.h"
#import "DotaPlayerListViewController.h"
#import "LOLPlayerListViewController.h"
#import "SettingViewController.h"

#define KWidthScreen [UIScreen mainScreen].bounds.size.width
#define KheightScreen [UIScreen mainScreen].bounds.size.height

#define kBottomHeigh 50
#define kBottomHeighSubLittle 40
#define kGap 10

@interface CustomTabBarVC () <UINavigationControllerDelegate>

@end

@implementation CustomTabBarVC
- (void)viewdidControl
{
    // Dota页面
    DotaPlayerListViewController * DotaVC = [[DotaPlayerListViewController alloc] init];
    DotaVC.navigationItem.title = @"Dota";
    UINavigationController * DotaNC = [[UINavigationController alloc]initWithRootViewController:DotaVC];
    
    // LOL页面
    LOLPlayerListViewController * LOLVC = [[LOLPlayerListViewController alloc]init];
    LOLVC.navigationItem.title = @"LOL";
    UINavigationController * LOLNC = [[UINavigationController alloc] initWithRootViewController:LOLVC];
    
    // 设置页面
    SettingViewController * settingVC = [[SettingViewController alloc]init];
    settingVC.navigationItem.title = @"中间";
    UINavigationController * settingNC = [[UINavigationController alloc] initWithRootViewController:settingVC];

    self.viewControllers = [NSArray arrayWithObjects:DotaNC,LOLNC,settingNC,nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 给程序第一运行时, selectedIndex一个特殊值.
    _selectedIndex = -1;
    
    // 创建几个视图控制器以及其NavigationController导航控制器.
    [self viewdidControl];
    
    // 定义一个底部视图, 这个视图控制器上面将挂载一些button.
    self.customView = [[UIView alloc] initWithFrame:CGRectMake(0, KheightScreen - kBottomHeigh, KWidthScreen, kBottomHeigh)];
    self.customView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.customView];
    
    // 未点击button效果
    self.nomalImageArray = [[NSArray alloc] initWithObjects:@"tabBar_dota.png",@"tabBar_lol.png",@"tabBar_mine.png", nil];
    
    // 点击button后效果
    self.hightlightedImageArray = [[NSArray alloc]initWithObjects:@"tabBar_dota.png",@"tabBar_lol.png",@"tabBar_mine.png",nil];
    
    // 设置tabbar的底片, 因为button的图片是镂空的,
    self.customImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, kBottomHeigh -kBottomHeighSubLittle , KWidthScreen, kBottomHeighSubLittle)];
    [self.customImageView setImage:[UIImage imageNamed:@"tabbar_background.png"]];
    [self.customView addSubview:self.customImageView];
    
    // 设置button的背景图片
    // OneBtn
    // 注意除了第三个button, 其他的button都是从y坐标的10处开始的. 中间的button是从0开始.
    self.oneBtn = [[UIButton alloc] initWithFrame:CGRectMake(kGap, kBottomHeigh -kBottomHeighSubLittle, (KWidthScreen - 6*kGap)/3.0, kBottomHeighSubLittle)];
    [self.oneBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_dota.png"] forState:UIControlStateNormal];
    self.oneBtn.tag = 1;
    [self.customView addSubview:self.oneBtn];
    
    // TwoBtn
    self.twoBtn = [[UIButton alloc] initWithFrame:CGRectMake(2 * KWidthScreen / 3.0 , kBottomHeigh -kBottomHeighSubLittle, (KWidthScreen) / 3, kBottomHeighSubLittle)];
    [self.twoBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_lol.png"] forState:UIControlStateNormal];
    self.twoBtn.tag = 2;
    [self.customView addSubview:self.twoBtn];
    
    // ThreeOne
    self.threeBtn = [[UIButton alloc]initWithFrame:CGRectMake(KWidthScreen/3.0, 0, (KWidthScreen) / 3, kBottomHeigh)];
    [self.threeBtn setBackgroundImage:[UIImage imageNamed:@"tabBar_mine.png"] forState:UIControlStateNormal];
    self.threeBtn.tag = 3;
    [self.customView addSubview:self.threeBtn];
    
    [self.oneBtn addTarget:self action:@selector(oneBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.twoBtn addTarget:self action:@selector(twoBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.threeBtn addTarget:self action:@selector(threeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    // 当布局成功后, 调用set方法将页面显示到第n个View上
    self.selectedIndex = 0;
}

#pragma mark ----切换视图选项
- (void)oneBtnAction:(UIButton *)sender
{
    self.selectedIndex = sender.tag - 1;
}

- (void)twoBtnAction:(UIButton *)sender
{
    
    self.selectedIndex = sender.tag - 1;
}

- (void)threeBtnAction:(UIButton *)sender
{
    self.selectedIndex = sender.tag - 1;
}


#pragma mark ----重写selectedIndex属性的set方法

- (void)setSelectedIndex:(NSInteger)aselectedIndex
{
    // 判断新的值与原来的值是否相等，相等则选择的任然是当前视图，不做处理
    if (aselectedIndex == _selectedIndex) {
        return;
    }
    
    if (_selectedIndex >= 0) {
        // 需要将前一个视图移除
        // 根据_selectedIndex从视图控制器数组中取出先前选中的视图
        UIViewController * previousViewController = [self.viewControllers objectAtIndex:_selectedIndex];
        [previousViewController.view removeFromSuperview];
        
        // 需要将前一个button的图片改为普通状态的图片
        UIButton * previousButton = (UIButton *)[self.view viewWithTag:_selectedIndex + 1];
        [previousButton setBackgroundImage:[UIImage imageNamed:[self.nomalImageArray objectAtIndex:_selectedIndex]] forState:UIControlStateNormal];
        
    }
    
    // 然后将新的aselectedIndex赋值给_selectedIndex
    _selectedIndex = aselectedIndex;
    // 显示新的视图
    UIViewController * currentViewController = [self.viewControllers objectAtIndex:_selectedIndex];
    // 找到当前button，将其背景图片改为高亮
    UIButton * currentBtn = [self.view viewWithTag:_selectedIndex+1];
    [currentBtn setBackgroundImage:[UIImage imageNamed:[self.hightlightedImageArray objectAtIndex:_selectedIndex]] forState:UIControlStateNormal];
    
    // 判断当前视图是否为导航控制器
    if ([currentViewController isKindOfClass:[UINavigationController class]])
    {
        // 表示这个视图是navgationController
        
        // 设置导航的代理
        
        ((UINavigationController *)currentViewController).delegate = self;
        
    }
    
    //设置当前视图的大小
    currentViewController.view.frame = CGRectMake(0, 0, KWidthScreen, KheightScreen);
    //添加到tab的view上
    [self.view addSubview:currentViewController.view];
    [self.view sendSubviewToBack:currentViewController.view];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
