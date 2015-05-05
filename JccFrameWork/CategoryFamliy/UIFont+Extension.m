//
//  UIFont+Extension.m
//  WSLibrary
//
//  Created by iMac-Chao on 14-8-21.
//  Copyright (c) 2014年 西软软件股份有限公司. All rights reserved.
//

#import "UIFont+Extension.h"

@implementation UIFont (Extension)

#pragma mark ----------AllFonts----------
+ (void)showAllSystemFonts{
    
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
    {
        NSLog(@"ICFont Index:%ld   Family name: %@",(long)indFamily, [familyNames objectAtIndex:indFamily]);
        fontNames = [[NSArray alloc] initWithArray:
                     [UIFont fontNamesForFamilyName:
                      [familyNames objectAtIndex:indFamily]]];
        for (indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NSLog(@" Font name: %@", [fontNames objectAtIndex:indFont]);
        }
    }
}



#pragma mark ----------Common----------
+ (UIFont *)getCommonFontWithSize:(float )size{
    return [UIFont fontWithName:@"KaiTi_GB2312" size:size];
}



#pragma mark ----------FontHeight----------
+ (CGFloat)lineHeight:(UIFont *)font{
    return (font.ascender - font.descender) + 1;
}
@end
