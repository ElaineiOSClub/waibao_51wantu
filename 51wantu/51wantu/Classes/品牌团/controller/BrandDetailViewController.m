//
//  BrandDetailViewController.m
//  51wantu
//
//  Created by elaine on 15/8/16.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "BrandDetailViewController.h"
#import "BaseDatasModel.h"
#import "BaseDataModel.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "ClassifyModel.h"
#import "HomeCell.h"
#import "UIWebViewController.h"
#import "MyFlowLayOut.h"


static NSString *cellID = @"cell";

@interface BrandDetailViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BaseDatasModel *model;
@property (nonatomic, strong) NSMutableArray *arrayList;
@property (nonatomic, assign) NSInteger currentPage;

@end

@implementation BrandDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self loadData];
    [self pullDownRefreshing];
    [self pullUpReRefreshing];
    
    
}

#pragma mark - event Response
- (void)loadData
{
    self.currentPage = 1;
    [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=getbrandview&id=%@&page=%ld&pagesize=20",self.ID,self.currentPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.model = [BaseDatasModel objectWithKeyValues:responseObject];
        if (self.arrayList) [self.arrayList removeAllObjects];
        
        for (BaseDataModel *model in self.model.datas) {
            model.classifyName = @"包邮";
        }
        
        
        [self.arrayList addObjectsFromArray:self.model.datas];
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)pullDownRefreshing
{
    __weak __typeof(self) weakSelf = self;
    self.collectionView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 模拟延迟加载数据，因此2秒后才调用（真实开发中，可以移除这段gcd代码）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 结束刷新
            [weakSelf.collectionView.header endRefreshing];
        });
    }];
}

- (void)pullUpReRefreshing
{
    __weak __typeof(self) weakSelf = self;
    // 上拉刷新
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        self.currentPage++;
        if (self.currentPage > self.model.totalpage) {
            [weakSelf.collectionView.footer endRefreshing];
            return ;
        }
        
        [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=getbrandview&id=%@&page=%ld&pagesize=20",self.ID,self.currentPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            BaseDatasModel *model = [BaseDatasModel objectWithKeyValues:responseObject];
            
            for (BaseDataModel *m in model.datas) {
                m.classifyName = @"包邮";
            }
            [weakSelf.arrayList addObjectsFromArray:model.datas];
            [weakSelf.collectionView reloadData];
            // 结束刷新
            [weakSelf.collectionView.footer endRefreshing];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            // 结束刷新
            [weakSelf.collectionView.footer endRefreshing];
            
        }];
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    // 设置尾部控件的显示和隐藏
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

#pragma mark - lazy
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[MyFlowLayOut alloc] init]];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = RGBA(242, 242, 242, 1);
        
        [_collectionView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}

- (NSMutableArray *)arrayList
{
    if (!_arrayList) {
        _arrayList = [NSMutableArray array];
    }
    return _arrayList;
}



@end
