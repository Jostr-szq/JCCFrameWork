//
//  CALayer+Extension.m
//  CMBCIntelligenceHouse
//
//  Created by Jostr on 14/10/30.
//  Copyright (c) 2014年 CMBC. All rights reserved.
//

#import "CALayer+Extension.h"
#import "AppMacro.h"

@implementation CALayer (Extension)


-(void)loadBuyAnimation:(UIImageView *)imgView andDelegate:(id)object{
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    self.opacity = 1.0;
    self.contents = imgView.layer.contents;
    self.frame = [[UIApplication sharedApplication].keyWindow convertRect:imgView.bounds fromView:imgView];
    [[UIApplication sharedApplication].keyWindow.layer addSublayer:self];
    [CATransaction commit];
    
    //路径曲线
    UIBezierPath *movePath = [UIBezierPath bezierPath];
    [movePath moveToPoint:self.position];
    CGPoint toPoint = CGPointMake(26, UIScreenHeight+10);
    [movePath addQuadCurveToPoint:toPoint
                     controlPoint:CGPointMake(26,self.position.y-120)];
    //关键帧
    CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    positionAnimation.path = movePath.CGPath;
    positionAnimation.removedOnCompletion = YES;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.beginTime = CACurrentMediaTime();
    group.duration = 0.7;
    group.animations = [NSArray arrayWithObjects:positionAnimation,nil];
    group.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    group.delegate = self;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    group.autoreverses= NO;
    [self addAnimation:group forKey:@"opacity"];
}

@end
