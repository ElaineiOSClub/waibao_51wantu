//
//  ClassifySearchViewController.h
//  51wantu
//
//  Created by elaine on 15/8/8.
//  Copyright (c) 2015年 elaine. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ClassifySearchViewControllerDelegate <NSObject>

- (void)endEditing;

@end

@interface ClassifySearchViewController : UIViewController
@property (nonatomic, copy) NSString *text;
@property (nonatomic, weak) id<ClassifySearchViewControllerDelegate> delegate;
@end
