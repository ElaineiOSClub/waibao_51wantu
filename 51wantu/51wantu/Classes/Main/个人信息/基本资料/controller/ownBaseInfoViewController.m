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
#import "FDActionSheet.h"
#import "showInfoCell.h"

@interface ownBaseInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *ownTableview;
@property (nonatomic,strong) NSArray *infoArr;
@property (nonatomic,strong) NSArray *sexArr;
@property (nonatomic,weak) UIPickerView *sexPicker;
@property (nonatomic,weak) UIPickerView *addPicker;
@property (nonatomic,strong) UIDatePicker *dataPick;
@property (nonatomic,strong) UIImagePickerController *imagePicker;
@property (nonatomic,copy) NSString *nameStr;
@property (nonatomic,strong) NSData *headImageData;
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
    
    NSString *nameStr = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USERNAME];
    self.nameStr = nameStr;
    
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"imageData"];
    if (imageData) {
        self.headImageData = imageData;
        [self.ownTableview reloadData];
        
    }
    
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row ==0)
        return 70;
    else
        return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row ==0) {
        showInfoCell * cell = [showInfoCell getshowInfoCell];
        cell.headImage.image = [[UIImage alloc]initWithData:self.headImageData];
        cell.textLabel.text = self.infoArr[0];
        return cell;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.infoArr[indexPath.row];
        return cell;
    }
    
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = [indexPath row];
    
    
    if (row==0) {
        [self actionSheet];
    }
    
    
    
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
#pragma mark-actionSheet
- (void)actionSheet
{
    FDActionSheet *sheet = [[FDActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"拍照", @"从相册选取", nil];
    [sheet show];
}

- (void)actionSheet:(FDActionSheet *)sheet clickedButtonIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 1:
            [self pickImageFromAlbum];
            break;
        case 0:
            [self pickImageFromCamera];
            break;
        default:
            break;
    }
    
}

#pragma mark-imagePicker
- (void)pickImageFromAlbum
{
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    _imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    _imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    _imagePicker.allowsEditing = YES;
    
    [self presentViewController:_imagePicker animated:YES completion:nil];
}

- (void)pickImageFromCamera
{
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [Util showAlertWithTitle:@"提示" msg:@"摄像头不可用"];
        return;
    }
    _imagePicker = [[UIImagePickerController alloc] init];
    _imagePicker.delegate = self;
    
    _imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    _imagePicker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    _imagePicker.allowsEditing = YES;
    
    [self presentViewController:_imagePicker animated:YES completion:nil];
}

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImageWriteToSavedPhotosAlbum (image, nil, nil , nil);    //保存到library
    }
    
//    CGSize imagesize = image.size;
//    imagesize.height =200;
//    imagesize.width =200;
//    //对图片大小进行压缩--
//    image = [self imageWithImage:image scaledToSize:imagesize];
    
    NSData *imageData = UIImageJPEGRepresentation(image, 0.01);

    [[NSUserDefaults standardUserDefaults]setObject:imageData forKey:@"imageData"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}
//压缩图片大小
- (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    
    
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
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
