//
//  ClassifySearchViewController.m
//  51wantu
//
//  Created by elaine on 15/8/8.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "ClassifySearchViewController.h"
#import "UIViewController+MMneed.h"

@interface ClassifySearchViewController ()

@end

@implementation ClassifySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self openDrawerGesture];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self colseDrawerGesture];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
