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

@interface ownBaseInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *ownTableview;
@property (nonatomic,strong) NSArray *infoArr;
@property (nonatomic,strong) NSArray *sexArr;
@property (nonatomic,weak) UIPickerView *sexPicker;
@property (nonatomic,weak) UIPickerView *addPicker;
@property (nonatomic,strong) UIDatePicker *dataPick;
@end

@implementation ownBaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资料";
    self.ownTableview.dataSource = self;
    self.ownTableview.delegate = self;
    
    
    self.infoArr = [[NSArray alloc]initWithObjects: @"头像", @"用户名", @"性别", @"生日",nil];
    self.sexArr = [[NSArray alloc]initWithObjects: @"男", @"女",nil];
    
    self.dataPick = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, kScreen_Height, 0, 0)];
    [self.view addSubview:self.dataPick];
    UIPickerView *sexPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kScreen_Height, 0, 216)];
//    UIPickerView *addPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, 320, 216)];
//    sexPicker.hidden = YES;
//    addPicker.hidden = YES;
//    sexPicker.showsSelectionIndicator=YES;
//    addPicker.showsSelectionIndicator = YES;
    self.sexPicker = sexPicker;
    sexPicker.dataSource = self;
    sexPicker.delegate = self;
    sexPicker.showsSelectionIndicator=YES;
//    self.addPicker = addPicker;
    
    [self.view addSubview:sexPicker];
//    [self.view addSubview:addPicker];
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
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
        cell.detailTextLabel.text = self.infoArr[row];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.text = self.infoArr[row];
    
    return cell;
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = [indexPath row];
    if (row==2) {
        self.dataPick.frame = CGRectMake(0, kScreen_Height, 0, 0);
        [UIView animateWithDuration:.5 animations:^{
            self.sexPicker.frame =CGRectMake(0, kScreen_Height-226, 0, 0);
        } completion:^(BOOL finished) {
            
        }];
    }
    
    if (row ==3) {
        self.sexPicker.frame = CGRectMake(0, kScreen_Height, 0, 0);
        [UIView animateWithDuration:.5 animations:^{
            self.dataPick.frame = CGRectMake(0, kScreen_Height-226, 0, 0);
        } completion:^(BOOL finished) {
            
        }];
        
        
    }
    
    
    
}

#pragma mark pickView delegate and datasoure
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
//返回当前列显示的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.sexArr.count;
}

-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.sexArr[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    myLog(@"picker=======%@",self.sexArr[row]);

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
