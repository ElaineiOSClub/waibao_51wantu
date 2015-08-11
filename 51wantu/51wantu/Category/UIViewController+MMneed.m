//
//  UIViewController+MMneed.m
//  51wantu
//
//  Created by kevin on 15/8/11.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "UIViewController+MMneed.h"
#import "MMDrawerController.h"
#import "Util.h"

@implementation UIViewController (MMneed)


-(void)openDrawerGesture
{
    [[Util getAppDelegate].drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [[Util getAppDelegate].drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];

}
-(void)colseDrawerGesture
{
    [[Util getAppDelegate].drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
    [[Util getAppDelegate].drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeNone];

}

@end
