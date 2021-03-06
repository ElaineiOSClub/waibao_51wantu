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
#import "UUDatePicker.h"
#import "UIImageView+WebCache.h"

@interface ownBaseInfoViewController ()<UITableViewDataSource,UITableViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UUDatePickerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *ownTableview;
@property (nonatomic,strong) NSArray *infoArr;
@property (nonatomic,strong) NSArray *sexArr;
@property (nonatomic,weak) UIPickerView *sexPicker;
@property (nonatomic,weak) UIPickerView *addPicker;
@property (nonatomic,strong) UIDatePicker *dataPick;
@property (nonatomic,strong) UIImagePickerController *imagePicker;
@property (nonatomic,copy) NSString *nameStr;
@property (nonatomic,strong) NSData *headImageData;

@property (nonatomic,strong) UIImageView *headImage;

@property (nonatomic,strong) UUDatePicker * datePicker;

@property (nonatomic,strong) UIView *bgView;


@property (nonatomic, copy) NSString *sexText;

@property (nonatomic, copy) NSString *dataText;

@end

@implementation ownBaseInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的资料";
    self.ownTableview.dataSource = self;
    self.ownTableview.delegate = self;
    self.infoArr = [[NSArray alloc]initWithObjects: @"头像", @"用户名", @"性别", @"生日",nil];
    self.sexArr = [[NSArray alloc]initWithObjects: @"男", @"女",nil];
    UIPickerView *sexPicker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, kScreen_Height, 0, 216)];
    self.sexPicker = sexPicker;
    sexPicker.dataSource = self;
    sexPicker.delegate = self;
    sexPicker.showsSelectionIndicator=YES;
    
    [self.view addSubview:sexPicker];
    NSDate *now = [NSDate date];
    UIView *bgView = [[UIView alloc]init];
    bgView.frame = CGRectMake(0, kScreen_Height, kScreen_Width, 220);
    UUDatePicker *datePicker= [[UUDatePicker alloc]initWithframe:CGRectMake(0, 40, kScreen_Width, 180)
                                                        Delegate:self
                                                     PickerStyle:UUDateStyle_YearMonthDay];
    datePicker.ScrollToDate = now;
//    datePicker.backgroundColor = [UIColor whiteColor];
    self.headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    UIToolbar *toolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 40)];
    
    toolBar.barStyle = UIBarButtonItemStylePlain;
    UIBarButtonItem* barItem1 = [[UIBarButtonItem alloc] initWithTitle:@"确认" style:UIBarButtonItemStylePlain  target:self action:@selector(buttonPress)];
    
    
    UIBarButtonItem* barItem2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    
    UIBarButtonItem* barItem3 = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain  target:self action:@selector(cancelPress)];
    
    
    [toolBar setItems:[NSArray arrayWithObjects:barItem1,barItem2,barItem3,nil]];
    
    //    [self.view addSubview:toolBar];
    [bgView addSubview:toolBar];

    [bgView addSubview:datePicker];
    [self.view addSubview:bgView];
    bgView.backgroundColor = [UIColor whiteColor];
    self.bgView = bgView;

}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    NSString *nameStr = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USERNAME];
    self.nameStr = nameStr;
    
    NSString *headImage = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_HEADPIC];
    if (headImage) {
        
        NSString *headUrlStr = [NSString stringWithFormat:@"http://www.51wantu.com/%@",headImage];
        NSURL *headUrl = [NSURL URLWithString:headUrlStr];
        
        [self.headImage sd_setImageWithURL:headUrl];
        [self.ownTableview reloadData];
    }
    
    
//    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"imageData"];
//    if (imageData) {
//        self.headImageData = imageData;
//        [self.ownTableview reloadData];
//        
//    }
    
    [self colseDrawerGesture];
    [[Util getAppDelegate].drawerController setMaximumLeftDrawerWidth:kScreen_Width +10];
    
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self openDrawerGesture];
    [[Util getAppDelegate].drawerController setMaximumLeftDrawerWidth:kScreen_Width -40*kScaleInWith];
}

-(void)downHeadImage
{




}


-(void)buttonPress
{
    
    [UIView animateWithDuration:.5 animations:^{
        self.bgView.frame = CGRectMake(0, kScreen_Height, kScreen_Width, 220);
        self.sexPicker.frame = CGRectMake(0, kScreen_Height, kScreen_Width, 216);
        
    } ];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:0];
    [self.ownTableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}


