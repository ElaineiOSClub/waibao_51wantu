//
//  ClassifySearchViewController.m
//  51wantu
//
//  Created by elaine on 15/8/8.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "ClassifySearchViewController.h"
#import "UIViewController+MMneed.h"

#import "HomeCell.h"
#import "BaseDatasModel.h"
#import "BaseDataModel.h"
#import "MyFlowLayOut.h"
#import "ClassifyModel.h"
#import "HttpTool.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "UIWebViewController.h"

static NSString *cellID = @"cell";

@interface ClassifySearchViewController ()<UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) BaseDatasModel *model;
@property (nonatomic, strong) NSMutableArray *arrayList;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, copy) NSString *text;
@end

@implementation ClassifySearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
    //
}




#pragma mark - event Response
- (void)loadData
{
    self.currentPage = 1;
    
    //[[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=gethomedata&page=%ld&pagesize=20&keyword=%@",self.currentPage,self.text] stringByAddingPercentEscapesUsingEncoding:NSUTF16StringEncoding]
    
//    NSString *xxx = [[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=gethomedata&page=%ld&pagesize=20&keyword=%@",self.currentPage,self.text] stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)];
    
    myLog(@"%@",[[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=gethomedata&page=%ld&pagesize=20&keyword=%@",self.currentPage,self.text] stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)]);
    [HttpTool httpToolGet:[[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=gethomedata&page=%ld&pagesize=20&keyword=%@",self.currentPage,self.text] stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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

- (void)pullUpReRefreshing
{
    __weak __typeof(self) weakSelf = self;
    // 上拉刷新
    self.collectionView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        self.currentPage++;
        

        
        [HttpTool httpToolGet:[[NSString stringWithFormat:@"http://www.51wantu.com/api/api.php?action=gethomedata&page=%ld&pagesize=20&keyword=%@",self.currentPage,self.text] stringByAddingPercentEscapesUsingEncoding:CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
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



#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    UIButton *btn=[searchBar valueForKey:@"_cancelButton"];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
   
}

//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
//{
//    if (searchText.length) {
//        [self.view addSubview:self.collectionView];
//        [self loadData];
//        [self pullUpReRefreshing];
//    } else {
//        [self.collectionView removeFromSuperview];
//    }
//}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if (searchBar.text.length) {
        self.text = searchBar.text;
        [self loadData];
        [self pullUpReRefreshing];
    }
    
   
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
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

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    [self.searchBar resignFirstResponder];
//}




@end
