//
//  UIViewController+Extension.m
//  WSLibrary
//
//  Created by iMac-Chao on 14-8-21.
//  Copyright (c) 2014年 西软软件股份有限公司. All rights reserved.
//

#import "UIViewController+Extension.h"
#import "AppMacro.h"

@implementation UIViewController (Extension)

- (void)ViewMoveUpWith:(CGFloat)height
{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = CGRectMake(0, -height, UIScreenWidth,UIScreenHeight);
    }];
    
}
- (void)ViewMoveDown
{
    [UIView animateWithDuration:0.25 animations:^{
        self.view.frame = CGRectMake(0, 0 , UIScreenWidth, UIScreenHeight);
    }];
}
@end
