//
//  leftMainBtn.m
//  51wantu
//
//  Created by kevin on 15/8/11.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import "leftMainBtn.h"

// 文字的高度比例
#define kTitleRatio 0.3

@implementation leftMainBtn


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 2.文字大小
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        // 3.图片的内容模式
        self.imageView.contentMode = UIViewContentModeCenter;
        
    }
    return self;
}
-(void)awakeFromNib
{
    // 1.文字居中
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    // 2.文字大小
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    // 3.图片的内容模式
    self.imageView.contentMode = UIViewContentModeCenter;

}

#pragma mark 调整内部ImageView的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageWidth = contentRect.size.width;
    CGFloat imageHeight = contentRect.size.height * ( 1- kTitleRatio );
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

#pragma mark 调整内部UILabel的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleHeight = contentRect.size.height * kTitleRatio;
    CGFloat titleY = contentRect.size.height - titleHeight - 3;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX, titleY, titleWidth, titleHeight);
}


@end
