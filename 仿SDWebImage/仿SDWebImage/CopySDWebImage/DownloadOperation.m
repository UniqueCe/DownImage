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
#pragma mark - 重写main方法
- (void)main
{
    NSLog(@"传入--%@",self.URLString);
    //下载图片
    NSURL *url = [NSURL URLWithString:self.URLString];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *ima = [UIImage imageWithData:data];
    //断言
    NSAssert(self.finishBlock !=nil, @"下载回调的值不能是nil");
    //把图片传到控制器
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        self.finishBlock(ima);
    }];
}


@end
