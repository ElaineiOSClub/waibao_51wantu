//
//  IntegralViewController.m
//  51wantu
//
//  Created by elaine on 15/9/1.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "IntegralViewController.h"

@interface IntegralViewController ()
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UIView *tempView;
@end

@implementation IntegralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"积分商城";
    self.view.backgroundColor = RGBA(242, 242, 242, 1);
    
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, kScreen_Width, 44)];
    topView.backgroundColor = kUIColorFromRGB(0xffffff);
    
    [self.view addSubview:topView];
    
    CGFloat width = kScreen_Width/3;
    
    
    UIView *tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 43, 80, 1)];
    tempView.backgroundColor = NAV_COLOR;
    [topView addSubview:tempView];
    _tempView = tempView;
    
    NSArray *array = @[@"今日兑换活动",@"明日兑换活动",@"历史兑换活动"];
    for (int i = 0; i<3; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:array[i] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitleColor:kUIColorFromRGB(0x838282) forState:UIControlStateNormal];
        [button setTitleColor:NAV_COLOR forState:UIControlStateSelected];
        button.frame = CGRectMake(width*i, 0, width, 43);
        button.tag = i;
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        [topView addSubview:button];
        
        
        if (i == 0) {
            [self click:button];
        }
    }
}

- (void)click:(UIButton *)button
{
    button.selected = YES;
    self.selectBtn.selected = NO;
    self.selectBtn = button;
    
    [UIView animateWithDuration:0.3 animations:^{
        self.tempView.centerX = button.centerX;
    }];
    
}



@end
