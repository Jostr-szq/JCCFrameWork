//
//  BKNavigationController.h
//  JccLibrary
//
//  Created by Jostr on 15/1/8.
//  Copyright (c) 2015年 CHAOFENGJIA. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BKNavigationController;

@protocol BKNavigationControllerDelegate <NSObject>

@optional
- (BOOL)BKNavigationControllerShouldBeginMoveNav:(BKNavigationController *)navigationController;
- (void)BKNavigationWillBePopedOut;
@end

@interface BKNavigationController : UINavigationController <UIGestureRecognizerDelegate>
- (void)stopTheMoveGesture;
- (void)startTheMoveGesture;
@property (weak , nonatomic) id<BKNavigationControllerDelegate> bkNavDelegate;
@end
