//
//  AdvanceNoticeCell.m
//  51wantu
//
//  Created by elaine on 15/8/11.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "AdvanceNoticeCell.h"
#import "BaseDataModel.h"
#import "UIImageView+WebCache.h"

@interface AdvanceNoticeCell()
@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *originalPriceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *productImageHeight;
@property (nonatomic, strong) UIView *tempView;

@property (weak, nonatomic) IBOutlet UIImageView *imagenew;
@property (weak, nonatomic) IBOutlet UILabel *time;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation AdvanceNoticeCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor whiteColor];
    [self.originalPriceLabel addSubview:self.tempView];
    self.time.layer.cornerRadius = 10;
    self.time.clipsToBounds = NO;

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
    self.originalPriceLabel.text = [NSString stringWithFormat:@"¥%@",model.price] ;
//    self.discountLabel.text = [NSString stringWithFormat:@"(%@折)",model.discount];
     self.imagenew.hidden = !model.isnew;
    self.dateLabel.text = [NSString stringWithFormat:@"%@点开抢",model.pdate2];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.productImageHeight.constant = self.width;
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
