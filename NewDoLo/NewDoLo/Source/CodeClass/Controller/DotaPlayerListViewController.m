//
//  DotaPlayerListViewController.m
//  NewDoLo
//
//  Created by 李志强 on 16/4/12.
//  Copyright © 2016年 男孩无衣. All rights reserved.
//

#import "DotaPlayerListViewController.h"

@interface DotaPlayerListViewController ()<UITableViewDelegate,UITableViewDataSource>
// 为table布局的数组, 因为封装的单例类方法没有做json进一步解析, 所以这个动作需要我们自己来做.
@property(nonatomic,strong)NSMutableArray * dotaPlayerListDataArray;
@property(nonatomic,strong)UITableView * tableView;
@end

@implementation DotaPlayerListViewController

// 直接用一个tableView替换当前控制器的View
-(void)loadView
{
    self.tableView = [[UITableView alloc]initWithFrame:kScreenFrame style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.view = _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // [self getDataWithIncrement:NO];
    
    // 注册tableView
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    // TableView刷新部分
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        NSLog(@"进行了一次刷新");
    }];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 请求数据, 参数表示是否在原数组中继续增加数据, 还是清空数据. NO表示不增加(清空)
-(void)getDataWithIncrement:(BOOL)Flag
{
    // 请求数据测试
    [kGetDataTool requestDataByGetWithURL:kDotaPlayerListURL Anticipation:^{
        // 数据请求开始弹出菊花
        [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeGradient];
    } Completion:^(BOOL isSuccess, NSDictionary *dict) {
        if (isSuccess) {
            if (Flag == NO) {
                [self.dotaPlayerListDataArray removeAllObjects];
                self.dotaPlayerListDataArray = dict[@"authors"]; // 这里涉及了一些数据解析, 为了简化接口, 将解析工作放到Controller中来做了(主要是因为简单).
            }else
            {
                [self.dotaPlayerListDataArray addObjectsFromArray:dict[@"authors"]];
            }
        }else
        {
            NSLog(@"数据请求失败");
        }
        // 菊花消失, 刷新UI.
        dispatch_async(dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            // reloadData
            [self.tableView reloadData];
        });
    }];
}

// !!!: 代理方法
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dotaPlayerListDataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.textLabel.text = @"测试数据";
    
    return cell;
}

// !!!: 懒加载
-(NSMutableArray *)dotaPlayerListDataArray
{
    if (_dotaPlayerListDataArray == nil) {
        _dotaPlayerListDataArray = [NSMutableArray array];
    }
    return _dotaPlayerListDataArray;
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
