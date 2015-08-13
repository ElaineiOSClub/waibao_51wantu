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

@interface leftViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet leftMainBtn *ownInfoBtn;
@property (weak, nonatomic) IBOutlet leftMainBtn *aboutBtn;
@property (weak, nonatomic) IBOutlet leftMainBtn *pointBtn;

- (IBAction)ownInfoBtnClick:(leftMainBtn *)sender;
- (IBAction)aboutBtnClick:(leftMainBtn *)sender;
- (IBAction)pointBtnClick:(leftMainBtn *)sender;
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@property (nonatomic,strong) NSMutableArray *categoryArray;

@end

@implementation leftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.ownInfoBtn setImage:[UIImage imageNamed:@"username"] forState:UIControlStateNormal];
    [self.aboutBtn setImage:[UIImage imageNamed:@"pointMallicon"] forState:UIControlStateNormal];
    [self.pointBtn setImage:[UIImage imageNamed:@"username"] forState:UIControlStateNormal];

    self.categoryArray = [[NSMutableArray alloc] initWithObjects: @"全部", @"女装", @"男装", @"鞋包", @"美妆", @"配饰", @"居家",@"母婴",@"美食",@"数码电器",@"文体", nil];
    
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
    cell.categoryName.text = self.categoryArray[row];
    return cell;

}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
 
}






- (IBAction)ownInfoBtnClick:(leftMainBtn *)sender {
}

- (IBAction)aboutBtnClick:(leftMainBtn *)sender {
}

- (IBAction)pointBtnClick:(leftMainBtn *)sender {
}@end
