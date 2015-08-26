//
//  leftTableViewCell.h
//  51wantu
//
//  Created by kevin on 15/8/11.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface leftTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *categoryName;
@property (weak, nonatomic) IBOutlet UIImageView *categoryImageView;

+ (leftTableViewCell *)getleftTableViewCell;
@end
