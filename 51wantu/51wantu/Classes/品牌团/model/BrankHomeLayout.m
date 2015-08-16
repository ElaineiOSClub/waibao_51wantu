//
//  BrankHomeLayout.m
//  51wantu
//
//  Created by elaine on 15/8/16.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "BrankHomeLayout.h"

@implementation BrankHomeLayout

- (void)prepareLayout
{

    self.itemSize = CGSizeMake(kScreen_Width - 5*2, (kScreen_Width - 15)/2.0+50 + 30);
    self.sectionInset = UIEdgeInsetsMake(5, 5, 0, 5);

}

@end
