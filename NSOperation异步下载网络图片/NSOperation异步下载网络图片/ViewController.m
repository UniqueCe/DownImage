//
//  ViewController.m
//  NSOperation异步下载网络图片
//
//  Created by 刘培策 on 16/8/21.
//  Copyright © 2016年 刘培策. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "appModels.h"
//https://raw.githubusercontent.com/UniqueCe/DownImage/master/apps.json
@interface ViewController ()

@end

@implementation ViewController
{
    NSArray *_arrayList;//存储json数据
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self downLoadData];
}
#pragma mark - 解析数据
- (void)downLoadData
{
    //创建网路管理者
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc]init];
    //网络地址
    NSString *strURL = @"https://raw.githubusercontent.com/UniqueCe/DownImage/master/apps.json";
    //发送GET请求网络数据
    [manager GET:strURL parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *responseObject) {
        
        NSMutableArray *tempM = [[NSMutableArray alloc]initWithCapacity:_arrayList.count];
        
        [responseObject enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            appModels *model = [appModels appWithDictionary:obj];
            
            [tempM addObject:model];
        }];
        
        _arrayList = tempM.copy;
        
        [self.tableView reloadData];
  
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
   
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
