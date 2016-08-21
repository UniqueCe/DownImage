//
//  appModels.m
//  NSOperation异步下载网络图片
//
//  Created by 刘培策 on 16/8/21.
//  Copyright © 2016年 刘培策. All rights reserved.
//

#import "appModels.h"

@implementation appModels

+ (instancetype)appWithDictionary:(NSDictionary *)dict
{
    appModels *model = [[self alloc]init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}
#pragma mark - 防止Model里的数据没有声明而崩溃
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

@end
