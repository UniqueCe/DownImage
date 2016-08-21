//
//  appCell.m
//  NSOperation异步下载网络图片
//
//  Created by 刘培策 on 16/8/21.
//  Copyright © 2016年 刘培策. All rights reserved.
//

#import "appCell.h"

@interface appCell ()

@property(nonatomic,weak)IBOutlet UILabel *nameLabel;

@property(nonatomic,weak)IBOutlet UILabel *downloadLabel;

@end

@implementation appCell
#pragma mark - 重写set赋值
- (void)setModelCell:(appModels *)modelCell
{
    _modelCell = modelCell;
    
    self.nameLabel.text = modelCell.name;
    
    self.downloadLabel.text = modelCell.download;
}





@end
