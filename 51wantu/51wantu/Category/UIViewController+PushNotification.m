//
//  UIViewController+PushNotification.m
//  iosNav
//
//  Created by elaine on 15/4/27.
//  Copyright (c) 2015年 mandalat. All rights reserved.
//

#import "UIViewController+PushNotification.h"
#import "LoginViewController.h"

@implementation UIViewController (PushNotification)

#pragma mark - 注册通知
- (void)registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(push:) name:MenuLeftPushNotification object:nil];
    
}

#pragma mark - 移除通知
- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)push:(NSNotification *)notification
{
    Class pushClass = notification.userInfo[@"cls"];
    [self.navigationController pushViewController:[[pushClass alloc] init] animated:NO];
}

- (void)login
{
    LoginViewController *login = [[LoginViewController alloc] init];
    login.isPresent = YES;
    [self presentViewController:login animated:YES completion:nil];
}


@end
