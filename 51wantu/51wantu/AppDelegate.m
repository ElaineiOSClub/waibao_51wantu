//
//  AppDelegate.m
//  51wantu
//
//  Created by elaine on 15/8/8.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "AppDelegate.h"
#import "MainViewController.h"
#import "MMDrawerController.h"
#import "NewPresonViewController.h"
#import "MainNavViewController.h"
#import "loginViewController.h"
#import "leftViewController.h"

#import <TAESDK/TAESDK.h>
#import <ALBBLoginSDK/ALBBLoginService.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 状态栏变色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

//    //sdk初始化
//    [[TaeSDK sharedInstance] asyncInit:^{
//        NSLog(@"初始化成功");
//    } failedCallback:^(NSError *error) {
//        NSLog(@"初始化失败:%@",error);
//    }];
//    
    
//    loginViewController *newOne = [[loginViewController alloc] init];
    
    
    MainViewController *tabBar = [[MainViewController alloc] init];
//    
//    UIViewController *leftVC = [[UIViewController alloc] init];
//    
//    MMDrawerController *drawer = [[MMDrawerController alloc] initWithCenterViewController:tabBar leftDrawerViewController:leftVC];
       leftViewController *leftVC = [[leftViewController alloc] init];
    MainNavViewController *nav2 = [[MainNavViewController alloc]initWithRootViewController:leftVC];
    
    MMDrawerController * drawerController = [[MMDrawerController alloc]initWithCenterViewController:tabBar
                                                                           leftDrawerViewController:nav2
                                                                          rightDrawerViewController:nil];
    [drawerController setMaximumLeftDrawerWidth:kScreen_Width -40*kScaleInWith];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    self.drawerController = drawerController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    loginViewController *login = [[loginViewController alloc] init];
    
    self.window.rootViewController = drawerController;
    [self.window makeKeyAndVisible];
    return YES;
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    //该URL是否已经被TAE处理过
    BOOL wasHandled=[[TaeSDK sharedInstance] handleOpenURL:url];
    //开发者继续自己处理
    TaeUser *user = [[TaeSession sharedInstance] getUser];
    
    myLog(@"%@,%@,%@",user.nick,user.userId,user.iconUrl);
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
