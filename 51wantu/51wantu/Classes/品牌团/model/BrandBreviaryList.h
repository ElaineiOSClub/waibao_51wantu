//
//  BrandBreviaryList.h
//  51wantu
//
//  Created by elaine on 15/8/16.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import <Foundation/Foundation.h>

//{"id":"6280","brand_name":"\u4f0a\u8587\u745e","zhekou":"\u5168\u573a\u4e00\u6298\u8d77","tid":"1","addtime":"1438911220","i":1,"isnew":1,"list":
//    datas数据列表
//    id：数据ID
//    brand_name：品牌名次
//    zhekou：折扣说明
//    tid：分类ID
//    addtime：添加时间
//    i：数据循环序号
//    isnew：是否有更新
//    list：商品数据列表
//    字段名称和商品列表的一样
//
//
//    currentpage：当前页数
//    totalnum：商品总数
//    totalpage：总页数
//    pagesize：每页商品数
@interface BrandBreviaryList : NSObject
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *brand_name;
@property (nonatomic, copy) NSString *zhekou;
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, assign) NSInteger i;
@property (nonatomic, assign) BOOL isnew;
@property (nonatomic, strong) NSMutableArray *list;
@end
