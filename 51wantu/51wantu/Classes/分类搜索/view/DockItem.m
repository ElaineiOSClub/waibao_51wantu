//
//  DockItem.m
//  weibo
//
//  Created by elaine on 14-7-24.
//  Copyright (c) 2014年 elaine. All rights reserved.
//

#import "DockItem.h"
// 文字的高度比例
#define kTitleRatio 0.3
@implementation DockItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //1.文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        //2.文字大小
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        //3.图片的内容模式
        self.imageView.contentMode = UIViewContentModeCenter;
        
//        //4.选中时候的背景
//        [self setBackgroundImage:[UIImage imageNamed:@"tabbar_slider.png"] forState:UIControlStateSelected];
    }
    return self;
}

#pragma mark 覆盖父类在highlighted时所有的操作
- (void)setHighlighted:(BOOL)highlighted
{
    
}

#pragma mark 调整内部ImageView的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageWidth = contentRect.size.width;
    CGFloat imageHeight = contentRect.size.height * (1-kTitleRatio);
    return CGRectMake(imageX, imageY, imageWidth, imageHeight);
}

#pragma mark 调整内部UILabel的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleHeight = contentRect.size.height * kTitleRatio;
    CGFloat titleY = contentRect.size.height - titleHeight - 6;
    CGFloat titleWidth = contentRect.size.width;
    return CGRectMake(titleX,titleY, titleWidth, titleHeight);
}
@end
