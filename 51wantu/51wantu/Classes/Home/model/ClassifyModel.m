//
//  ClassifyModel.m
//  51wantu
//
//  Created by elaine on 15/8/13.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "ClassifyModel.h"

static NSArray *bigCate = nil;
static NSArray *subCate = nil;
static NSArray *brandCate = nil;
static NSArray *bigCateClassify = nil;

@implementation ClassifyModel
+ (NSArray *)getBigCate
{
    if (bigCate == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"bigcate" ofType:@"plist"];
        return [NSArray arrayWithContentsOfFile:path];
    }
    return bigCate;
    
}


+ (NSArray *)getSubCate
{
    if (subCate == nil) {
       NSString *path = [[NSBundle mainBundle] pathForResource:@"subcate" ofType:@"plist"];
        return [NSArray arrayWithContentsOfFile:path];
    }
    return subCate;
    
}

+ (NSArray *)getBrandCate
{
    if (brandCate == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"brandcate" ofType:@"plist"];
        return [NSArray arrayWithContentsOfFile:path];
    }
    return brandCate;
}

+ (NSArray *)getBigCateClassify
{
    
    if (bigCateClassify == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"bigcateclassify" ofType:@"plist"];
        return [NSArray arrayWithContentsOfFile:path];
    }
    return bigCateClassify;
}
@end
