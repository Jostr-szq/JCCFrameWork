//
//  BKSysNavBaseViewController.h
//  JccLibrary
//
//  Created by Jostr on 15/1/8.
//  Copyright (c) 2015年 CHAOFENGJIA. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BKSysNavBaseViewController : UIViewController

@property (strong, nonatomic) UIColor *barButtonItemColor;
@property (nonatomic, readonly) CGFloat contentHeight;
@property (nonatomic, readonly) CGFloat contentWidth;

+ (UINavigationController *)createNavViewController;
/*
 设置导航TitleView
 */
- (void)setTitleView:(UIView *)view;
/*
 左右Button快捷设置函数
 */
- (void)setLeftBarItemWithTitle:(NSString *)leftBarItemTitle;
- (void)setRightBarItemWithTitle:(NSString *)rightBarItemTitle;
- (void)setLeftBarItemWithTitle:(NSString *)leftBarItemTitle Color:(UIColor *)color;
- (void)setRightBarItemWithTitle:(NSString *)rightBarItemTitle Color:(UIColor *)color;

- (void)setLeftBarItemTitleColor:(UIColor *)color;
- (void)setRightBarItemWithTitleColor:(UIColor *)color;

- (void)setLeftBarItemWithImage:(UIImage *)image;
- (void)setRightBarItemWithImage:(UIImage *)image;

- (void)setLeftBarItemWithView:(UIView *)view;
- (void)setRightBarItemWithView:(UIView *)view;
- (UIBarButtonItem *)leftBarItem;
- (UIBarButtonItem *)rightBarItem;

- (void)didClickLeftBtnEvent:(id)sender;
- (void)didClickRightBtnEvent:(id)sender;

@end
