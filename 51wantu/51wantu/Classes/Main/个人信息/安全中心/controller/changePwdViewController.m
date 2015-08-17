//
//  changePwdViewController.m
//  51wantu
//
//  Created by kevin on 15/8/16.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "changePwdViewController.h"
#import "Util.h"
#import "UIViewController+MMneed.h"
#import "MBProgressHUD+MJ.h"
#import "HTTPService.h"

@interface changePwdViewController ()
@property (weak, nonatomic) IBOutlet UITextField *oldPwdF;

@property (weak, nonatomic) IBOutlet UITextField *comfirmPwdF;

@property (weak, nonatomic) IBOutlet UITextField *newestPwdF;

- (IBAction)comfirmBtnClick:(UIButton *)sender;

@end

@implementation changePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self.oldPwdF becomeFirstResponder];
    [self colseDrawerGesture];
    [[Util getAppDelegate].drawerController setMaximumLeftDrawerWidth:kScreen_Width +10];
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self openDrawerGesture];
    [[Util getAppDelegate].drawerController setMaximumLeftDrawerWidth:kScreen_Width -40*kScaleInWith];
}

- (IBAction)comfirmBtnClick:(UIButton *)sender {

    [self changeMethod];
}

- (void)changeMethod
{
    [self.view endEditing:YES];
    
    if (self.oldPwdF.text == nil || [self.oldPwdF.text isEqualToString:@"" ])
    {
        [Util showAlertWithTitle:@"提示" msg:@"原密码不能为空"];
        return;
    }
    
    if (self.comfirmPwdF.text == nil || [self.comfirmPwdF.text isEqualToString:@"" ])
    {
        [Util showAlertWithTitle:@"提示" msg:@"确认密码不能为空"];
        return;
    }
    
    if (self.newestPwdF.text == nil || [self.newestPwdF.text isEqualToString:@"" ])
    {
        [Util showAlertWithTitle:@"提示" msg:@"新密码不能为空"];
        return;
    }
    
    if (self.newestPwdF.text.length < 6) {
        [Util showAlertWithTitle:@"提示" msg:@"密码长度不能少于6位"];
        return;
    }
    [MBProgressHUD showMessage:@"修改中..."];
    [self changeMethodToSever];
}

-(void)changeMethodToSever
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.oldPwdF.text forKey:@"opassword"];
    [dict setValue:self.comfirmPwdF.text forKey:@"npassword"];
    [dict setValue:self.newestPwdF.text forKey:@"password"];
    
    [HTTPService POSTHttpToServerWith:@"http://www.51wantu.com/api/api.php?action=resetpwd" WithParameters:dict success:^(NSDictionary *dic) {
        [MBProgressHUD hideHUD];
        NSString *codeStr = [dic objectForKey:@"Code"];
        if ([codeStr integerValue]==102) {
            [Util showAlertWithTitle:@"提示" msg:@"两次输入的密码不一致"];
        }else if([codeStr integerValue]==200){
        
            [Util showAlertWithTitle:@"提示" msg:@"修改成功"];
        }
        
    } error:^(NSError *error) {
        [MBProgressHUD hideHUD];
        [Util showAlertWithTitle:@"提示" msg:@"网络好像有些问题"];
        
    }];

}

@end
