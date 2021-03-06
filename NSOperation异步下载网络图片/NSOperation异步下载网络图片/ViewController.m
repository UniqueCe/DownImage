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
#import "NSString+path.h"
//https://raw.githubusercontent.com/UniqueCe/DownImage/master/apps.json
@interface ViewController ()<UITableViewDataSource>

@end

@implementation ViewController
{
    NSArray *_arrayList;//存储json数据
    
    NSOperationQueue *_queue;
    
    NSMutableDictionary *_dictImage;//图片缓存池
    
    NSMutableDictionary *_cache;//操作缓存池
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _queue = [[NSOperationQueue alloc]init];
    
    _dictImage = [[NSMutableDictionary alloc]init];
    
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
        
        UIAlertController * alert = [UIAlertController  alertControllerWithTitle:@"提示" message:@"网络异常，请重新加载" preferredStyle:UIAlertControllerStyleAlert];

        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleCancel handler:nil]];
        
        [self presentViewController:alert animated:YES completion:nil];
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
#pragma mark - 判断本地图片缓存池是否有图片
    UIImage *image = [_dictImage objectForKey:modelImage.icon];
    
    if (image != nil)
    {  NSLog(@"缓存池--%@",modelImage.name);
        cell.imageV.image = image;
        
        return cell;
    }
    //MARK:在下载图片之前，设置占位符
    cell.imageV.image = [UIImage imageNamed:@"789"];
#pragma mark - 在建立下载操作之前,内存缓存判断之后,判断沙盒缓存
    UIImage *imageCache = [UIImage imageWithContentsOfFile:[modelImage.icon appendCachesPath]];
    
    if (imageCache) {
        //保存到图片缓存池
        [_dictImage setObject:imageCache forKey:modelImage.icon];
   
        cell.imageV.image = imageCache;
        
        return cell;
    }
#pragma mark - 判断下载操作是否存在
    if ([_cache objectForKey:modelImage.icon] != nil) {
        NSLog(@"正在下载--%@",modelImage.name);
        return cell;
    }
    
#pragma mark - NSOperationQueue下载网络图片
    NSBlockOperation *blockOper = [NSBlockOperation blockOperationWithBlock:^{
        
        //模拟网络延迟
        [NSThread sleepForTimeInterval:0.5];
        
        NSURL *url = [NSURL URLWithString:modelImage.icon];
        
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        UIImage *ima = [UIImage imageWithData:data];
        //MARK:实现沙盒缓存
        if (ima) {
            [data writeToFile:[modelImage.icon appendCachesPath] atomically:YES];
        }
        //主线程更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            //cell.imageV.image = ima;
            //MARK:把图片存储到缓存池
            if (ima != nil) {
                [_dictImage setObject:ima forKey:modelImage.icon];
                
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }
            //图片下载完后，删除操作缓存池
            [_cache removeObjectForKey:modelImage.icon];
        }];
    }];
    // 把下载操作添加到操作缓存池
    [_cache setObject:blockOper forKey:modelImage.icon];
    //添加到队列
    [_queue addOperation:blockOper];
    
    return cell;
}
#pragma mark - 处理内存警告
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [_dictImage removeAllObjects];
    
    [_cache removeAllObjects];
    
    [_queue cancelAllOperations];
}
#pragma mark - 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}

@end
