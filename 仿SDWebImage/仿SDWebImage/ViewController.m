//
//  ViewController.m
//  仿SDWebImage
//
//  Created by 刘培策 on 16/8/20.
//  Copyright © 2016年 刘培策. All rights reserved.
//

#import "ViewController.h"
#import "DownloadOperation.h"

@interface ViewController ()

@property(nonatomic,weak) IBOutlet UIImageView *imageVi;

@end

@implementation ViewController
{
    NSOperationQueue *_queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _queue = [[NSOperationQueue alloc]init];
    
    NSString *urlStr = @"http://img2.3lian.com/2014/c7/12/d/77.jpg";
    
    DownloadOperation *op = [DownloadOperation downloadWithURL:urlStr andfinishedBlock:^(UIImage *im) {
        
        self.imageVi.image = im;
        
        NSLog(@"%@-%@",[NSThread currentThread],im);
    }];
    
    [_queue addOperation:op];
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}

@end
