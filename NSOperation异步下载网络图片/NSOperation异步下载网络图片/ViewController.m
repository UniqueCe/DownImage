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
#import "appCell.h"
//https://raw.githubusercontent.com/UniqueCe/DownImage/master/apps.json
@interface ViewController ()<UITableViewDataSource>

@end

@implementation ViewController
{
    NSArray *_arrayList;//存储json数据
    
    NSOperationQueue *_queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _queue = [[NSOperationQueue alloc]init];
    
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
#pragma mark - 设置TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _arrayList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    appCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    appModels *modelImage = _arrayList[indexPath.row];
    
    cell.modelCell = modelImage;
    
#pragma mark - NSOperationQueue下载网络图片
    NSBlockOperation *blockOper = [NSBlockOperation blockOperationWithBlock:^{
        
        NSURL *url = [NSURL URLWithString:modelImage.icon];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        UIImage *ima = [UIImage imageWithData:data];
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            cell.imageV.image = ima;
        }];
    }];
    //添加到队列
    [_queue addOperation:blockOper];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}
#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
