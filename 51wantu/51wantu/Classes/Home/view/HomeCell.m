//
//  HomeCell.m
//  51wantu
//
//  Created by elaine on 15/8/10.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "HomeCell.h"
#import "BaseDataModel.h"
#import "UIImageView+WebCache.h"

@interface HomeCell()

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productImageHieght;

@property (weak, nonatomic) IBOutlet UIImageView *imagenew;

@property (nonatomic, strong) UIView *tempView;

@end

@implementation HomeCell

- (void)awakeFromNib {
    [self.originalPriceLabel addSubview:self.tempView];
}

- (void)setModel:(BaseDataModel *)model
{
    _model = model;
    
    NSRange range = [model.pic_url rangeOfString:@"http"];
    
    if (range.length == 0) {
        model.pic_url = [NSString stringWithFormat:@"http:%@",model.pic_url];
    }
    NSURL *imageUrl = [NSURL URLWithString:model.pic_url];
    [self.productImageView sd_setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"占458"]];
//    self.classifyLabel.text = [NSString stringWithFormat:@"【%@】",model.classifyName];
    self.nameLabel.text = model.title;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",model.tuan_price] ;
     self.originalPriceLabel.text = [NSString stringWithFormat:@"¥%@",model.price];
    self.discountLabel.text = [NSString stringWithFormat:@"(%@折)",model.discount];

    self.imagenew.hidden = !model.isnew;
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.productImageHieght.constant = self.width;
    self.tempView.centerY = self.originalPriceLabel.height/2;
    self.tempView.width = self.originalPriceLabel.width;
    
}

- (UIView *)tempView
{
    if (!_tempView) {
        _tempView = [[UIView alloc] init];
        _tempView.backgroundColor = RGBA(153, 153, 153, 1);
        _tempView.height = 1;
    }
    return _tempView;
}

@end
