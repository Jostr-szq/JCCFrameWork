//
//  UIView+Extension.h
//  WSLibrary
//
//  Created by iMac-Chao on 14-8-21.
//  Copyright (c) 2014年 西软软件股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

typedef void (^AnimationFinished)(void);

#pragma mark -------------------------
/**
 *  获取视图的起始点
 *
 *  @return 左上角的点
 */
- (CGPoint)origin;

/**
 *  获取视图的x坐标点
 *
 *  @return StartX
 */
- (CGFloat)x;

/**
 *  获取视图的y坐标点
 *
 *  @return StartY
 */
- (CGFloat)y;

/**
 *  设置视图的起始坐标点
 *
 *  @param origin 要设置的起始点
 */
- (void)setOrigin:(CGPoint) origin;

/**
 *  设置视图的x坐标点
 *
 *  @param x 要设置的x坐标点
 */
- (void)setX:(CGFloat)x;

/**
 *  设置视图的y坐标点
 *
 *  @param y 要设置的y坐标点
 */
- (void)setY:(CGFloat)y;



#pragma mark -------------------------
- (CGSize)size;
- (CGFloat)width;
- (CGFloat)height;
- (void)setSize:(CGSize) size;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;


#pragma mark -------------------------
- (CGFloat)top;
- (CGFloat)bottom;
- (CGFloat)left;
- (CGFloat)right;
- (void)setTop:(CGFloat)top;
- (void)setBottom:(CGFloat)bottom;
- (void)setLeft:(CGFloat)left;
- (void)setRight:(CGFloat)right;



#pragma mark ------------------------------
- (UIView*)descendantOrSelfWithClass:(Class)cls;
- (UIView*)ancestorOrSelfWithClass:(Class)cls;



#pragma mark ------------------------------
- (void)setTapActionWithBlock:(void (^)(void))block;
- (void)setLongPressActionWithBlock:(void (^)(void))block;



#pragma mark ------------------------------
- (void)removeAllSubviews;




#pragma mark ------------------------------
-(void)setX:(CGFloat)x duration:(NSTimeInterval)time finished:(AnimationFinished)finished;
-(void)moveX:(CGFloat)x duration:(NSTimeInterval)time finished:(AnimationFinished)finished;
-(void)setY:(CGFloat)y duration:(NSTimeInterval)time finished:(AnimationFinished)finished;
-(void)moveY:(CGFloat)y duration:(NSTimeInterval)time finished:(AnimationFinished)finished;




#pragma mark ------------------------------
-(void)setRotation:(CGFloat)r duration:(NSTimeInterval)time finished:(AnimationFinished)finished;
-(void)moveRotation:(CGFloat)r duration:(NSTimeInterval)time finished:(AnimationFinished)finished;



#pragma mark ------------------------------
-(void)pulse:(AnimationFinished)finished;
-(void)shake:(AnimationFinished)finished;
-(void)swing:(AnimationFinished)finished;
-(void)tada:(AnimationFinished)finished;


#pragma mark --------------------------------------------
/**
 *  显示二维码图片
 */
//-(void)loadImgViewAnimation:(UIImage *)img;

#pragma mark --------------------------------------------
/**
 *  设置半透明边框
 */
-(void)setViewEdge;


/**
 *  设置圆角
 */

-(void)setViewRounded:(CGFloat)cornerRadius;

/**
 *  截图
 */

- (UIImage *)screenshot;

- (void)startShakeAnimation;//摇动动画
- (void)stopShakeAnimation;
- (void)startRotateAnimation;//360°旋转动画
- (void)stopRotateAnimation;


@end
