//
//  NewPresonViewController.m
//  51wantu
//
//  Created by kevin on 15/8/8.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "NewPresonViewController.h"

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
