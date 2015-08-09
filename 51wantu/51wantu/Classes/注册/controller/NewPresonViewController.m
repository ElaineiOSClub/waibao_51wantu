//
//  NewPresonViewController.m
//  51wantu
//
//  Created by kevin on 15/8/8.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "NewPresonViewController.h"
#import "Util.h"
#import "MBProgressHUD+MJ.h"
#import "HTTPService.h"

@interface NewPresonViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextF;
@property (weak, nonatomic) IBOutlet UITextField *comfirmPwdTextF;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextF;

- (IBAction)newOneBtnClick:(UIButton *)sender;


@end

@implementation NewPresonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.emailTextF becomeFirstResponder];
}

- (void)signUpMethod
{
    [self.view endEditing:YES];
    
    if (self.emailTextF.text == nil || [self.emailTextF.text isEqualToString:@"" ])
    {
        [Util showAlertWithTitle:@"提示" msg:@"邮箱不能为空"];
        return;
    }
    
    if (!IS_AVAILABLE_EMAIL(self.emailTextF.text)) {
        [Util showAlertWithTitle:@"提示"  msg:@"请输入正确的邮箱地址"];
        return;
    }
    
    if (self.pwdTextF.text.length < 6) {
        [Util showAlertWithTitle:@"提示" msg:@"密码长度不能少于6个"];
        return;
    }
    if (![self.pwdTextF.text isEqualToString:self.comfirmPwdTextF.text]) {
        [Util showAlertWithTitle:@"提示" msg:@"两次密码输入不正确"];
        return;
    }
    if (self.phoneNumTextF.text.length !=11) {
        [Util showAlertWithTitle:@"提示" msg:@"请输入正确的手机号码"];
        return;
    }
    
    [MBProgressHUD showMessage:@"注册中,请稍等..."];
    [self checkEmail];
}
//检查邮箱是否存在
-(void)checkEmail
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:self.emailTextF.text forKey:@"email"];

    [HTTPService POSTHttpToServerWith:@"http://www.51wantu.com/api/api.php?action=checkEmail" WithParameters:dict success:^(NSDictionary *dic) {
        NSString *statusStr = [dic objectForKey:@"status"];
        if ([statusStr intValue] ==1) {
            [MBProgressHUD hideHUD];
            [Util showAlertWithTitle:@"提示" msg:@"邮箱已存在"];
        }else
            [self newOne];
 
    } error:^(NSError *error) {
        
    }];

}

//增加新用户
-(void)newOne
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setValue:self.authTextF.text forKey:@"code"];
    [dict setValue:self.emailTextF.text forKey:@"email"];
    [dict setValue:self.pwdTextF.text forKey:@"password"];
    [dict setValue:self.comfirmPwdTextF.text forKey:@"confirm_password"];
    [dict setValue:self.phoneNumTextF.text forKey:@"phone"];

    [dict setValue:@"www.baidu.com" forKey:@"gourl"];

    [HTTPService POSTHttpToServerWith:@"http://www.51wantu.com/api/api.php?action=userreg" WithParameters:dict success:^(NSDictionary *dic) {
        [MBProgressHUD hideHUD];
        myLog(@"dic=====%@",dic);
        NSString * success = [dic objectForKey:@"Success"];
        if ([success intValue] == 1)
            [MBProgressHUD showMessage:@"注册成功"];
        else
            [MBProgressHUD showError:@"注册失败"];
    } error:^(NSError *error) {
        
    }];
}

- (IBAction)newOneBtnClick:(UIButton *)sender {
    [self signUpMethod];
}
@end
