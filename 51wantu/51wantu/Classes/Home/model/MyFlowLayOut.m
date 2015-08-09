//
//  MyFlowLayOut.m
//  获取系统相册
//
//  Created by elaine on 15/2/3.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "MyFlowLayOut.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width

@implementation MyFlowLayOut

- (void)prepareLayout
{
    self.minimumInteritemSpacing = 5;
    self.minimumLineSpacing = 5;
    self.itemSize = CGSizeMake((kScreenW - 15)/3.0, (kScreenW - 15)/4.0);
   
}
@end
