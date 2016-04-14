//
//  GetDataTool.m
//  NewDoLo
//
//  Created by 李志强 on 16/4/13.
//  Copyright © 2016年 男孩无衣. All rights reserved.
//

#import "GetDataTool.h"

@interface GetDataTool ()

@end

@implementation GetDataTool

// 实现单利方法
+(instancetype)shareGetDataTool
{
    static GetDataTool * sb = nil;
    if (sb == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sb = [[GetDataTool alloc] init];
        });
    }
    return sb;
}

// 根据传入的接口地址, 下载数据并且解析, 返回字典.
-(void)requestDataByGetWithURL:(NSString *)URLStr Anticipation:(anticipation)anticipation Completion:(completion)completion
{
    // 预处理动作
    if (anticipation != nil) {
        anticipation();
    }
    
    // 数据请求
    // 1Business.BusinessCenter.Detail.创建URL对象
    NSURL *url = [NSURL URLWithString:URLStr];
    // 2.创建request对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 3.创建seccon对象
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 4.发起网络请求，建立连接，请求数据
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data != nil) {
            // 解析数据
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            
            // block回调返回结果
            if (completion != nil) {
                completion(YES, dict);
            }
        }else // 返回失败, 没有返回错误码. 如有需要, 请在此打断点.
        {
            if (completion != nil) {
                completion(NO, nil);
            }
        }
    }];
    
    [task resume];
}


@end
