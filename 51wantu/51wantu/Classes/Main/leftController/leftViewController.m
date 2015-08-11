//
//  leftViewController.m
//  51wantu
//
//  Created by kevin on 15/8/10.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "leftViewController.h"
#import "leftMainBtn.h"

@interface leftViewController ()

@property (weak, nonatomic) IBOutlet leftMainBtn *ownInfoBtn;
@property (weak, nonatomic) IBOutlet leftMainBtn *aboutBtn;
@property (weak, nonatomic) IBOutlet leftMainBtn *pointBtn;

- (IBAction)ownInfoBtnClick:(leftMainBtn *)sender;
- (IBAction)aboutBtnClick:(leftMainBtn *)sender;
- (IBAction)pointBtnClick:(leftMainBtn *)sender;
@end

@implementation leftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.ownInfoBtn setImage:[UIImage imageNamed:@"username"] forState:UIControlStateNormal];
    [self.aboutBtn setImage:[UIImage imageNamed:@"username"] forState:UIControlStateNormal];
    [self.pointBtn setImage:[UIImage imageNamed:@"username"] forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ownInfoBtnClick:(leftMainBtn *)sender {
}

- (IBAction)aboutBtnClick:(leftMainBtn *)sender {
}

- (IBAction)pointBtnClick:(leftMainBtn *)sender {
}@end
