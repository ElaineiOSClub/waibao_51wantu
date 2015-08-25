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

#import "ClassifyModel.h"




static NSString *cellID = @"cellID";


@interface ClassifyHomeController ()<UISearchBarDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation ClassifyHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    
    self.searchBar = [[UISearchBar alloc] init];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.delegate = self;
    self.navigationItem.titleView = self.searchBar;
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

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
   
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
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



@end
