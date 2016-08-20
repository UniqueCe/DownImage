//
//  DownloadOperation.m
//  仿SDWebImage
//
//  Created by 刘培策 on 16/8/20.
//  Copyright © 2016年 刘培策. All rights reserved.
//

#import "DownloadOperation.h"

@interface DownloadOperation ()

@property(nonatomic,copy)NSString *URLString;

@property(nonatomic,copy)void(^finishBlock)(UIImage *image);

@end


@implementation DownloadOperation

+ (instancetype)downloadWithURL:(NSString *)URLStr andfinishedBlock:(void (^)(UIImage *))finishBlcok
{
    DownloadOperation *op = [[self alloc]init];
    
    op.URLString = URLStr;
    op.finishBlock = finishBlcok;
    
    return op;
}

@end
