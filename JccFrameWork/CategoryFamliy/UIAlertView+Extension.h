//
//  UIAlertView+Extension.h
//  WSLibrary
//
//  Created by iMac-Chao on 14-8-21.
//  Copyright (c) 2014年 西软软件股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Extension)<UIAlertViewDelegate>

#pragma mark ------------------------------
typedef void (^VoidBlock)();
typedef void (^DismissBlock)(NSInteger buttonIndex);
typedef void (^CancelBlock)();
typedef void (^PhotoPickedBlock)(UIImage *chosenImage);

@property (nonatomic, copy) DismissBlock dismissBlock;
@property (nonatomic, copy) CancelBlock cancelBlock;

#pragma mark ------------------------------
+ (UIAlertView*) alertViewWithTitle:(NSString*) title
                            message:(NSString*) message;

+ (UIAlertView*) alertViewWithTitle:(NSString*) title
                            message:(NSString*) message
                  cancelButtonTitle:(NSString*) cancelButtonTitle;

#pragma mark ------------------------------
+ (UIAlertView*) alertViewWithTitle:(NSString*) title
                            message:(NSString*) message
                  cancelButtonTitle:(NSString*) cancelButtonTitle
                  otherButtonTitles:(NSArray*) otherButtons
                          onDismiss:(DismissBlock) dismissed
                           onCancel:(CancelBlock) cancelled;


@end
