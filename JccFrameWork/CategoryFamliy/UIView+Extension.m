//
//  UIView+Extension.m
//  WSLibrary
//
//  Created by iMac-Chao on 14-8-21.
//  Copyright (c) 2014年 西软软件股份有限公司. All rights reserved.
//

#import "UIView+Extension.h"
#import <objc/runtime.h>
#import "AppMacro.h"

#define BIG_IMG_WIDTH  200.0
#define BIG_IMG_HEIGHT 200.0


static char kDTActionHandlerTapBlockKey;
static char kDTActionHandlerTapGestureKey;
static char kDTActionHandlerLongPressBlockKey;
static char kDTActionHandlerLongPressGestureKey;

@implementation UIView (Extension)

#pragma mark ----------origin----------
- (CGPoint)origin{
    return self.frame.origin;
}
- (CGFloat)x{
    return self.frame.origin.x;
}
- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setOrigin:(CGPoint) origin{
    self.frame = CGRectMake(origin.x, origin.y, self.frame.size.width, self.frame.size.height);
}
- (void)setX:(CGFloat)x{
    self.frame = CGRectMake(x, self.y, self.frame.size.width, self.frame.size.height);
}
- (void)setY:(CGFloat)y{
    self.frame = CGRectMake(self.x, y, self.frame.size.width, self.frame.size.height);
}



#pragma mark ----------size----------
- (CGSize)size{
    return self.frame.size;
}
- (CGFloat)width{
    return self.frame.size.width;
}
- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setSize:(CGSize) size{
    self.frame = CGRectMake(self.x, self.y, size.width, size.height);
}
- (void)setWidth:(CGFloat)width{
    self.frame = CGRectMake(self.x, self.y, width, self.height);
}
- (void)setHeight:(CGFloat)height{
    self.frame = CGRectMake(self.x, self.y, self.width, height);
}



#pragma mark ----------margin----------
- (CGFloat)top {
    return self.y;
}
- (CGFloat)bottom {
    return self.top +self.height;
}
- (CGFloat)left {
    return self.x;
}
- (CGFloat)right {
    return self.left + self.width;
}

- (void)setTop:(CGFloat)top {
    [self setY:top];
}
- (void)setBottom:(CGFloat)bottom {
    self.frame = CGRectMake(self.x, bottom - self.height, self.width, self.height);
}
- (void)setLeft:(CGFloat)left {
    [self setX:left];
}
- (void)setRight:(CGFloat)right {
    self.frame = CGRectMake(right - self.width, self.y, self.width, self.height);
}



#pragma mark ----------ClassCheck----------
- (UIView*)descendantOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls])
        return self;
    
    for (UIView* child in self.subviews) {
        UIView* it = [child descendantOrSelfWithClass:cls];
        if (it)
            return it;
    }
    
    return nil;
}
- (UIView*)ancestorOrSelfWithClass:(Class)cls {
    if ([self isKindOfClass:cls]) {
        return self;
        
    } else if (self.superview) {
        return [self.superview ancestorOrSelfWithClass:cls];
        
    } else {
        return nil;
    }
}




#pragma mark ----------AddGestureQuickly----------
- (void)setTapActionWithBlock:(void (^)(void))block{
	UITapGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerTapGestureKey);
    
	if (!gesture)
	{
		gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForTapGesture:)];
		[self addGestureRecognizer:gesture];
		objc_setAssociatedObject(self, &kDTActionHandlerTapGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
	}
    
	objc_setAssociatedObject(self, &kDTActionHandlerTapBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)__handleActionForTapGesture:(UITapGestureRecognizer *)gesture{
	if (gesture.state == UIGestureRecognizerStateRecognized)
	{
		void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerTapBlockKey);
        
		if (action)
		{
			action();
		}
	}
}

- (void)setLongPressActionWithBlock:(void (^)(void))block{
	UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, &kDTActionHandlerLongPressGestureKey);
    
	if (!gesture)
	{
		gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(__handleActionForLongPressGesture:)];
		[self addGestureRecognizer:gesture];
		objc_setAssociatedObject(self, &kDTActionHandlerLongPressGestureKey, gesture, OBJC_ASSOCIATION_RETAIN);
	}
    
	objc_setAssociatedObject(self, &kDTActionHandlerLongPressBlockKey, block, OBJC_ASSOCIATION_COPY);
}
- (void)__handleActionForLongPressGesture:(UITapGestureRecognizer *)gesture{
	if (gesture.state == UIGestureRecognizerStateBegan)
	{
		void(^action)(void) = objc_getAssociatedObject(self, &kDTActionHandlerLongPressBlockKey);
        
		if (action)
		{
			action();
		}
	}
}



