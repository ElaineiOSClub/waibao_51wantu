//
//  BaseDatasModel.m
//  51wantu
//
//  Created by elaine on 15/8/8.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "BaseDatasModel.h"
#import "MJExtension.h"

@implementation BaseDatasModel

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"datas" : @"BaseDataModel"
             };
}

@end
