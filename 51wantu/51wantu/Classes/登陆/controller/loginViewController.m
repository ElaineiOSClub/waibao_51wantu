//
//  loginViewController.m
//  51wantu
//
//  Created by kevin on 15/8/9.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "loginViewController.h"
#import "HTTPService.h"
#import "MBProgressHUD+MJ.h"
#import "Util.h"
#import "NewPresonViewController.h"

#import <TAESDK/TAESDK.h>
#import <ALBBLoginSDK/ALBBLoginService.h>


@interface loginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountTextF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextF;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UISwitch *showPwd;
- (IBAction)showPwdOn:(UISwitch *)sender;

- (IBAction)loginBtnClick:(UIButton *)sender;


@end

@implementation loginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"登录";
    // Do any additional setup after loading the view from its nib.
    [self.accountTextF becomeFirstResponder];
    
    
    //左侧关闭
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close"] style:UIBarButtonItemStyleDone target:self action:@selector(closeClick:)];
    //右侧注册
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(registerClick:)];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];

}

- (void)signUpMethod
{
    [self.view endEditing:YES];
    
    if (self.accountTextF.text == nil || [self.accountTextF.text isEqualToString:@"" ])
    {
        [Util showAlertWithTitle:@"提示" msg:@"邮箱不能为空"];
        return;
    }
    
    if (!IS_AVAILABLE_EMAIL(self.accountTextF.text)) {
        [Util showAlertWithTitle:@"提示"  msg:@"请输入正确的邮箱地址"];
        return;
    }
    
    if (self.pwdTextF.text.length < 6) {
        [Util showAlertWithTitle:@"提示" msg:@"密码长度不能少于6个"];
        return;
    }
    [MBProgressHUD showMessage:@"登录中,请稍等..."];
    [self login];
}

-(void)login{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.accountTextF.text forKey:@"account"];
    [dict setValue:self.pwdTextF.text forKey:@"password"];
    
    [dict setValue:@"http://www.baidu.com" forKey:@"gourl"];
    
[HTTPService POSTHttpToServerWith:@"http://www.51wantu.com/api/api.php?action=userlogin" WithParameters:dict success:^(NSDictionary *dic) {
    
    myLog(@"dic =====,%@",dic);
    [MBProgressHUD hideHUD];
    NSString *successStr = [dic objectForKey:@"Success"];
    NSString *codeStr = [dic objectForKey:@"Code"];
    if ([successStr intValue] ==1) {
        [MBProgressHUD showMessage:@"登录成功"];
    }else{
        if ([codeStr intValue] ==105) {
            [Util showAlertWithTitle:@"提示" msg:@"密码错误"];
        }
        if ([codeStr intValue] ==104) {
            [Util showAlertWithTitle:@"提示" msg:@"用户名不存在"];
        }
    }
    
} error:^(NSError *error) {
    myLog(@"登陆错误");
    [MBProgressHUD hideHUD];
    [Util showAlertWithTitle:@"提示" msg:@"网络好像有问题"];

    
}];

}
- (IBAction)showPwdOn:(UISwitch *)sender {
    self.pwdTextF.secureTextEntry =!sender.isOn;
}

- (IBAction)loginBtnClick:(UIButton *)sender{
    [self signUpMethod];
    
}

- (void)closeClick:(UIButton *)button
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)registerClick:(UIButton *)button
{
    
    [self.navigationController pushViewController:[[NewPresonViewController alloc] init] animated:YES];
}

- (IBAction)taobaoClick:(id)sender {
    //sdk初始化
    [[TaeSDK sharedInstance] asyncInit:^{
        myLog(@"初始化成功");
        [self showLogin];
        

        
        
        
     
    } failedCallback:^(NSError *error) {
        myLog(@"初始化失败:%@",error);
    }];
}

-(void)showLogin{
    id<ALBBLoginService> loginService=[[TaeSDK sharedInstance]getService:@protocol(ALBBLoginService)];
    if(![[TaeSession sharedInstance] isLogin]){
        [loginService showLogin:self successCallback:^(TaeSession *session){
            NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@,登录时间:%@",[session getUser],[session getLoginTime]];
            myLog(@"%@", tip);
        } failedCallback:^(NSError *error){
            myLog(@"登录失败");
        }];
    }else{
        TaeSession *session=[TaeSession sharedInstance];
        NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@,登录时间:%@",[session getUser],[session getLoginTime]];
        myLog(@"%@", tip);
    }
}

@end
