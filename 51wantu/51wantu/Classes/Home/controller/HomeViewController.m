//
//  HomeViewController.m
//  51wantu
//
//  Created by elaine on 15/8/8.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "HomeViewController.h"
#import "MyFlowLayOut.h"
#import "HomeCell.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "BaseDatasModel.h"
#import "BaseDataModel.h"


#import "MJRefresh.h"

static NSString *cellID = @"cell";

@interface HomeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BaseDatasModel *model;
@property (nonatomic, strong) NSMutableArray *arrayList;
@property (nonatomic, assign) NSInteger currentPage;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.arrayList = [NSMutableArray array];
    
    MyFlowLayOut *layout = [[MyFlowLayOut alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.collectionView];
    
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    
    
    
    [HttpTool httpToolGet:@"http://www.51wantu.com/api/api.php?action=gethomedata&page=1&pagesize=20" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        myLog(@"%@",responseObject);
        
        self.model = [BaseDatasModel objectWithKeyValues:responseObject];
        [self.arrayList addObjectsFromArray:self.model.datas];
        self.currentPage = self.model.currentpage;
        [self.collectionView reloadData];
        
        
        
        // 上拉刷新
        self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            // 进入刷新状态后会自动调用这个block
            self.currentPage ++;
           
            [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=gethomedata&page=%ld&pagesize=20",self.currentPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                myLog(@"%@",responseObject);
                
                BaseDatasModel *model = [BaseDatasModel objectWithKeyValues:responseObject];
                [self.arrayList addObjectsFromArray:model.datas];
                [self.collectionView reloadData];
                
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                
            }];
            

            
            
        }];


    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    
    
}



- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
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
    BaseDataModel *model = self.model[indexPath.row];
    
}


@end
