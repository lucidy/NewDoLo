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
@property(nonatomic,assign)NSInteger offset;
@end

@implementation DotaProgramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 每次加载刷新偏移量
    _offset = 50;
    
    // 请求数据
    NSString * URLStr = [NSString stringWithFormat:kDotaProgramListURL,self.playerID];
    [kGetDataTool requestDataByGetWithURL:URLStr Anticipation:^{
        [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeGradient];
    } Completion:^(BOOL isSuccess, NSDictionary *dict) {
        if (isSuccess) {
            [self.dataArray addObjectsFromArray:dict[@"videos"]];
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
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[ProgramInfoView alloc] initWithFrame:CGRectMake(0, 0, 300.0f, 300.0f)];
    }
    
    // 设置UIView上的属性的时候, 要把设置代码放到 if(view == nil) {...}的外面.
    ProgramListModel * model = [[ProgramListModel alloc] init];
    [model setValuesForKeysWithDictionary:self.dataArray[index]];
    
    ((ProgramInfoView *)view).programModel = model;
    
    
    // !!!!!!!!!! 被这句话坑惨了!!!! 没注意这句注释!!!哔了狗了!!!!!!
    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel

    return view;
}

- (NSInteger)numberOfPlaceholdersInCarousel:(__unused iCarousel *)carousel
{
    //note: placeholder views are only displayed on some carousels if wrapping is disabled
    return 2;
}

- (UIView *)carousel:(__unused iCarousel *)carousel placeholderViewAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if (index != 0) {
        // 加载更多数据并且刷新
        NSString * URLStr = [NSString stringWithFormat:kDotaProgramListURLOffSet,self.playerID,_offset];
        [kGetDataTool requestDataByGetWithURL:URLStr Anticipation:^{
            [SVProgressHUD showWithStatus:@"正在加载..." maskType:SVProgressHUDMaskTypeGradient];
        } Completion:^(BOOL isSuccess, NSDictionary *dict) {
            if (isSuccess && dict[@"videos"] > 0) {
                [self.dataArray addObjectsFromArray:dict[@"videos"]];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [self.carousel reloadData];
                });
                _offset += 50;
            }else{
                NSLog(@"数据请求失败");
            }
        }];
    }
    
    if (view == nil)
    {
        view = [[ProgramInfoView alloc] initWithFrame:CGRectMake(0, 0, 300.0f, 300.0f)];
    }
    
    return view;
}

- (CATransform3D)carousel:(__unused iCarousel *)carousel itemTransformForOffset:(CGFloat)offset baseTransform:(CATransform3D)transform
{
    //implement 'flip3D' style carousel
    transform = CATransform3DRotate(transform, M_PI / 8.0f, 0.0f, 1.0f, 0.0f);
    return CATransform3DTranslate(transform, 0.0f, 0.0f, offset * self.carousel.itemWidth);
}

- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    //customize carousel display
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            //normally you would hard-code this to YES or NO
            return NO;
        }
        case iCarouselOptionSpacing:
        {
            //add a bit of spacing between the item views
            return value * 1.05f;
        }
        case iCarouselOptionFadeMax:
        {
            if (self.carousel.type == iCarouselTypeCustom)
            {
                //set opacity based on distance from camera
                return 0.0f;
            }
            return value;
        }
        case iCarouselOptionShowBackfaces:
        case iCarouselOptionRadius:
        case iCarouselOptionAngle:
        case iCarouselOptionArc:
        case iCarouselOptionTilt:
        case iCarouselOptionCount:
        case iCarouselOptionFadeMin:
        case iCarouselOptionFadeMinAlpha:
        case iCarouselOptionFadeRange:
        case iCarouselOptionOffsetMultiplier:
        case iCarouselOptionVisibleItems:
        {
            return value;
        }
    }
}

// !!!: 懒加载
-(iCarousel *)carousel
{
    if (_carousel == nil) {
        _carousel = [[iCarousel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kBottomHeighSubLittle)];
        _carousel.dataSource = self;
        _carousel.delegate = self;
        _carousel.type = iCarouselTypeInvertedCylinder;
        [self.view addSubview:_carousel];
    }
    return _carousel;
}

-(NSMutableArray *)dataArray
{
    if(_dataArray == nil){
        _dataArray = [NSMutableArray array];
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
