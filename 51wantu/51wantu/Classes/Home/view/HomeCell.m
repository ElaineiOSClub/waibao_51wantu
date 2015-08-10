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
@property (weak, nonatomic) IBOutlet UILabel *classifyLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *discountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productImageHieght;

@end

@implementation HomeCell

- (void)awakeFromNib {
    
}

- (void)setModel:(BaseDataModel *)model
{
    _model = model;
    NSURL *imageUrl = [NSURL URLWithString:model.pic_url];
    [self.productImageView sd_setImageWithURL:imageUrl];
    self.classifyLabel.text = [NSString stringWithFormat:@"【%@】",model.cid];
    self.nameLabel.text = model.title;
    self.priceLabel.text = model.tuan_price;
    self.originalPriceLabel.text = model.price;
    self.discountLabel.text = [NSString stringWithFormat:@"(%@折)",model.discount];

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.productImageHieght.constant = self.width;
}

@end
