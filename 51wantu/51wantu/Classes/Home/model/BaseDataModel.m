//
//  BaseDataModel.m
//  51wantu
//
//  Created by elaine on 15/8/8.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "BaseDataModel.h"
#import "MJExtension.h"

@implementation BaseDataModel
+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}
@end
