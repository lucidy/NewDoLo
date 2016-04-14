//
//  DotaProgramViewController.m
//  NewDoLo
//
//  Created by 李志强 on 16/4/14.
//  Copyright © 2016年 男孩无衣. All rights reserved.
//

#import "DotaProgramViewController.h"

@interface DotaProgramViewController ()<iCarouselDataSource, iCarouselDelegate>
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation DotaProgramViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 修改导航栏Item
    
    // 请求数据
    NSString * URLStr = [NSString stringWithFormat:kDotaProgramListURL,self.playerID,50];
    [kGetDataTool requestDataByGetWithURL:URLStr Anticipation:^{
        [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeGradient];
    } Completion:^(BOOL isSuccess, NSDictionary *dict) {
        if (isSuccess) {
                    self.dataArray = dict[@"videos"];
            // 回到主线程修改UI
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
                [self.carousel reloadData];
            });
        }else
        {
            NSLog(@"数据请求失败");
        }
    }];
    
    // Do any additional setup after loading the view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(__unused UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// !!!: iCarousel代理方法
- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    return [self.dataArray count];
}

// 返回每个Items的View
- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 300.0f, 300.0f)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"placeholder.png"];
        view.contentMode = UIViewContentModeCenter;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:30];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = self.dataArray[index][@"author"];
    
    return view;
}

- (NSInteger)numberOfPlaceholdersInCarousel:(__unused iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 2;
}

- (UIView *)carousel:(__unused iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        //don't do anything specific to the index within
        //this `if (view == nil) {...}` statement because the view will be
        //recycled and used with other index values later
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"placeholder.png"];
        view.contentMode = UIViewContentModeCenter;
        
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = UITextAlignmentCenter;
        label.font = [label.font fontWithSize:50.0f];
        label.tag = 1;
        [view addSubview:label];
    }
    else
    {
        //get a reference to the label in the recycled view
        label = (UILabel *)[view viewWithTag:1];
    }
    
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = (index == 0)? @"[": @"]";
    
    return view;
}

// !!!: 懒加载
-(iCarousel *)carousel
{
    if (_carousel == nil) {
        _carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kBottomHeighSubLittle)];
        _carousel.dataSource = self;
        _carousel.delegate = self;
        _carousel.type = iCarouselTypeCoverFlow2;
        [self.view addSubview:_carousel];
    }
    return _carousel;
}
-(NSArray *)dataArray
{
    if(_dataArray == nil){
        _dataArray = [NSArray array];
    }
    return _dataArray;
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
