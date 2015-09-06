//
//  SignViewController.m
//  51wantu
//
//  Created by elaine on 15/9/5.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "SignViewController.h"

#import "HttpTool.h"

@interface SignViewController ()

@end

@implementation SignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_TOKEN];
    
     [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=getpointload&token=%@",token] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
         myLog(@"%@",responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         
     }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
