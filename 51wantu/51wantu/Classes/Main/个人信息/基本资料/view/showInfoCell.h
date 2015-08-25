//
//  showInfoCell.h
//  自定义cell
//
//  Created by kevin on 15/8/25.
//  Copyright (c) 2015年 ohbuy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface showInfoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;

+ (showInfoCell *)getshowInfoCell;

@end
