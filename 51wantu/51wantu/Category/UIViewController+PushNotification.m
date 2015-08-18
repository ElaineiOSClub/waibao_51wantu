//
//  UIViewController+PushNotification.m
//  iosNav
//
//  Created by elaine on 15/4/27.
//  Copyright (c) 2015年 mandalat. All rights reserved.
//

#import "UIViewController+PushNotification.h"
#import "Util.h"

@implementation UIViewController (PushNotification)

#pragma mark - 注册通知
- (void)registerNotification:(SEL)aSelector
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:aSelector name:kReloadDataForClassifyNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(push:) name:@"kPushLeftVC" object:nil];
}

#pragma mark - 移除通知
- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)push:(NSNotification *)notification
{
    [[Util getAppDelegate].drawerController closeDrawerAnimated:NO completion:^(BOOL finished) {
        Class className = notification.userInfo[@"class"];
        [self.navigationController pushViewController:[[className alloc] init] animated:YES];
    }];
    
    
}

- (void)login
{
   
}


@end
