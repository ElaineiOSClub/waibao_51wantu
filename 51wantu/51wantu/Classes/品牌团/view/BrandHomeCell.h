//
//  BrandHomeCell.h
//  51wantu
//
//  Created by elaine on 15/8/16.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BrandBreviaryList;
@class BrandHomeCell,BaseDataModel;

@protocol BrandHomeCellDelegate <NSObject>

- (void)brandHomeCell:(BrandHomeCell *)cell didSelectItem:(BaseDataModel *)item;

- (void)brandHomeCell:(BrandHomeCell *)cell moreProductFromBrandID:(NSString *)brandID BrandName:(NSString *)brandName;

@end

@interface BrandHomeCell : UICollectionViewCell
@property (nonatomic, strong) BrandBreviaryList *brandBreviaryList;
@property (nonatomic, weak) id<BrandHomeCellDelegate> delegate;
@end
