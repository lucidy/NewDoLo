//
//  ProgramListModel.m
//  NewDoLo
//
//  Created by 李志强 on 16/4/14.
//  Copyright © 2016年 男孩无衣. All rights reserved.
//

#import "ProgramListModel.h"

@implementation ProgramListModel
// ==========10.1
- (void)setValue:(id)value forKey:(NSString *)key {
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"date"]) {
        _date1 = value;
    }
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}
@end
