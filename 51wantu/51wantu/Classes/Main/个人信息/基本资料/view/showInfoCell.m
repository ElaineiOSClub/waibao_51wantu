//
//  showInfoCell.m
//  自定义cell
//
//  Created by kevin on 15/8/25.
//  Copyright (c) 2015年 ohbuy. All rights reserved.
//

#import "showInfoCell.h"

@implementation showInfoCell

- (void)awakeFromNib {
    // Initialization code
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.headImage.layer.cornerRadius = 30;
    self.headImage.clipsToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (showInfoCell *)getshowInfoCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"showInfoCell" owner:nil options:nil] lastObject];
}


@end
