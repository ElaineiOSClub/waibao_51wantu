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

@interface UIWebViewController ()<UIWebViewDelegate>

@property (nonatomic, strong) UIButton *button;
@end

@implementation UIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    NSURL *url = [NSURL URLWithString:self.urlStr];
    webView.delegate = self;
    [self.view addSubview:webView];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"unFavoriteState"] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:@"favoriteState"] forState:UIControlStateSelected];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    _button = button;
    _button.enabled = NO;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"248301344@qq.com" forKey:@"account"];
    [dict setValue:@"891227" forKey:@"password"];
    
    [dict setValue:@"www.baidu.com" forKey:@"gourl"];
    
    
    
    
    
    

    
//   [HttpTool httpToolPost:@"http://www.51wantu.com/api/api.php?action=userlogin" parameters:dict success:^(AFHTTPRequestOperation *operation, id responseObject) {
//       
//       
////       
//       
//       
//   } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//       
//   }];

   
    
    
    [HttpTool httpToolGet: @"http://www.51wantu.com/api/api.php?action=getuserinfo" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {

        //表示已经收藏
        myLog(@"%@",responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

    
    
    
    [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=goods_fav_status&g_ids=%@",self.itemID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.button.enabled = YES;
        //表示已经收藏
        myLog(@"%@",responseObject);
        if ([responseObject[@"data"] count]>0) {
            self.button.selected = YES;
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

    
    
    
}


- (void)btnClick:(UIButton *)btn;
{
    if (btn.selected) {//已收藏
        //取消收藏
        
        [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=deletefav&id=%@",self.itemID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            myLog(@"%@",responseObject);
            if ([responseObject[@"code"] integerValue] == 200) {
                self.button.selected = NO;
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
    } else {

        [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=addfav&id=%@&status=1",self.itemID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            myLog(@"%@",responseObject);
            if ([responseObject[@"code"] integerValue] == 200) {
                self.button.selected = YES;
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }
}


#pragma mark - webView代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [MBProgressHUD showMessage:@"正在加载..."];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}



@end
