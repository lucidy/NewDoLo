//
//  GetDataTool.h
//  NewDoLo
//
//  Created by 李志强 on 16/4/13.
//  Copyright © 2016年 男孩无衣. All rights reserved.
//

// 本类使用 NSURLSession 类实现下载功能,
// 根据本App的需求, 暂时只提供Get方式请求数据
#import <Foundation/Foundation.h>

// Block回调返回处理结果
typedef void(^completion)(BOOL isSuccess, NSDictionary * dict);
// Block请求起始动作
typedef void(^anticipation)();

@interface GetDataTool : NSObject

// 单利方法, 数据请求时切换页面, 保证请求对象不能消失
+(instancetype)shareGetDataTool;

// 根据传入的接口地址, 下载数据并且解析, 返回字典.
-(void)requestDataByGetWithURL:(NSString *)URLStr Anticipation:(anticipation)anticipation Completion:(completion)completion;

@end
