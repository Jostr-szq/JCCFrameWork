//
//  UIColor+Extension.m
//  WSLibrary
//
//  Created by iMac-Chao on 14-8-21.
//  Copyright (c) 2014年 西软软件股份有限公司. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

#pragma mark ----------随机色(测试)----------
+ (UIColor *)randomColor{
    
//    static BOOL seeded = NO;
//    if (!seeded) {
//        seeded = YES;
//        srandom(time(NULL));
//    }
    CGFloat red =  (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

#pragma mark ----------十六进制色----------
+ (UIColor *)colorWithHex:(NSString *)hexColor{
    
    NSRange range;
	range.location = 0;
	range.length = 2;
	NSString *rString = [hexColor substringWithRange:range];
	range.location = 2;
	NSString *gString = [hexColor substringWithRange:range];
	range.location = 4;
	NSString *bString = [hexColor substringWithRange:range];
	
	unsigned int r, g, b;
	[[NSScanner scannerWithString:rString] scanHexInt:&r];
	[[NSScanner scannerWithString:gString] scanHexInt:&g];
	[[NSScanner scannerWithString:bString] scanHexInt:&b];
	
	return [UIColor colorWithRed:((float) r / 255.0f)
						   green:((float) g / 255.0f)
							blue:((float) b / 255.0f)
						   alpha:1.0f];
}

#pragma mark ----------RGB相等色----------
+ (UIColor *)colorWith:(CGFloat)pmColor{
    
    UIColor *color = [UIColor colorWithRed:pmColor/255.0 green:pmColor/255.0 blue:pmColor/255.0 alpha:1.0];
    return color;
}

#pragma mark ----------RGB不等色----------
+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue{
    
    UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
    return color;
}


+ (UIColor *)navBarColor
{
   return  [UIColor colorWithRed:0 green:197 blue:184];
}

+ (UIColor *)btnColor
{
    return [UIColor colorWithRed:151 green:203 blue:236];
}
@end
