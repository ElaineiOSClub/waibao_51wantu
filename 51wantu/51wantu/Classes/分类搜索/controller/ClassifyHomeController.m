//
//  ClassifyHomeController.m
//  51wantu
//
//  Created by elaine on 15/8/24.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "ClassifyHomeController.h"
#import "ClassifyHomeCell.h"
#import "ClassifyHomeLayout.h"


#import "ClassifyDetailViewController.h"
#import "ClassifySearchViewController.h"

#import "ClassifyModel.h"




static NSString *cellID = @"cellID";


@interface ClassifyHomeController ()<UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate,ClassifySearchViewControllerDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) ClassifySearchViewController *classifySearchViewController;

@end

@implementation ClassifyHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
    
    
    self.navigationItem.leftBarButtonItem = nil;
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [ClassifyModel getBigCate].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ClassifyHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    NSDictionary *dict = [ClassifyModel getBigCate][indexPath.row];
    
    cell.cate_name = dict[@"cate_name"];
    cell.imageStr = [NSString stringWithFormat:@"%@classify",dict[@"cate_name"]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

    ClassifyDetailViewController *vc = [[ClassifyDetailViewController alloc] init];
     NSDictionary *dict = [ClassifyModel getBigCate][indexPath.row];
    vc.cate_id = dict[@"id"];
    vc.title = dict[@"cate_name"];
    [self.navigationController pushViewController:vc animated:YES];


}


#pragma mark - UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:YES];
    UIButton *btn=[searchBar valueForKey:@"_cancelButton"];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.classifySearchViewController.view removeFromSuperview];
    [self.view addSubview:self.classifySearchViewController.view];
    
    self.classifySearchViewController.text = searchBar.text;

}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
    [self.classifySearchViewController.view removeFromSuperview];
    searchBar.text = @"";
    
}

- (void)endEditing
{
    [self.searchBar resignFirstResponder];
    UIButton *btn=[self.searchBar valueForKey:@"_cancelButton"];
    btn.enabled = YES;
    
}


#pragma mark - lazy

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[[ClassifyHomeLayout alloc] init]];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = RGBA(242, 242, 242, 1);
        [_collectionView registerClass:[ClassifyHomeCell class] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}

- (ClassifySearchViewController *)classifySearchViewController
{
    if (!_classifySearchViewController) {
        _classifySearchViewController = [[ClassifySearchViewController alloc] init];
        [self addChildViewController:_classifySearchViewController];
        _classifySearchViewController.delegate = self;
    }
    return _classifySearchViewController;
}

//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//   [self.searchBar resignFirstResponder];
//}



@end
