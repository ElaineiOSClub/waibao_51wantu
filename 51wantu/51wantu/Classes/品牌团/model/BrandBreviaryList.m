//
//  BrandBreviaryList.m
//  51wantu
//
//  Created by elaine on 15/8/16.
//  Copyright (c) 2015年 elaine. All rights reserved.
//  品牌下三个展示列表

#import "BrandBreviaryList.h"
#import "MJExtension.h"

@implementation BrandBreviaryList

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{
             @"ID" : @"id"
             };
}

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"list" : @"BaseDataModel"
             };
}

@end
