//
//  BaseDataModel.h
//  51wantu
//
//  Created by elaine on 15/8/8.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseDataModel : NSObject

@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *item_id;
@property (nonatomic, copy) NSString *item_url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *pic_url;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *tuan_price;
@property (nonatomic, copy) NSString *discount;
@property (nonatomic, assign) BOOL is_top;
@property (nonatomic, assign) BOOL is_hot;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *addtime;
@property (nonatomic, copy) NSString *yufatime;
@property (nonatomic, copy) NSString *bid;
@property (nonatomic, copy) NSString *itemstatus;
@property (nonatomic, copy) NSString *pdate;
@property (nonatomic, copy) NSString *pdate2;
@property (nonatomic, copy) NSString *cname;
@property (nonatomic, assign) BOOL isnew;
@property (nonatomic, assign) BOOL istmall;
@property (nonatomic, copy) NSString *tuan_price1;
@property (nonatomic, copy) NSString *tuan_price2;


@end
