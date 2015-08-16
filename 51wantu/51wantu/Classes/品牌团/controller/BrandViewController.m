//
//  BrandViewController.m
//  51wantu
//
//  Created by elaine on 15/8/8.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "BrandViewController.h"
#import "UIViewController+MMneed.h"
#import "MyFlowLayOut.h"
#import "HttpTool.h"
#import "MJRefresh.h"
#import "MJExtension.h"

#import "BrandBreviaryList.h"
#import "BaseDataModel.h"
#import "ClassifyModel.h"
#import "BrandHomeCell.h"
#import "BrankHomeLayout.h"
#import "UIViewController+PushNotification.h"
#import "UIWebViewController.h"
#import "BrandDetailViewController.h"


@interface BrandViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,BrandHomeCellDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *arrayList;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger totalpage;

@end


static NSString *cellID = @"cell";

@implementation BrandViewController

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
    [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=getbrandlist&page=%ld&pagesize=20",self.currentPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        self.model = [BaseDatasModel objectWithKeyValues:responseObject];
        self.totalpage = [responseObject[@"totalpage"] integerValue];
        if (self.arrayList) [self.arrayList removeAllObjects];
        
        NSMutableArray *datas = [BrandBreviaryList objectArrayWithKeyValuesArray:responseObject[@"datas"]];
        
        [self.arrayList addObjectsFromArray:datas];
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
        [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=getbrandlist&page=%ld&pagesize=20",self.currentPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
            NSMutableArray *datas = [BrandBreviaryList objectArrayWithKeyValuesArray:responseObject[@"datas"]];
            
            [self.arrayList addObjectsFromArray:datas];
            [self.collectionView reloadData];
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
    NSString *cate_id = notification.userInfo[@"id"];
    NSString *cate_name = notification.userInfo[@"cate_name"];
    
    //刷新所有
    if ([cate_name isEqualToString:@"全部"]) {
        [self loadData];
        [self pullDownRefreshing];
        [self pullUpReRefreshing];
        
    } else {
        NSArray *arr = [ClassifyModel getBrandCate];
        for (NSDictionary *dict in arr) {
            if ([dict[@"cate_name"] isEqualToString:cate_name]) {
                cate_id = dict[@"id"];
            }
        }
        self.currentPage = 1;
        [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=getbrandlist&tid=%@&page=%ld&pagesize=20",cate_id,self.currentPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if (self.arrayList) [self.arrayList removeAllObjects];
            
                NSMutableArray *datas = [BrandBreviaryList objectArrayWithKeyValuesArray:responseObject[@"datas"]];

            [self.arrayList addObjectsFromArray:datas];
            [self.collectionView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
        __weak __typeof(self) weakSelf = self;
        // 上拉刷新
        self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            // 进入刷新状态后会自动调用这个block
            weakSelf.currentPage++;
            
            [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=gethomedata&pid=%@&page=%ld&pagesize=20",cate_id,self.currentPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSMutableArray *datas = [BrandBreviaryList objectArrayWithKeyValuesArray:responseObject[@"datas"]];
                
                [weakSelf.arrayList addObjectsFromArray:datas];
                [weakSelf.collectionView reloadData];

                // 结束刷新
                [weakSelf.collectionView.footer endRefreshing];
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                // 结束刷新
                [weakSelf.collectionView.footer endRefreshing];
                
            }];
        }];
    }
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
    BrandHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID   forIndexPath:indexPath];
    cell.delegate = self;
    cell.brandBreviaryList = self.arrayList[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//    
//    BaseDataModel *model = self.arrayList[indexPath.row
//                                          ];
//    UIWebViewController *vc = [[UIWebViewController alloc] init];
//    vc.urlStr = model.item_url;
//    
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - brandHomeCellDelegate
- (void)brandHomeCell:(BrandHomeCell *)cell didSelectItem:(BaseDataModel *)item
{
    UIWebViewController *vc = [[UIWebViewController alloc] init];
    vc.urlStr = item.item_url;

    [self.navigationController pushViewController:vc animated:YES];
}

- (void)brandHomeCell:(BrandHomeCell *)cell moreProductFromBrandID:(NSString *)brandID BrandName:(NSString *)brandName
{
    BrandDetailViewController *vc = [[BrandDetailViewController alloc] init];
    vc.ID = brandID;
    vc.title = brandName;
    [self.navigationController pushViewController:vc animated:YES];
}



-(void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self openDrawerGesture];
    [self registerNotification:@selector(refresh:)];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self colseDrawerGesture];
    [self removeNotification];
    
}

#pragma mark - lazy
- (UICollectionView *)collectionView
{
    if (!_collectionView) {

        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[BrankHomeLayout alloc] init]];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = RGBA(242, 242, 242, 1);
        
        [_collectionView registerNib:[UINib nibWithNibName:@"BrandHomeCell" bundle:nil] forCellWithReuseIdentifier:cellID];
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
