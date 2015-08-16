//
//  BrandHomeCell.m
//  51wantu
//
//  Created by elaine on 15/8/16.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "BrandHomeCell.h"
#import "MyFlowLayOut.h"
#import "HomeCell.h"
#import "BaseDataModel.h"
#import "ClassifyModel.h"
#import "BrandBreviaryList.h"

static NSString *cellID = @"cell";

@interface BrandHomeCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *arrList;
@property (weak, nonatomic) IBOutlet UILabel *brandNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *zhekouLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;

@end

@implementation BrandHomeCell

- (void)awakeFromNib {
    [self addSubview:self.collectionView];
    self.moreBtn.layer.cornerRadius = 2;
}

- (void)setBrandBreviaryList:(BrandBreviaryList *)brandBreviaryList
{
    _brandBreviaryList = brandBreviaryList;
    self.brandNameLabel.text = brandBreviaryList.brand_name;
    self.zhekouLabel.text = [NSString stringWithFormat:@"[%@]",brandBreviaryList.zhekou];
    self.arrList = brandBreviaryList.list;
    for (BaseDataModel *model in self.arrList) {
        model.classifyName = @"包邮";
    }
    
    
    [self.collectionView reloadData];}


- (IBAction)moreProduct:(id)sender {
    [self.delegate brandHomeCell:self moreProductFromBrandID:self.brandBreviaryList.ID BrandName:self.brandBreviaryList.brand_name];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arrList.count - 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID   forIndexPath:indexPath];
    cell.model = self.arrList[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BaseDataModel *model = self.arrList[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(brandHomeCell:didSelectItem:)]) {
        [self.delegate brandHomeCell:self didSelectItem:model];
    }
}



#pragma mark - lazy
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];

        layout.minimumInteritemSpacing = 5;
        layout.itemSize = CGSizeMake((kScreen_Width - 5 - 10)/2.0, (kScreen_Width - 15)/2.0+50);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = RGBA(242, 242, 242, 1);
        [_collectionView registerNib:[UINib nibWithNibName:@"HomeCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    }
    return _collectionView;
}

- (NSMutableArray *)arrList
{
    if (!_arrList) {
        _arrList = [NSMutableArray array];
    }
    return _arrList;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.collectionView.x = 0;
    self.collectionView.y = 30;
    self.collectionView.width = self.width;
    self.collectionView.height = self.height + 30;
    
}

@end
