//
//  HomeFloatView.h
//  51wantu
//
//  Created by elaine on 15/9/5.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HomeFloatViewStyle) {
    HomeFloatViewStyleUser,
    HomeFloatViewStyleFavourite,
    HomeFloatViewStyleCollection
};

@class HomeFloatView;

@protocol HomeFloatViewDelegate <NSObject>

- (void)homeFloatView:(HomeFloatView *)homeFloatView didClickBtnWithType:(HomeFloatViewStyle)type;

@end

@interface HomeFloatView : UIView
@property (nonatomic, weak) id<HomeFloatViewDelegate> delegate;

@end
