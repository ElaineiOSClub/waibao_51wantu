//
//  MainViewController.m
//  51wantu
//
//  Created by elaine on 15/8/8.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "MainViewController.h"
#import "MainNavViewController.h"

//五个主控制器
#import "HomeViewController.h"
#import "ExemptionPostageViewController.h"
#import "ClassifyHomeController.h"
#import "BrandViewController.h"
#import "AdvanceNoticeViewController.h"





@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //首页
    HomeViewController *home = [[HomeViewController alloc] init];
    [self addChildVc:home title:@"首页" image:@"home_tab_home_btn" selectedImage:@"home_tab_home_selected_btn"];
    //9.9包邮
    ExemptionPostageViewController *postage = [[ExemptionPostageViewController alloc] init];
    [self addChildVc:postage title:@"9.9包邮" image:@"home_tab_point_btn" selectedImage:@"home_tab_point_selected_btn"];

    //分类搜索
    ClassifyHomeController *classify = [[ClassifyHomeController alloc] init];
    [self addChildVc:classify title:@"分类搜索" image:@"home_tab_saunter_btn" selectedImage:@"home_tab_saunter_selected_btn"];
    //品牌团
    BrandViewController *brand = [[BrandViewController alloc] init];
    [self addChildVc:brand title:@"品牌团" image:@"home_tab_branc_btn" selectedImage:@"home_tab_branc_selected_btn"];
    
    //明日预告
    AdvanceNoticeViewController *notice = [[AdvanceNoticeViewController alloc] init];
    [self addChildVc:notice title:@"明日预告" image:@"home_tab_personal_btn" selectedImage:@"home_tab_personal_selected_btn"];
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字
    //childVc.tabBarItem.title = title; // 同时设置tabbar和navigationBar的文字
    childVc.title = title;
    // 设置子控制器的图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = kUIColorFromRGB(0x838282);
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs[NSForegroundColorAttributeName] = RGBA(252, 0, 67, 1);
    
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    MainNavViewController *nav = [[MainNavViewController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}


@end
