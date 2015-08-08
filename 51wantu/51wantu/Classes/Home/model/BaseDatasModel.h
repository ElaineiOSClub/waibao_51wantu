//
//  BaseDatasModel.h
//  51wantu
//
//  Created by elaine on 15/8/8.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseDatasModel : NSObject
@property (nonatomic, strong) NSMutableArray *datas;
@property (nonatomic, assign) NSInteger currentpage;
@property (nonatomic, assign) NSInteger totalnum;
@property (nonatomic, assign) NSInteger totalpage;
@property (nonatomic, assign) NSInteger pagesize;
@end
