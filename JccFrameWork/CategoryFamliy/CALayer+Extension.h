//
//  CALayer+Extension.h
//  CMBCIntelligenceHouse
//
//  Created by Jostr on 14/10/30.
//  Copyright (c) 2014年 CMBC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface CALayer (Extension)

/**
 *  购物车动画
 *
 *  @param imgView 当前动画图片
 *  @param object  当前类
 */
-(void)loadBuyAnimation:(UIImageView *)imgView andDelegate:(id)object;

@end