#pragma mark ----------ClearSubviews----------
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}




#pragma mark ----------Animation----------
CGFloat degreesToRadians(CGFloat degrees)
{
    return degrees * M_PI / 180;
}



-(void)setX:(CGFloat)x duration:(NSTimeInterval)time finished:(AnimationFinished)finished{
    
    [UIView animateWithDuration:time animations:^{
        CGRect frame = self.frame;
        frame.origin.x = x;
        self.frame = frame;
    } completion:^(BOOL f){
        if(finished)
            finished();
    }];
    
}
-(void)moveX:(CGFloat)x duration:(NSTimeInterval)time finished:(AnimationFinished)finished{
    [self setX:(self.frame.origin.x+x) duration:time finished:finished];
}
-(void)setY:(CGFloat)y duration:(NSTimeInterval)time finished:(AnimationFinished)finished{
    [UIView animateWithDuration:time animations:^{
        CGRect frame = self.frame;
        frame.origin.y = y;
        self.frame = frame;
    }completion:^(BOOL f){
        if(finished)
            finished();
    }];
}
-(void)moveY:(CGFloat)y duration:(NSTimeInterval)time finished:(AnimationFinished)finished{
    [self setY:(self.frame.origin.y+y) duration:time finished:finished];
}



-(void)setRotation:(CGFloat)r duration:(NSTimeInterval)time finished:(AnimationFinished)finished{
    
    [UIView animateWithDuration:time animations:^{
        CGAffineTransform rotationTransform = CGAffineTransformIdentity;
        self.transform = CGAffineTransformRotate(rotationTransform, degreesToRadians(r));
    } completion:^(BOOL f){
        if(finished)
            finished();
    }];
}
-(void)moveRotation:(CGFloat)r duration:(NSTimeInterval)time finished:(AnimationFinished)finished{
    [UIView animateWithDuration:time animations:^{
        CGAffineTransform rotationTransform = self.transform;
        self.transform = CGAffineTransformRotate(rotationTransform, degreesToRadians(r));
    } completion:^(BOOL f){
        if(finished)
            finished();
    }];
}



-(void)pulse:(AnimationFinished)finished{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL f){
        [UIView animateWithDuration:0.5 delay:0.1 options:0 animations:^{
            self.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL f){
            if(finished)
                finished();
        }];
    }];
}
-(void)shake:(AnimationFinished)finished{
    
    float dist = 10;
    [self moveX:-dist duration:0.15 finished:^{
        [self moveX:dist*2 duration:0.15 finished:^{
            [self moveX:-(dist*2) duration:0.15 finished:^{
                [self moveX:dist duration:0.15 finished:^{
                    if(finished)
                        finished();
                }];
            }];
        }];
    }];
}
-(void)swing:(AnimationFinished)finished{
    
    float dist = 15;
    float dur = 0.20;
    __weak id weakSelf = self;
    [weakSelf setRotation:dist duration:dur finished:^{
        [weakSelf setRotation:-dist duration:dur finished:^{
            [weakSelf setRotation:dist/2 duration:dur finished:^{
                [weakSelf setRotation:-dist/2 duration:dur finished:^{
                    [weakSelf setRotation:0 duration:dur finished:^{
                        if(finished)
                            finished();
                    }];
                }];
            }];
        }];
    }];
}
-(void)tada:(AnimationFinished)finished{
    
    float dist = 3;
    float dur = 0.12;
    [UIView animateWithDuration:dur animations:^{
        CGAffineTransform rotationTransform = CGAffineTransformMakeScale(0.95, 0.95);
        rotationTransform = CGAffineTransformRotate(rotationTransform, degreesToRadians(dist));
        self.transform = rotationTransform;
    } completion:^(BOOL f){
        [UIView animateWithDuration:dur animations:^{
            CGAffineTransform rotationTransform = CGAffineTransformMakeScale(1.05, 1.05);
            rotationTransform = CGAffineTransformRotate(rotationTransform, degreesToRadians(-dist));
            self.transform = rotationTransform;
        } completion:^(BOOL f){
            
            __weak id weakSelf = self;
            [weakSelf moveRotation:dist*2 duration:dur finished:^{
                [weakSelf moveRotation:-dist*2 duration:dur finished:^{
                    [weakSelf moveRotation:dist*2 duration:dur finished:^{
                        [weakSelf moveRotation:-dist*2 duration:dur finished:^{
                            [UIView animateWithDuration:dur animations:^{
                                CGAffineTransform rotationTransform = CGAffineTransformMakeScale(1, 1);
                                rotationTransform = CGAffineTransformRotate(rotationTransform, degreesToRadians(0));
                                self.transform = rotationTransform;
                            } completion:^(BOOL f){
                                if(finished)
                                    finished();
                            }];
                        }];
                    }];
                }];
            }];
            
        }];
    }];
}

