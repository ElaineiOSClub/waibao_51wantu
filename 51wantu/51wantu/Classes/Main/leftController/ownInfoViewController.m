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


#import "loginViewController.h"

@interface ownInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
- (IBAction)backBtnClick:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UIButton *logInBtn;
@property (weak, nonatomic) IBOutlet UITableView *ownInfoTabview;
@property (nonatomic,strong) NSArray *accountSettingArr;
@property (nonatomic,strong) NSArray *pushArr;
@end

@implementation ownInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ownInfoTabview.tableFooterView = [[UIView alloc]init];
    [self.logInBtn setTitle:@"登录/注册" forState:UIControlStateNormal];
    self.logInBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    self.ownInfoTabview.delegate = self;
    self.ownInfoTabview.dataSource = self;
     self.accountSettingArr = [[NSArray alloc] initWithObjects: @"基本资料", @"收货地址", @"安全中心", @"积分中心", @"我的收藏", nil];
    self.ownInfoTabview.scrollEnabled = NO;

    ownBaseInfoViewController *base = [[ownBaseInfoViewController alloc]init];
    mineViewController *mine = [[mineViewController alloc]init];
    changePwdViewController *change = [[changePwdViewController alloc]init];
    ownAddViewController *add = [[ownAddViewController alloc]init];
    pointViewController *point = [[pointViewController alloc]init];
    
    self.pushArr = [[NSArray alloc]initWithObjects:base,add,change,point,mine, nil];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
//    [self colseDrawerGesture];
//    [[Util getAppDelegate].drawerController setMaximumLeftDrawerWidth:kScreen_Width +10];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO];
//    [self openDrawerGesture];
//    [[Util getAppDelegate].drawerController setMaximumLeftDrawerWidth:kScreen_Width -40*kScaleInWith];
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
    [self.navigationController pushViewController:self.pushArr[row] animated:YES];
}


- (IBAction)backBtnClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)loginClick:(UIButton *)sender {
    loginViewController *loginVC = [[loginViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    

    [self presentViewController:nav animated:YES completion:nil];
}

@end
