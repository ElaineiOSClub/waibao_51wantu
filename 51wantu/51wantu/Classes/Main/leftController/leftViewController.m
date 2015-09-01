//
//  leftViewController.m
//  51wantu
//
//  Created by kevin on 15/8/10.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "leftViewController.h"
#import "leftMainBtn.h"
#import "leftTableViewCell.h"
#import "ClassifyModel.h"
#import "MainViewController.h"
#import "MainNavViewController.h"
#import "Util.h"
#import "ownInfoViewController.h"
#import "IntegralViewController.h"

@interface leftViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet leftMainBtn *ownInfoBtn;
@property (weak, nonatomic) IBOutlet leftMainBtn *aboutBtn;

- (IBAction)ownInfoBtnClick:(leftMainBtn *)sender;
- (IBAction)aboutBtnClick:(leftMainBtn *)sender;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@property (nonatomic,strong) NSArray *categoryArray;

@property (nonatomic, strong) NSArray *imageArray;

@end

@implementation leftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.ownInfoBtn setImage:[UIImage imageNamed:@"username"] forState:UIControlStateNormal];
    [self.aboutBtn setImage:[UIImage imageNamed:@"pointMallicon"] forState:UIControlStateNormal];
//    [self.pointBtn setImage:[UIImage imageNamed:@"username"] forState:UIControlStateNormal];

    //self.categoryArray = [[NSMutableArray alloc] initWithObjects: @"全部", @"女装", @"男装", @"鞋包", @"美妆", @"配饰", @"居家",@"母婴",@"美食",@"数码电器",@"文体", nil];

    //self.categoryListId = @[@"全部",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"22"];
    
    self.navigationController.navigationBarHidden = YES;
    self.categoryArray = [ClassifyModel getSubCate];
    
    
    
    UIView *footView = [[UIView alloc]init];
    self.categoryTableView.tableFooterView = footView;
    self.categoryTableView.delegate = self;
    self.categoryTableView.dataSource = self;
    self.categoryTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    
    
    
    
    
}







#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.categoryArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"leftTableViewCell";
    
    leftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [leftTableViewCell getleftTableViewCell];
    }
    
    NSInteger row = [indexPath row];
//    cell.categoryName.text = self.categoryArray[row];
    cell.categoryName.text = self.categoryArray[row][@"cate_name"];
    cell.categoryImageView.image = [UIImage imageNamed:cell.categoryName.text];
    return cell;

}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSInteger row = [indexPath row];

    [[NSNotificationCenter defaultCenter] postNotificationName:kReloadDataForClassifyNotification object:nil userInfo:@{@"id":self.categoryArray[row][@"id"],@"cate_name":self.categoryArray[row][@"cate_name"]}];
    
//    MainViewController * center = [[MainViewController alloc] init];
//    MainNavViewController * nav = [[MainNavViewController alloc] initWithRootViewController:center];
//        [[Util getAppDelegate].drawerController
//         setCenterViewController:nav
//         withCloseAnimation:YES
//         completion:nil];
//    
    [[Util getAppDelegate].drawerController closeDrawerAnimated:YES completion:nil];

}






- (IBAction)ownInfoBtnClick:(leftMainBtn *)sender {
    
//    ownInfoViewController *ownInfo = [[ownInfoViewController alloc]init];
//
//    [self.navigationController pushViewController:ownInfo animated:YES];
//  
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kPushLeftVC" object:nil userInfo:@{@"class":[ownInfoViewController class]}];
    
}

- (IBAction)aboutBtnClick:(leftMainBtn *)sender {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kPushLeftVC" object:nil userInfo:@{@"class":[IntegralViewController class]}];
}

@end
