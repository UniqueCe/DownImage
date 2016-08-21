//
//  appCell.h
//  NSOperation异步下载网络图片
//
//  Created by 刘培策 on 16/8/21.
//  Copyright © 2016年 刘培策. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "appModels.h"

@interface appCell : UITableViewCell

@property(nonatomic,strong) appModels *modelCell;

@property(nonatomic,weak)IBOutlet UIImageView *imageV;

@end
