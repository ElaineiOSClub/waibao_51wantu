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

@implementation ClassifyModel
+ (NSArray *)getBigCate
{

    
    /*
     id--1
     2015-08-13 06:36:45.023 51wantu[86747:1226723] cate_name--9.9元包邮
     2015-08-13 06:36:45.023 51wantu[86747:1226723] id--2
     2015-08-13 06:36:45.023 51wantu[86747:1226723] cate_name--1-8折扣区
     2015-08-13 06:36:45.023 51wantu[86747:1226723] id--12
     2015-08-13 06:36:45.023 51wantu[86747:1226723] cate_name--女装
     2015-08-13 06:36:45.024 51wantu[86747:1226723] id--13
     2015-08-13 06:36:45.024 51wantu[86747:1226723] cate_name--男装
     2015-08-13 06:36:45.024 51wantu[86747:1226723] id--14
     2015-08-13 06:36:45.024 51wantu[86747:1226723] cate_name--鞋包
     2015-08-13 06:36:45.024 51wantu[86747:1226723] id--15
     2015-08-13 06:36:45.024 51wantu[86747:1226723] cate_name--美妆
     2015-08-13 06:36:45.025 51wantu[86747:1226723] id--16
     2015-08-13 06:36:45.025 51wantu[86747:1226723] cate_name--配饰
     2015-08-13 06:36:45.025 51wantu[86747:1226723] id--17
     2015-08-13 06:36:45.025 51wantu[86747:1226723] cate_name--居家
     2015-08-13 06:36:45.025 51wantu[86747:1226723] id--18
     2015-08-13 06:36:45.025 51wantu[86747:1226723] cate_name--母婴
     2015-08-13 06:36:45.043 51wantu[86747:1226723] id--19
     2015-08-13 06:36:45.043 51wantu[86747:1226723] cate_name--美食
     2015-08-13 06:36:45.043 51wantu[86747:1226723] id--20
     2015-08-13 06:36:45.043 51wantu[86747:1226723] cate_name--数码电器
     2015-08-13 06:36:45.043 51wantu[86747:1226723] id--21
     2015-08-13 06:36:45.044 51wantu[86747:1226723] cate_name--文体
     */
    if (bigCate == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"bigcate" ofType:@"plist"];
        return [NSArray arrayWithContentsOfFile:path];
    }
    return bigCate;
    
}


+ (NSArray *)getSubCate
{
    /*
    2015-08-13 06:37:43.057 51wantu[86820:1227616] id--3
    2015-08-13 06:37:43.057 51wantu[86820:1227616] cate_name--女装
    2015-08-13 06:37:43.057 51wantu[86820:1227616] id--4
    2015-08-13 06:37:43.057 51wantu[86820:1227616] cate_name--男装
    2015-08-13 06:37:43.058 51wantu[86820:1227616] id--5
    2015-08-13 06:37:43.058 51wantu[86820:1227616] cate_name--鞋包
    2015-08-13 06:37:43.058 51wantu[86820:1227616] id--6
    2015-08-13 06:37:43.058 51wantu[86820:1227616] cate_name--美妆
    2015-08-13 06:37:43.058 51wantu[86820:1227616] id--7
    2015-08-13 06:37:43.058 51wantu[86820:1227616] cate_name--配饰
    2015-08-13 06:37:43.058 51wantu[86820:1227616] id--8
    2015-08-13 06:37:43.059 51wantu[86820:1227616] cate_name--居家
    2015-08-13 06:37:43.059 51wantu[86820:1227616] id--9
    2015-08-13 06:37:43.059 51wantu[86820:1227616] cate_name--母婴
    2015-08-13 06:37:43.059 51wantu[86820:1227616] id--10
    2015-08-13 06:37:43.059 51wantu[86820:1227616] cate_name--美食
    2015-08-13 06:37:43.059 51wantu[86820:1227616] id--11
    2015-08-13 06:37:43.059 51wantu[86820:1227616] cate_name--数码电器
    2015-08-13 06:37:43.064 51wantu[86820:1227616] id--22
    2015-08-13 06:37:43.065 51wantu[86820:1227616] cate_name--文体
    */
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
@end
