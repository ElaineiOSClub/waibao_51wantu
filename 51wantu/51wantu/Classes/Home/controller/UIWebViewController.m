//
//  UIWebViewController.m
//  51wantu
//
//  Created by elaine on 15/8/10.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "UIWebViewController.h"
#import "MBProgressHUD+MJ.h"
#import "HttpTool.h"
#import "UIViewController+PushNotification.h"

@interface UIWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIButton *button;
@end

@implementation UIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    //NSURL *url = [NSURL URLWithString:self.urlStr];
    myLog(@"%@",self.urlStr);
    NSURL *url = [NSURL URLWithString:self.urlStr];
    webView.delegate = self;
    [self.view addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"爱心never"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"爱心"] forState:UIControlStateSelected];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _button = button;
    _button.enabled = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_TOKEN];
    
    [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=goods_fav_status&g_ids=%@&token=%@",self.itemID,token] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //表示已经收藏
        self.button.enabled = YES;
        myLog(@"%@",responseObject);
        if ([responseObject[@"code"] integerValue] == 1001) {
            if ([responseObject[@"data"] count] >0) {
                self.button.selected = YES;
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}


- (void)btnClick:(UIButton *)btn;
{
    
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_TOKEN];
    
    
    if (btn.selected) {//已收藏
        //取消收藏
        
        [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=deletefav&id=%@&token=%@",self.itemID,token] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            myLog(@"%@",responseObject);
            if ([responseObject[@"code"] integerValue] == 200) {
                self.button.selected = NO;
            } else if ([responseObject[@"code"] integerValue] == 0) {
                [self login];
            }
            
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
    } else {

        [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=addfav&id=%@&status=1&token=%@",self.itemID,token] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            myLog(@"%@",responseObject);
            if ([responseObject[@"code"] integerValue] == 200) {
                self.button.selected = YES;
            } else if ([responseObject[@"code"] integerValue] == 0) {
                [self login];
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
}

//
//#pragma mark - webView代理方法
//- (void)webViewDidFinishLoad:(UIWebView *)webView
//{
//    [MBProgressHUD hideHUD];
//}
//
//- (void)webViewDidStartLoad:(UIWebView *)webView
//{
//    [MBProgressHUD showMessage:@"正在加载..."];
//}
//
//- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
//{
//    [MBProgressHUD hideHUD];
//}



@end
