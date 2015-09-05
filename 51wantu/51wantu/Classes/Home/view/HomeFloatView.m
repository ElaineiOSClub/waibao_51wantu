//
//  HomeFloatView.m
//  51wantu
//
//  Created by elaine on 15/9/5.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "HomeFloatView.h"

@interface HomeFloatView()
@property (nonatomic, strong) UIButton *userBtn;
@property (nonatomic, strong) UIButton *favouriteBtn;
@property (nonatomic, strong) UIButton *collectionBtn;
@property (nonatomic, strong) UIView *tempView1;
@property (nonatomic, strong) UIView *tempView2;
@end

@implementation HomeFloatView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.7;
        self.layer.cornerRadius = 3;
        
        frame.size.width = 122;
        frame.size.height = 40;
        
        [self addSubview:self.userBtn];
        [self addSubview:self.favouriteBtn];
        [self addSubview:self.collectionBtn];
        [self addSubview:self.tempView1];
        [self addSubview:self.tempView2];
        
    }
    return self;
}

#pragma mark - event response

- (void)userClick:(UIButton *)button
{
    [self.delegate homeFloatView:self didClickBtnWithType:HomeFloatViewStyleUser];
}

- (void)favouriteClick:(UIButton *)button
{
    [self.delegate homeFloatView:self didClickBtnWithType:HomeFloatViewStyleFavourite];
}

- (void)collectionClick:(UIButton *)button
{
    [self.delegate homeFloatView:self didClickBtnWithType:HomeFloatViewStyleCollection];
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.userBtn.origin = CGPointMake(8, 8);
    
    self.tempView1.width = 1;
    self.tempView1.height = self.height - 12;
    self.tempView1.x = CGRectGetMaxX(self.userBtn.frame) + 8;
    self.tempView1.y = 6;
    
    self.favouriteBtn.origin = CGPointMake(CGRectGetMaxX(self.tempView1.frame) + 8, 8);
    
    self.tempView2.width = 1;
    self.tempView2.height = self.height - 12;
    self.tempView2.x = CGRectGetMaxX(self.favouriteBtn.frame) + 8;
    self.tempView2.y = 6;
    
    self.collectionBtn.origin = CGPointMake(CGRectGetMaxX(self.tempView2.frame) + 8, 8);
    
}


#pragma mark - lazy
- (UIButton *)userBtn
{
    if (!_userBtn) {
        
        _userBtn = [[UIButton alloc] init];
        [_userBtn setBackgroundImage:[UIImage imageNamed:@"homeUserInfo"] forState:UIControlStateNormal];
        _userBtn.size = _userBtn.currentBackgroundImage.size;
        [_userBtn addTarget:self action:@selector(userClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userBtn;
}

- (UIButton *)favouriteBtn
{
    if (!_favouriteBtn) {
        _favouriteBtn = [[UIButton alloc] init];
        [_favouriteBtn setBackgroundImage:[UIImage imageNamed:@"homeCollection"] forState:UIControlStateNormal];
        _favouriteBtn.size = _favouriteBtn.currentBackgroundImage.size;
        [_favouriteBtn addTarget:self action:@selector(favouriteClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _favouriteBtn;
}

- (UIButton *)collectionBtn
{
    if (!_collectionBtn) {
        _collectionBtn = [[UIButton alloc] init];
        [_collectionBtn setBackgroundImage:[UIImage imageNamed:@"homeShoppingCart"] forState:UIControlStateNormal];
        _collectionBtn.size = _collectionBtn.currentBackgroundImage.size;
        [_collectionBtn addTarget:self action:@selector(collectionClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectionBtn;
}

- (UIView *)tempView1
{
    if (!_tempView1) {
        _tempView1 = [[UIView alloc] init];
        _tempView1.backgroundColor = [UIColor lightGrayColor];
        
    }
    return _tempView1;
}

- (UIView *)tempView2
{
    if (!_tempView2) {
        _tempView2 = [[UIView alloc] init];
        _tempView2.backgroundColor = [UIColor lightGrayColor];
    }
    return _tempView2;
}



@end