//#pragma mark --------------------------------------------
//-(void)loadImgViewAnimation:(UIImage *)img
//{
//    //    CMBCAppDelegate *appDelegate = APPLICATIONDELEGATE;
//    
//    //创建灰色透明背景，使其背后内容不可操作
//    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, UIScreenWidth, UIScreenHeight-64)];
//    bgView.tag = 101;
//    [bgView setBackgroundColor:[UIColor colorWithRed:0.3
//                                               green:0.3
//                                                blue:0.3
//                                               alpha:0.7]];
//    [APPLICATIONDELEGATE.window addSubview:bgView];
//    //点击手势
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(suoxiao)];
//    //    tap.delegate = self;
//    [bgView addGestureRecognizer:tap];
//    //创建边框视图
//    UIView *borderView = [[UIView alloc] initWithFrame:CGRectMake(0,0,BIG_IMG_WIDTH+16, BIG_IMG_HEIGHT+16)];
//    //将图层的边框设置为圆脚
//    borderView.layer.cornerRadius = 8;
//    borderView.layer.masksToBounds = YES;
//    //给图层添加一个有色边框
//    borderView.layer.borderWidth = 8;
//    borderView.layer.borderColor = [[UIColor colorWithRed:0.9
//                                                    green:0.9
//                                                     blue:0.9
//                                                    alpha:0.7]CGColor];
//    [bgView addSubview:borderView];
//    [borderView setCenter:APPLICATIONDELEGATE.window.center];
//    [borderView setY:100];
//    //创建关闭按钮
//    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [closeBtn setImage:[UIImage imageNamed:@"remove.png"] forState:UIControlStateNormal];
//    [closeBtn addTarget:self action:@selector(suoxiao) forControlEvents:UIControlEventTouchUpInside];
//    NSLog(@"borderview is %@",borderView);
//    [closeBtn setFrame:CGRectMake(borderView.frame.origin.x+borderView.frame.size.width-20, borderView.frame.origin.y-6, 26, 27)];
//    [bgView addSubview:closeBtn];
//    //创建显示图像视图
//    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, BIG_IMG_WIDTH, BIG_IMG_HEIGHT)];
//    [imgView setImage:img];
//    [borderView addSubview:imgView];
//    [APPLICATIONDELEGATE.window shakeToShow:borderView];//放大过程中的动画
//}
//
//-(void)suoxiao
//{
//    //    CMBCAppDelegate *appDelegate = APPLICATIONDELEGATE;
//    UIView *view = [APPLICATIONDELEGATE.window viewWithTag:101];
//    [view removeFromSuperview];
//}
//*************放大过程中出现的缓慢动画*************
- (void) shakeToShow:(UIView*)aView{
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    //    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    //    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9, 0.9, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [aView.layer addAnimation:animation forKey:nil];
}


-(void)setViewEdge
{
    CALayer *layeryx = [self layer];
    layeryx.borderColor = [[UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0] CGColor];
    layeryx.borderWidth = 1.0f;
}

-(void)setViewRounded:(CGFloat)cornerRadius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}


/*截图*/
- (UIImage *)screenshot
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 2.0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - Animation

- (void)startShakeAnimation
{
    CGFloat rotation = 0.05;
    
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
    shake.duration = 0.2;
    shake.autoreverses = YES;
    shake.repeatCount = MAXFLOAT;
    shake.removedOnCompletion = NO;
    shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, -rotation, 0.0, 0.0, 1.0)];
    shake.toValue   = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform,  rotation, 0.0, 0.0, 1.0)];
    
    [self.layer addAnimation:shake forKey:@"shakeAnimation"];
}

- (void)stopShakeAnimation
{
    [self.layer removeAnimationForKey:@"shakeAnimation"];
}

- (void)startRotateAnimation
{
    CABasicAnimation *shake = [CABasicAnimation animationWithKeyPath:@"transform"];
    shake.duration = 0.5;
    shake.autoreverses = NO;
    shake.repeatCount = MAXFLOAT;
    shake.removedOnCompletion = NO;
    shake.fromValue = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform, M_PI, 0.0, 0.0, 1.0)];
    shake.toValue   = [NSValue valueWithCATransform3D:CATransform3DRotate(self.layer.transform,  0.0, 0.0, 0.0, 1.0)];
    
    [self.layer addAnimation:shake forKey:@"rotateAnimation"];
}

- (void)stopRotateAnimation
{
    [self.layer removeAnimationForKey:@"rotateAnimation"];
}

@end
