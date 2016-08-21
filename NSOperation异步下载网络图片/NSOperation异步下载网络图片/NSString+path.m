//
//  NSString+path.m
//  NSOperation异步下载网络图片
//
//  Created by 刘培策 on 16/8/21.
//  Copyright © 2016年 刘培策. All rights reserved.
//

#import "NSString+path.h"

@implementation NSString (path)

- (NSString *)appendCachesPath
{
    //获取沙盒路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    NSString *str = [self lastPathComponent];
    
    NSString *string = [path stringByAppendingPathComponent:str];
    
    return string;
}

@end
