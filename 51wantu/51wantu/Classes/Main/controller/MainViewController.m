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
#import "ClassifySearchViewController.h"
#import "BrandViewController.h"
#import "AdvanceNoticeViewController.h"


@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //首页
    HomeViewController *home = [[HomeViewController alloc] init];
    [self addChildVc:home title:@"首页" image:@"导诊流程页面icon_03" selectedImage:@"导诊流程页面icon_03-05"];
    //9.9包邮
    ExemptionPostageViewController *postage = [[ExemptionPostageViewController alloc] init];
    [self addChildVc:postage title:@"9.9包邮" image:@"导诊流程页面icon_03-07" selectedImage:@"导诊流程页面icon_03-09"];

    //分类搜索
    ClassifySearchViewController *classify = [[ClassifySearchViewController alloc] init];
    [self addChildVc:classify title:@"分类搜索" image:@"导诊流程页面icon_03-11" selectedImage:@"导诊流程页面icon_03-13"];
    //品牌团
    BrandViewController *brand = [[BrandViewController alloc] init];
    [self addChildVc:brand title:@"品牌团" image:@"导诊流程页面icon_03-15" selectedImage:@"导诊流程页面icon_03-17"];
    
    //明日预告
    AdvanceNoticeViewController *notice = [[AdvanceNoticeViewController alloc] init];
    [self addChildVc:notice title:@"明日预告" image:@"导诊流程页面icon_03-11" selectedImage:@"导诊流程页面icon_03-09"];
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
    selectTextAttrs[NSForegroundColorAttributeName] = kUIColorFromRGB(0x1ac785);
    
    [childVc.tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    
    [childVc.tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];
    
    // 先给外面传进来的小控制器 包装 一个导航控制器
    MainNavViewController *nav = [[MainNavViewController alloc] initWithRootViewController:childVc];
    // 添加为子控制器
    [self addChildViewController:nav];
}


@end