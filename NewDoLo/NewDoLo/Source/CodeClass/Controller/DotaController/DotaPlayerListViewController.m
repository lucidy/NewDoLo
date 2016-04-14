//
//  DotaPlayerListViewController.m
//  NewDoLo
//
//  Created by 李志强 on 16/4/12.
//  Copyright © 2016年 男孩无衣. All rights reserved.
//

#import "DotaPlayerListViewController.h"

@interface DotaPlayerListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)NSMutableArray * dotaPlayerListDataArray;
@property(nonatomic,strong)BaseTableView * tableView;
@end

@implementation DotaPlayerListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [kGetDataTool requestDataByGetWithURL:kDotaPlayerListURL Anticipation:^{
        // 数据请求开始弹出菊花
        [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeGradient];
    } Completion:^(BOOL isSuccess, NSDictionary *dict) {
        if (isSuccess) {
            self.dotaPlayerListDataArray = dict[@"authors"];
            // 回到主线程修改UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                [self.tableView reloadData];
            });
        }else
        {
            NSLog(@"数据请求失败");
        }
    }];
    
    // TableView下拉刷新部分
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [kGetDataTool requestDataByGetWithURL:kDotaPlayerListURL Anticipation:nil Completion:^(BOOL isSuccess, NSDictionary *dict) {
            if (isSuccess) {
                self.dotaPlayerListDataArray = dict[@"authors"];
                // 回到主线程修改UI
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                    [self.tableView.mj_header endRefreshing];
                });
            }else
            {
                NSLog(@"数据请求失败");
            }
        }];
    }];
    
    // 设置navigation的背景图
    backgroundImgView = [[UIImageView alloc] initWithFrame:kScreenFrame];
    backgroundImgView.image = [UIImage imageNamed:@"backRound.png"];
    UIView *alphView = [[UIView alloc] initWithFrame:kScreenFrame];
    alphView.backgroundColor = kBackbroundColorAlpha;
    [backgroundImgView addSubview:alphView];
    [self.navigationController.view addSubview:backgroundImgView];
    [self.navigationController.view sendSubviewToBack:backgroundImgView];
        
    // 滑动时候, 使navigationController隐藏
    self.navigationController.hidesBarsOnSwipe = YES;
    
    // 设置导航栏的毛玻璃效果
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// !!!: 代理方法
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dotaPlayerListDataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PlayerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[PlayerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    NSDictionary * dict = self.dotaPlayerListDataArray[indexPath.row];
    PlayerListModel * model = [PlayerListModel new];
    [model setValuesForKeysWithDictionary:dict];
    
    cell.model = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dict = self.dotaPlayerListDataArray[indexPath.row];
    PlayerListModel * model = [PlayerListModel new];
    [model setValuesForKeysWithDictionary:dict];
    
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤2 * >>>>>>>>>>>>>>>>>>>>>>>>
    /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
    return [self.tableView cellHeightForIndexPath:indexPath
                                            model:model
                                          keyPath:@"model"
                                        cellClass:[PlayerTableViewCell class]
                                 contentViewWidth:[self cellContentViewWith]
            ];
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

// !!!: 懒加载
-(NSMutableArray *)dotaPlayerListDataArray
{
    if (_dotaPlayerListDataArray == nil) {
        _dotaPlayerListDataArray = [NSMutableArray array];
    }
    return _dotaPlayerListDataArray;
}

-(UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 60) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        self.tableView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_tableView];
    }
    return _tableView;
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
