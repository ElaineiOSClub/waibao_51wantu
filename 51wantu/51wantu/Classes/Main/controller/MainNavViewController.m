//
//  MainNavViewController.m
//  51wantu
//
//  Created by elaine on 15/8/8.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "MainNavViewController.h"
#import "UIBarButtonItem+Extension.h"

@interface MainNavViewController ()

@end

@implementation MainNavViewController



+ (void)initialize
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barStyle = UIBarStyleBlackOpaque;
    [navBar setBarTintColor:NAV_COLOR];
    navBar.tintColor = [UIColor whiteColor];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName]= [UIColor whiteColor];
    [navBar setTitleTextAttributes:dict];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //大于0 表示不是根控制器
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        //设置返回按钮样式
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithTarget:self action:@selector(back) image:@"white_backBtn_normal" highImage:@"white_backBtn_selected"];
    }
    //   else {
    //       //这里是导航栏下的根控制器
    //       viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem initWithTarget:self action:@selector(presentLeftMenuViewController:) image:@"nav_home_nomal" highImage:@"nav_home_high"];
    //   }
    [super pushViewController:viewController animated:animated];
}

- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