-(void)cancelPress
{
    [UIView animateWithDuration:.5 animations:^{
        self.bgView.frame = CGRectMake(0, kScreen_Height, kScreen_Width, 220);
        self.sexPicker.frame = CGRectMake(0, kScreen_Height, kScreen_Width, 216);
        
    } ];
    
}
- (void)uuDatePicker:(UUDatePicker *)datePicker
                year:(NSString *)year
               month:(NSString *)month
                 day:(NSString *)day
                hour:(NSString *)hour
              minute:(NSString *)minute
             weekDay:(NSString *)weekDay
{
    myLog(@"datePicker==========%@========",[NSString stringWithFormat:@"%@-%@-%@ %@:%@",year,month,day,hour,minute]);
    
    self.dataText = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
    
    

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

    
    static NSString *const oneCell = @"oneCell";
    static NSString *const twoCell = @"twoCell";
    
    
    
    if (indexPath.row == 0) {
        showInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:oneCell];
        if (!cell) {
            cell = [showInfoCell getshowInfoCell];
             NSString *headImage = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_HEADPIC];
            NSString *headUrlStr = [NSString stringWithFormat:@"http://www.51wantu.com/%@",headImage];
              NSURL *headUrl = [NSURL URLWithString:headUrlStr];
            [cell.headImage sd_setImageWithURL:headUrl];
            cell.textLabel.text = self.infoArr[indexPath.row];
        }
        return cell;
        
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:twoCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:twoCell];
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.text = self.infoArr[indexPath.row];
        
        if (indexPath.row == 1) {
            NSString *userName = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USERNAME];
            cell.detailTextLabel.text = userName;
        }  else if (indexPath.row == 2) {
            cell.detailTextLabel.text = self.sexText == nil?@"男":self.sexText;
        }  else {
            cell.detailTextLabel.text = self.dataText == nil ? @"1989-11-01" : self.dataText;
        }
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
        self.bgView.frame = CGRectMake(0, kScreen_Height, kScreen_Width, 220);
        [UIView animateWithDuration:.5 animations:^{
            self.sexPicker.frame = CGRectMake(0, kScreen_Height-226, kScreen_Width, 216);
        } completion:^(BOOL finished) {
            
        }];
        
    }
    
    if (row ==3) {
        self.sexPicker.frame = CGRectMake(0, kScreen_Height, kScreen_Width, 216);
        [UIView animateWithDuration:.5 animations:^{
            self.bgView.frame = CGRectMake(0, kScreen_Height - 220, kScreen_Width, 220);
        } ];
        
        
        
    }
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{

    [UIView animateWithDuration:.5 animations:^{
        self.bgView.frame = CGRectMake(0, kScreen_Height, kScreen_Width, 220);
        self.sexPicker.frame = CGRectMake(0, kScreen_Height, kScreen_Width, 216);
        
    } ];



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

static NSData *imageData = nil;

- (void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *image= [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImageWriteToSavedPhotosAlbum (image, nil, nil , nil);    //保存到library
    }
    

    myLog(@"=======上传");
    
//    CGSize imagesize = image.size;
//    imagesize.height =200;
//    imagesize.width =200;
//    //对图片大小进行压缩--
//    image = [self imageWithImage:image scaledToSize:imagesize];
    
    imageData = UIImageJPEGRepresentation(image, 0.01);
//    [self postRequestWithImageData:imageData back:^(NSArray *url, NSArray *names) {
//        
//        
//    }];
    
//    NSMutableDictionary * dir=[[NSMutableDictionary alloc] init];
//    [dir setValue:@"/user/company/auth/" forKey:@"pathName"];
//    //    NSString *url=@"http://192.168.1.88:8080/star/event/eventPhoto.html";
//    NSString *img1 = @"/Users/elaine/桌面/123.jpg";
//    
    [self postRequestWithImageData:imageData back:^(NSArray *url, NSArray *names) {
        
    }];
    
    
    myLog(@"=======上传");
    //[self postRequestWithpostParems:dir picFilePaths:img1 back:^(NSArray *url, NSArray *names) {
        
        
        
    //}];
    
    
    

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
    
    self.sexText = self.sexArr[row];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:2 inSection:0];
    [self.ownTableview reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
    

}

typedef void (^Backs)(NSArray *url, NSArray *names);
static NSString * const FORM_FLE_INPUT = @"pic";

-(void)postRequestWithImageData:(NSData *)data // IN  // IN
                            back:(Backs)backs
{
    
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_TOKEN];
    
    //url
    NSString *url = [NSString stringWithFormat:@"http://www.51wantu.com/uploadfav.php?token=%@", token];
    url = @"http://192.168.21.29:8082/Handler1.ashx";
    NSString *TWITTERFON_FORM_BOUNDARY = @"0xKhTmLbOuNdArY";
    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    
    //声明myRequestData，用来放入http body

    NSMutableData *myRequestData=[NSMutableData data];
    
    NSMutableString *body = [NSMutableString string];
    //添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
            
    //声明pic字段，文件名为boris.png
    [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",FORM_FLE_INPUT,@"123.jpg"];
    //声明上传文件的格式
    NSString *type = @"jpg";
    [body appendFormat:@"Content-Type: image/%@\r\n\r\n", type];
       
        
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    [myRequestData appendData:data];
    
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    
    NSString *line=[[NSString alloc]initWithFormat:@"\r\n"];
    [myRequestData appendData:[line dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%ld", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        myLog(@"data:>>>>>>>>\n%@", str);
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if (dic) {
            NSArray *names = [dic objectForKey:@"fileList"];
            NSArray *urls = [dic objectForKey:@"urlList"];
            dispatch_async(dispatch_get_main_queue(), ^{
                backs(urls, names);
            });
        } else {
            myLog(@"############   dict = nil!   ############");
        }
    }];
    [task resume];
}


-(void)postRequestWithpostParems: (NSDictionary *)postParems // IN
                    picFilePaths: (NSString *)picFilePaths  // IN
                            back:(Backs)backs
{
    
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_TOKEN];
    
    //url
    NSString *url = [NSString stringWithFormat:@"http://www.51wantu.com/uploadfav.php?token=%@", token];
    url = @"http://192.168.21.29:8082/Handler1.ashx";

    NSString *TWITTERFON_FORM_BOUNDARY = @"0xKhTmLbOuNdArY";
    //根据url初始化request
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:10];
    //分界线 --AaB03x
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符 AaB03x--
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //得到图片的data
    NSData* data;
    
    
    
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    
    NSMutableData *myRequestData=[NSMutableData data];
    

        NSString *picFilePath = picFilePaths;
        NSString *type = [[picFilePath componentsSeparatedByString:@"."] lastObject];
        if(picFilePath){
            
            UIImage *image=[UIImage imageWithContentsOfFile:picFilePath];
            //判断图片是不是png格式的文件
            if (UIImagePNGRepresentation(image)) {
                //返回为png图像。
                data = UIImagePNGRepresentation(image);
            }else {
                //返回为JPEG图像。
                data = UIImageJPEGRepresentation(image, 1.0);
            }
        }
        //http body的字符串
        NSMutableString *body=[[NSMutableString alloc]init];
        //参数的集合的所有key的集合
        
        NSArray *keys= [postParems allKeys];
        
        //遍历keys
        for(int i=0;i<[keys count];i++)
        {
            //得到当前key
            NSString *key=[keys objectAtIndex:i];
            
            //添加分界线，换行
            [body appendFormat:@"%@\r\n",MPboundary];
            //添加字段名称，换2行
            [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
            //添加字段的值
            [body appendFormat:@"%@\r\n",[postParems objectForKey:key]];
            
            myLog(@"添加字段的值==%@",[postParems objectForKey:key]);
        }
        NSString *picFileName = [[picFilePath componentsSeparatedByString:@"/"] lastObject];
        if(picFilePath){
            ////添加分界线，换行
            [body appendFormat:@"%@\r\n",MPboundary];
            
            //声明pic字段，文件名为boris.png
            [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n",FORM_FLE_INPUT,picFileName];
            //声明上传文件的格式
            [body appendFormat:@"Content-Type: image/%@\r\n\r\n", type];
        }
        
        //将body字符串转化为UTF8格式的二进制
        [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
        if(picFilePath){
            //将image的data加入
            [myRequestData appendData:imageData];
        }
    
   
            NSString *line=[[NSString alloc]initWithFormat:@"\r\n"];
            [myRequestData appendData:[line dataUsingEncoding:NSUTF8StringEncoding]];
    
 
    
    
    //加入结束符--AaB03x--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%ld", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        myLog(@"data:>>>>>>>>\n%@", str);
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        
        if (dic) {
            NSArray *names = [dic objectForKey:@"fileList"];
            NSArray *urls = [dic objectForKey:@"urlList"];
            dispatch_async(dispatch_get_main_queue(), ^{
                backs(urls, names);
            });
        } else {
            myLog(@"############   dict = nil!   ############");
        }
    }];
    [task resume];
}



@end
