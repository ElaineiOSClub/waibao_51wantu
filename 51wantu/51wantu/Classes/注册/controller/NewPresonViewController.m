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

@interface NewPresonViewController ()
@property (weak, nonatomic) IBOutlet UITextField *emailTextF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextF;
@property (weak, nonatomic) IBOutlet UITextField *comfirmPwdTextF;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextF;
@property (weak, nonatomic) IBOutlet UITextField *authTextF;
@property (weak, nonatomic) IBOutlet UIImageView *authImage;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

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
    [MBProgressHUD showMessage:@"注册中,请稍等..."];
    
//    [self signUpRequestHttpToServerWithpsWord:self.pwdText.text];
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
