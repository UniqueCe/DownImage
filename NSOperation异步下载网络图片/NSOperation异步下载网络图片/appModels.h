//
//  appModels.h
//  NSOperation异步下载网络图片
//
//  Created by 刘培策 on 16/8/21.
//  Copyright © 2016年 刘培策. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface appModels : NSObject

@property(nonatomic,copy) NSString *name;

@property(nonatomic,copy) NSString *doenload;

@property(nonatomic,copy) NSString *icon;

+ (instancetype)appWithDictionary:(NSDictionary *)dict;

/*
 {
 "name" : "植物大战僵尸",
 "download" : "10311万",
 "icon" : "http:\/\/p16.qhimg.com\/dr\/48_48_\/t0125e8d438ae9d2fbb.png"
 },
 */

@end
