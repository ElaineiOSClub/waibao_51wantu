//
//  leftTableViewCell.m
//  51wantu
//
//  Created by kevin on 15/8/11.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "leftTableViewCell.h"

@implementation leftTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor = [UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (leftTableViewCell *)getleftTableViewCell
{
    return [[[NSBundle mainBundle] loadNibNamed:@"leftTableViewCell" owner:nil options:nil] lastObject];
}
@end
