//
//  UIFont+Extension.h
//  WSLibrary
//
//  Created by iMac-Chao on 14-8-21.
//  Copyright (c) 2014年 西软软件股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Extension)

#pragma mark ------------------------------
+ (void)showAllSystemFonts;



#pragma mark ------------------------------
+ (UIFont *)getCommonFontWithSize:(float )size;



#pragma mark ------------------------------
+ (CGFloat)lineHeight:(UIFont *)font;
@end
