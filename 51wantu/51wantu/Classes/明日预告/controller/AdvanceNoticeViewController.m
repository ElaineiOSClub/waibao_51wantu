//
//  AdvanceNoticeViewController.m
//  51wantu
//
//  Created by elaine on 15/8/8.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "AdvanceNoticeViewController.h"
#import "UIViewController+MMneed.h"
#import "MyFlowLayOut.h"
#import "BaseDatasModel.h"
#import "BaseDataModel.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "AdvanceNoticeCell.h"
#import "UIWebViewController.h"
#import "ClassifyModel.h"

static NSString *cellID = @"cell";
@interface AdvanceNoticeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BaseDatasModel *model;
@property (nonatomic, strong) NSMutableArray *arrayList;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSString *urlStr;
@end

@implementation AdvanceNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加集合视图
    [self.view addSubview:self.collectionView];
    
    [self loadData];
    [self pullDownRefreshing];
    [self pullUpReRefreshing];
    
}

#pragma mark - event Response
- (void)loadData
{
    [HttpTool httpToolGet:@"http://www.51wantu.com/api/api.php?action=gethomedata&page_type=yugao&page=1&pagesize=20" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.model = [BaseDatasModel objectWithKeyValues:responseObject];
        if (self.arrayList) [self.arrayList removeAllObjects];
        
        for (BaseDataModel *model in self.model.datas) {
            NSString *name = [ClassifyModel getBigCate][model.pid];
            model.classifyName = name;
        }
        [self.arrayList addObjectsFromArray:self.model.datas];
        self.currentPage = self.model.currentpage;
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
        [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=gethomedata&page_type=yugao&page=%ld&pagesize=20",self.currentPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            BaseDatasModel *model = [BaseDatasModel objectWithKeyValues:responseObject];
            for (BaseDataModel *m in model.datas) {
                m.classifyName = [ClassifyModel getBigCate][m.pid];
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


- (void)refresh:(NSNotification *)notification
{
    NSString *pid = notification.userInfo[@"cid"];
    self.currentPage = 1;
    
    [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=gethomedata&pid=1&cid=%@page=%ld&pagesize=20",pid,self.currentPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.model = [BaseDatasModel objectWithKeyValues:responseObject];
        if (self.arrayList) [self.arrayList removeAllObjects];
        
        for (BaseDataModel *model in self.model.datas) {
            NSString *name = [ClassifyModel getSubCate][model.cid];
            model.classifyName = name;
        }
        
        [self.arrayList addObjectsFromArray:self.model.datas];
        [self.collectionView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    [self.collectionView.footer removeFromSuperview];
    
    __weak __typeof(self) weakSelf = self;
    // 上拉刷新
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        self.currentPage++;
        
        [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=gethomedata&pid=1&cid=%@page=%ld&pagesize=20",pid,self.currentPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            BaseDatasModel *model = [BaseDatasModel objectWithKeyValues:responseObject];
            
            for (BaseDataModel *m in model.datas) {
                m.classifyName = [ClassifyModel getSubCate][m.cid];
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
    AdvanceNoticeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID   forIndexPath:indexPath];
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
        [_collectionView registerNib:[UINib nibWithNibName:@"AdvanceNoticeCell" bundle:nil] forCellWithReuseIdentifier:cellID];
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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self openDrawerGesture];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self colseDrawerGesture];
}




@end
