//
//  mineViewController.m
//  51wantu
//
//  Created by kevin on 15/8/16.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "mineViewController.h"
#import "UIViewController+MMneed.h"
#import "Util.h"


#import "MyFlowLayOut.h"
#import "HomeCell.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "BaseDatasModel.h"
#import "BaseDataModel.h"
#import "UIViewController+MMneed.h"


#import "MJRefresh.h"
#import "UIWebViewController.h"
#import "UIViewController+PushNotification.h"

#import "ClassifyModel.h"


@interface mineViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BaseDatasModel *model;
@property (nonatomic, strong) NSMutableArray *arrayList;
@property (nonatomic, assign) NSInteger currentPage;
@end


static NSString *cellID = @"cell";
@implementation mineViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    
    
    
  
    
    
    
    
    
    
}



#pragma mark - event Response
- (void)loadData
{
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_TOKEN];
    
    self.currentPage = 1;
    
    
    
    [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=getfavlist&page=1&pagesize=20&token=%@",token] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    NSString *token = [[NSUserDefaults standardUserDefaults] stringForKey:KEY_TOKEN];
    
    __weak __typeof(self) weakSelf = self;
    // 上拉刷新
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        self.currentPage++;
        [HttpTool httpToolGet:[NSString stringWithFormat:@"hhttp://www.51wantu.com/api/api.php?action=getfavlist&page=%ld&pagesize=20&token=%@",self.currentPage,token] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
        [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=gethomedata&pid=%@&page=%ld&pagesize=20",cate_id,self.currentPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
            
            [HttpTool httpToolGet:[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=gethomedata&pid=%@&page=%ld&pagesize=20",cate_id,self.currentPage] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    vc.itemID = model.ID;
    vc.urlStr = model.item_url;
    
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGRect frame = self.view.frame;
    frame.size = CGSizeMake(kScreen_Width, kScreen_Height);
    self.view.frame = frame;
    
    myLog(@"%@",NSStringFromCGRect(self.view.frame));
    //添加集合视图
    [self.view addSubview:self.collectionView];
    [self loadData];
    [self pullDownRefreshing];
    [self pullUpReRefreshing];
    
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
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
