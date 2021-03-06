//
//  ownInfoViewController.m
//  51wantu
//
//  Created by kevin on 15/8/16.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "ownInfoViewController.h"
#import "Util.h"
#import "UIViewController+MMneed.h"
#import "ownBaseInfoViewController.h"
#import "mineViewController.h"
#import "changePwdViewController.h"
#import "ownAddViewController.h"
#import "pointViewController.h"
#import "NewPresonViewController.h"


#import "loginViewController.h"
#import "UIViewController+PushNotification.h"

@interface ownInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
- (IBAction)backBtnClick:(UIButton *)sender;
- (IBAction)logIN:(UIButton *)sender;
- (IBAction)registerBtnClick:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UIButton *logInBtn;
@property (weak, nonatomic) IBOutlet UITableView *ownInfoTabview;
@property (nonatomic,strong) NSArray *accountSettingArr;
@property (nonatomic,strong) NSArray *pushArr;
@end

@implementation ownInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headerImageView.backgroundColor = RGBA(253,36,109,1);
    
    self.ownInfoTabview.tableFooterView = [[UIView alloc]init];
    self.ownInfoTabview.delegate = self;
    self.ownInfoTabview.dataSource = self;
     self.accountSettingArr = [[NSArray alloc] initWithObjects: @"基本资料", @"收货地址", @"安全中心", @"积分中心",@"积分商城",@"我的收藏", nil];
    
    //self.accountSettingArr = [[NSArray alloc] initWithObjects: @"基本资料", @"安全中心", @"我的收藏", nil];
    
    
    self.ownInfoTabview.scrollEnabled = NO;

    ownBaseInfoViewController *base = [[ownBaseInfoViewController alloc]init];
    mineViewController *mine = [[mineViewController alloc]init];
    changePwdViewController *change = [[changePwdViewController alloc]init];
    ownAddViewController *add = [[ownAddViewController alloc]init];
    pointViewController *point = [[pointViewController alloc]init];
    
    self.pushArr = [[NSArray alloc]initWithObjects:base,add,change,point,mine, nil];
    
     self.pushArr = [[NSArray alloc]initWithObjects:base,change,mine, nil];

    //footer
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 80)];
    UIButton *outBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [outBtn setTitle:@"退出" forState:UIControlStateNormal];
    outBtn.frame = CGRectMake(20, 30, kScreen_Width - 40, 44);
    [outBtn addTarget:self action:@selector(outClick:) forControlEvents:UIControlEventTouchUpInside];
    outBtn.backgroundColor = NAV_COLOR;
    outBtn.layer.cornerRadius = 4;
    [footView addSubview:outBtn];
    self.ownInfoTabview.tableFooterView = footView;

    
    
    
    
}


#pragma mark - event response
- (void)outClick:(UIButton *)button
{
    //退出
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_USERNAME];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_PASSWORD];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:KEY_TOKEN];
    self.ownInfoTabview.tableFooterView.hidden = YES;
    self.nameLab.hidden = YES;
    self.logInBtn.hidden = NO;
    self.registerBtn.hidden = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
    NSString *userName =  [[NSUserDefaults standardUserDefaults]objectForKey:KEY_USERNAME];
    
    NSString *passWord =  [[NSUserDefaults standardUserDefaults]objectForKey:KEY_PASSWORD];
    NSString *nickName =  [[NSUserDefaults standardUserDefaults]objectForKey:KEY_NICKNAME];
    
    if (userName == nil || [userName isEqualToString:@""] || [userName isEqual:[NSNull null]] || passWord == nil || [passWord isEqualToString:@""] || [passWord isEqual:[NSNull null]])
    {
        self.nameLab.hidden = YES;
        self.logInBtn.hidden = NO;
        self.registerBtn.hidden = NO;
        
    }else
    {
        self.nameLab.text =nickName;
        self.nameLab.hidden = NO;
        self.logInBtn.hidden = YES;
        self.registerBtn.hidden = YES;
    
    }
    
    
//    [[NSUserDefaults standardUserDefaults]setObject:token forKey:KEY_TOKEN];
//    [[NSUserDefaults standardUserDefaults]setObject:self.accountTextF.text  forKey:KEY_USERNAME];
//    [[NSUserDefaults standardUserDefaults]setObject:self.pwdTextF.text forKey:KEY_PASSWORD];
//    

    self.ownInfoTabview.tableFooterView.hidden = [self getToken] == nil ? YES : NO;

    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.accountSettingArr.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"tableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSInteger row = [indexPath row];
    cell.detailTextLabel.text = self.accountSettingArr[row];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    return cell;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = [indexPath row];
    
    //判断是否登录了
    if (![self getToken]) {
        [self logIN:nil];
    } else {
         [self.navigationController pushViewController:self.pushArr[row] animated:YES];
    } 
}


- (IBAction)backBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)logIN:(UIButton *)sender {
    
    loginViewController *loginVC = [[loginViewController alloc] init];
    
    [self.navigationController pushViewController:loginVC animated:YES];

}

- (IBAction)registerBtnClick:(id)sender {
    [self.navigationController pushViewController:[[NewPresonViewController alloc] init] animated:YES];
}

- (NSString *)getToken
{
     return [[NSUserDefaults standardUserDefaults] stringForKey:KEY_TOKEN];
}


@end
