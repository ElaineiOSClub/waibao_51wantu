//
//  ownBaseInfoViewController.m
//  51wantu
//
//  Created by kevin on 15/8/16.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "ownBaseInfoViewController.h"
#import "UIViewController+MMneed.h"
#import "Util.h"

@interface ownBaseInfoViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *ownTableview;
@property (nonatomic,strong) NSArray *infoArr;
@end

@implementation ownBaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资料";
    self.ownTableview.dataSource = self;
    self.ownTableview.delegate = self;
    self.infoArr = [[NSArray alloc]initWithObjects: @"头像", @"用户名", @"性别", @"生日",nil];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self colseDrawerGesture];
    [[Util getAppDelegate].drawerController setMaximumLeftDrawerWidth:kScreen_Width +10];
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self openDrawerGesture];
    [[Util getAppDelegate].drawerController setMaximumLeftDrawerWidth:kScreen_Width -40*kScaleInWith];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return self.categoryArray.count;
        return self.infoArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = [indexPath row];
    static NSString *cellIdentifier = @"ownTableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
        cell.detailTextLabel.text = self.infoArr[row];
    
    return cell;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    NSInteger row = [indexPath row];
    
    [[Util getAppDelegate].drawerController closeDrawerAnimated:YES completion:nil];
    
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
