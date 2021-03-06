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
#import "UIViewController+PushNotification.h"

#import "DockItem.h"

static NSString *cellID = @"cell";
@interface AdvanceNoticeViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BaseDatasModel *model;
@property (nonatomic, strong) NSMutableArray *arrayList;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) NSString *urlStr;

@property (nonatomic, weak) DockItem *item;
@end

@implementation AdvanceNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //添加集合视图
    [self.view addSubview:self.collectionView];
    
    [self loadData];
    [self pullDownRefreshing];
    [self pullUpReRefreshing];
    
    DockItem *item = [[DockItem alloc] initWithFrame:CGRectZero];
    [item setImage:[UIImage imageNamed:@"arrow_top"] forState:UIControlStateNormal];
    [item setTitle:@"顶部" forState:UIControlStateNormal];
    [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    item.layer.borderWidth = 1;
    item.layer.borderColor = [UIColor lightGrayColor].CGColor;
    item.size = CGSizeMake(50, 50);
    item.backgroundColor = [UIColor whiteColor];
    item.layer.cornerRadius = 25;
    item.origin = CGPointMake(kScreen_Width - 50 - 10, kScreen_Height - 50 - 49 - 10);
    [item addTarget:self action:@selector(top:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:item];
    _item = item;
    _item.alpha = 0 ;
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    myLog(@"%@",NSStringFromCGPoint(scrollView.contentOffset));
    
    if (scrollView.contentOffset.y > 200) {
        [UIView animateWithDuration:1 animations:^{
            self.item.alpha = 1;
        }];
        
    } else {
        [UIView animateWithDuration:1 animations:^{
            self.item.alpha = 0;
        }];
    }
    
}


#pragma mark - event Response

//回到顶部
- (void)top:(UIButton *)button
{
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
}

#pragma mark - event Response
- (void)loadData
{
    [HttpTool httpToolGet:@"http://www.51wantu.com/api/api.php?action=gethomedata&page_type=yugao&page=1&pagesize=20" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.model = [BaseDatasModel objectWithKeyValues:responseObject];
        if (self.arrayList) [self.arrayList removeAllObjects];
        
        for (BaseDataModel *model in self.model.datas) {
            NSArray *arr = [ClassifyModel getBigCate];
            for (NSDictionary *dict in arr) {
                if ([dict[@"id"] isEqualToString:model.pid]) {
                    model.classifyName = dict[@"cate_name"];
                }
            }
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
        [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=gethomedata&page_type=yugao&page=%ld&pagesize=20",(long)self.currentPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            BaseDatasModel *model = [BaseDatasModel objectWithKeyValues:responseObject];
            
            for (BaseDataModel *m in model.datas) {
                NSArray *arr = [ClassifyModel getBigCate];
                for (NSDictionary *dict in arr) {
                    if ([dict[@"id"] isEqualToString:m.pid]) {
                        m.classifyName = dict[@"cate_name"];
                    }
                }
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
    NSString *cate_id = notification.userInfo[@"id"];
    NSString *cate_name = notification.userInfo[@"cate_name"];
    
    
    //刷新所有
    if ([cate_name isEqualToString:@"全部"]) {
        [self loadData];
        [self pullDownRefreshing];
        [self pullUpReRefreshing];
        
    } else {
        NSArray *arr = [ClassifyModel getBigCate];
        for (NSDictionary *dict in arr) {
            if ([dict[@"cate_name"] isEqualToString:cate_name]) {
                cate_id = dict[@"id"];
            }
        }
        self.currentPage = 1;
        [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=gethomedata&page_type=yugao&pid=%@&page=%ld&pagesize=20",cate_id,self.currentPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            self.model = [BaseDatasModel objectWithKeyValues:responseObject];
            if (self.arrayList) [self.arrayList removeAllObjects];
            
            for (BaseDataModel *model in self.model.datas) {
                NSArray *arr = [ClassifyModel getBigCate];
                for (NSDictionary *dict in arr) {
                    if ([dict[@"id"] isEqualToString:model.pid]) {
                        model.classifyName = dict[@"cate_name"];
                    }
                }
            }
            
            
            
            [self.arrayList addObjectsFromArray:self.model.datas];
            [self.collectionView reloadData];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
        __weak __typeof(self) weakSelf = self;
        // 上拉刷新
        self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            // 进入刷新状态后会自动调用这个block
            self.currentPage++;
            
            [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=gethomedata&page_type=yugao&pid=%@&page=%ld&pagesize=20",cate_id,self.currentPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                BaseDatasModel *model = [BaseDatasModel objectWithKeyValues:responseObject];
                [weakSelf.arrayList addObjectsFromArray:model.datas];
                
                for (BaseDataModel *m in model.datas) {
                    NSArray *arr = [ClassifyModel getBigCate];
                    for (NSDictionary *dict in arr) {
                        if ([dict[@"id"] isEqualToString:m.pid]) {
                            m.classifyName = dict[@"cate_name"];
                        }
                    }
                }
                
                
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



@end
