//
//  ClassifyHomeCell.m
//  51wantu
//
//  Created by elaine on 15/8/25.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "ClassifyHomeCell.h"
#import "DockItem.h"


@interface ClassifyHomeCell()
@property (nonatomic, strong) DockItem *item;
@end

@implementation ClassifyHomeCell


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.item];
        
    }
    return self;
}

- (void)setCate_name:(NSString *)cate_name
{
    _cate_name = [cate_name copy];
    [self.item setTitle:cate_name forState:UIControlStateNormal];
}

- (void)setImageStr:(NSString *)imageStr
{
    _imageStr = [imageStr copy];
    [self.item setImage:[UIImage imageNamed:imageStr] forState:UIControlStateNormal];
}


#pragma mark - lazy
- (DockItem *)item
{
    if (!_item) {
        _item = [DockItem buttonWithType:UIButtonTypeCustom];
        [_item setImage:[UIImage imageNamed:@"19"] forState:UIControlStateNormal];
        [_item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _item.userInteractionEnabled = NO;
    }
    return _item;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.item.frame = self.contentView.bounds;
}


@end
