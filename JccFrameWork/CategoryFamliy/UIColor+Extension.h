//
//  UIColor+Extension.h
//  WSLibrary
//
//  Created by iMac-Chao on 14-8-21.
//  Copyright (c) 2014年 西软软件股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

#pragma mark ------------------------------
/**
 *  随机色
 *
 *  @return UIColor
 */
+ (UIColor *)randomColor;



#pragma mark ------------------------------
/**
 *  十六进制颜色
 *
 *  @param hexColor 十六进制字符串
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithHex:(NSString *)hexColor;



#pragma mark ------------------------------
/**
 *  RGB相等色-三色色值一致,去除255
 *
 *  @param pmColor 颜色参数
 *
 *  @return UIColor
 */
+ (UIColor *)colorWith:(CGFloat)pmColor;


/**
 *  RGB不等色-去除255
 *
 *  @param red   红色
 *  @param green 绿色
 *  @param blue  蓝色
 *
 *  @return UIColor
 */
+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue;

+ (UIColor *)navBarColor;
+ (UIColor *)btnColor;
@end
