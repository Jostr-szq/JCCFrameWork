//
//  UIImage+Extension.h
//  WSLibrary
//
//  Created by iMac-Chao on 14-8-21.
//  Copyright (c) 2014年 西软软件股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
#pragma mark ------------------------------
- (UIImage *)captureFullScreen;
- (UIImage *)captureSubImageAtRect:(CGRect)rect;
- (UIImage *)getImageFromView:(UIView *)orgView;



#pragma mark ------------------------------
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;


#pragma mark ------------------------------
- (UIImage *)imageScaledToSize:(CGSize)size;


//图片拉伸、平铺接口
- (UIImage *)resizableImageWithCompatibleCapInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode;
//图片以ScaleToFit方式拉伸后的CGSize
- (CGSize)sizeOfScaleToFit:(CGSize)scaledSize;

//将图片转向调整为向上
- (UIImage *)fixOrientation;

//以ScaleToFit方式压缩图片
- (UIImage *)compressedImageWithSize:(CGSize)compressedSize;


@end
