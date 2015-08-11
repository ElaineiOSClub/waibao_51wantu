//
//  ExemptionPostageViewController.m
//  51wantu
//
//  Created by elaine on 15/8/8.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "ExemptionPostageViewController.h"

#import "MyFlowLayOut.h"
#import "HomeCell.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "BaseDatasModel.h"
#import "BaseDataModel.h"


#import "MJRefresh.h"
#import "UIWebViewController.h"
static NSString *cellID = @"cell";
@interface ExemptionPostageViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BaseDatasModel *model;
@property (nonatomic, strong) NSMutableArray *arrayList;
@property (nonatomic, assign) NSInteger currentPage;
@end

@implementation ExemptionPostageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.currentPage = 0;
    self.arrayList = [NSMutableArray array];
    MyFlowLayOut *layout = [[MyFlowLayOut alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64,kScreen_Width, kScreen_Height-64-49) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = RGBA(242, 242, 242, 1);
    
    [self.view addSubview:self.collectionView];
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    
    
    
    [HttpTool httpToolGet:@"http://www.51wantu.com/api/api.php?action=gethomedata&pid=1&page=1&pagesize=10" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        myLog(@"%@",responseObject);
        
        self.model = [BaseDatasModel objectWithKeyValues:responseObject];
        [self.arrayList addObjectsFromArray:self.model.datas];
        self.currentPage = self.model.currentpage;
        [self.collectionView reloadData];
        
     
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    // 上拉刷新
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        self.currentPage ++;
        
        [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=gethomedata&pid=1&page=%ld&pagesize=10",self.currentPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            myLog(@"%@",responseObject);
            
            BaseDatasModel *model = [BaseDatasModel objectWithKeyValues:responseObject];
            [self.arrayList addObjectsFromArray:model.datas];
            [self.collectionView reloadData];
            // 结束刷新
            [self.collectionView.footer endRefreshing];
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            // 结束刷新
            [self.collectionView.footer endRefreshing];

        }];
    }];
    
    self.collectionView.footer.hidden = YES;
    
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    self.collectionView.footer.hidden = self.arrayList.count == 0;
    return self.arrayList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID   forIndexPath:indexPath];
    cell.model = self.arrayList[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    BaseDataModel *model = self.arrayList[indexPath.row
                                          ];
    UIWebViewController *vc = [[UIWebViewController alloc] init];
    vc.urlStr = model.item_url;
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
