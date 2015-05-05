//
//  UIImage+Extension.m
//  WSLibrary
//
//  Created by iMac-Chao on 14-8-21.
//  Copyright (c) 2014年 西软软件股份有限公司. All rights reserved.
//

#import "UIImage+Extension.h"
#import <QuartzCore/QuartzCore.h>
@implementation UIImage (Extension)

CGFloat TTIDegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat TTIRadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};


#pragma mark ----------Capture----------
- (UIImage *)captureFullScreen{
    //截屏功能
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

- (UIImage *)captureSubImageAtRect:(CGRect)rect{
    
    CGImageRef subImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
	CGRect smallBounds = CGRectMake(0, 0, CGImageGetWidth(subImageRef),
                                    CGImageGetHeight(subImageRef));
	
    UIGraphicsBeginImageContext(smallBounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, smallBounds, subImageRef);
    
    UIImage* smallImage = [UIImage imageWithCGImage:subImageRef scale:1.0f
                                        orientation:self.imageOrientation];
    
    UIGraphicsEndImageContext();
	CFRelease(subImageRef);
    return smallImage;
}



#pragma mark ----------Rotated----------
- (UIImage *)imageRotatedByRadians:(CGFloat)radians{
    //沿着一定弧度旋转
    return [self imageRotatedByDegrees:TTIRadiansToDegrees(radians)];
}
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees{
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
	CGAffineTransform t = CGAffineTransformMakeRotation(TTIDegreesToRadians(degrees));
	rotatedViewBox.transform = t;
	CGSize rotatedSize = rotatedViewBox.frame.size;
    
	// Create the bitmap context
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();
	
	// Move the origin to the middle of the image so we will rotate and scale around the center.
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
	
	//   // Rotate the image context
	CGContextRotateCTM(bitmap, TTIDegreesToRadians(degrees));
	
	// Now, draw the rotated/scaled image into the context
	CGContextScaleCTM(bitmap, 1.0, -1.0);
	CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
	
	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}



#pragma mark ----------Resize----------
- (UIImage *)imageScaledToSize:(CGSize)size{
    
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
	
	float verticalRadio = size.height*1.0/height;
	float horizontalRadio = size.width*1.0/width;
	
	float radio = 1;
	if(verticalRadio>1 && horizontalRadio>1)
	{
		radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
	}
	else
	{
		radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
	}
	
	width = width*radio;
	height = height*radio;
	
    //	int xPos = (size.width - width)/2;
    //	int yPos = (size.height-height)/2;
	
	// 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
	
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(0, 0, width, height)];
	
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
	
    // 返回新的改变大小后的图片
    return scaledImage;
}



-(UIImage *)getImageFromView:(UIView *)orgView{
    UIGraphicsBeginImageContext(orgView.bounds.size);
    [orgView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); return image;
}


/*获取当前主题包的指定图片*/
/*+ (UIImage *)themeImageNamed:(NSString *)name
{
    NSUInteger themeID = [[ViewManager defaultManager] themeID];
    if (themeID == 0) {//默认主题
        NSString *fileName = [NSString stringWithFormat:@"Lianxi.bundle/Images/%@", name];
        return [self imageNamed:fileName];
    } else {//下载主题
        return nil;
    }
}*/

/*图片拉伸、平铺接口，兼容iOS5+*/
- (UIImage *)resizableImageWithCompatibleCapInsets:(UIEdgeInsets)capInsets resizingMode:(UIImageResizingMode)resizingMode
{
    CGFloat version = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (version >= 6.0) {
        return [self resizableImageWithCapInsets:capInsets resizingMode:resizingMode];
    } else if (version >= 5.0) {
        if (resizingMode == UIImageResizingModeStretch) {
            return [self stretchableImageWithLeftCapWidth:capInsets.left topCapHeight:capInsets.top];
        } else {//UIImageResizingModeTile
            return [self resizableImageWithCapInsets:capInsets];
        }
    } else {
        return [self stretchableImageWithLeftCapWidth:capInsets.left topCapHeight:capInsets.top];
    }
}

/*图片以ScaleToFit方式拉伸后的CGSize*/
- (CGSize)sizeOfScaleToFit:(CGSize)scaledSize
{
    CGFloat scaleFactor = scaledSize.width / scaledSize.height;
    CGFloat imageFactor = self.size.width / self.size.height;
    if (scaleFactor <= imageFactor) {//图片横向填充
        return CGSizeMake(scaledSize.width, scaledSize.width / imageFactor);
    } else {//纵向填充
        return CGSizeMake(scaledSize.height * imageFactor, scaledSize.height);
    }
}

/*将图片转向调整为向上*/
- (UIImage *)fixOrientation
{
    if (self.imageOrientation == UIImageOrientationUp) {
        return self;
    }
    
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    [self drawInRect:CGRectMake(0.0, 0.0, self.size.width, self.size.height)];
    
    UIImage *fixedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return fixedImage;
    
}
/*以ScaleToFit方式压缩图片*/
- (UIImage *)compressedImageWithSize:(CGSize)compressedSize
{
    if (CGSizeEqualToSize(self.size, CGSizeZero) || (self.size.width <= compressedSize.width && self.size.height <= compressedSize.height)) {//不用压缩
        return self;
    }
    
    CGSize scaledSize = [self sizeOfScaleToFit:compressedSize];
    
    //压缩大小，调整转向
    UIGraphicsBeginImageContext(scaledSize);
    [self drawInRect:CGRectMake(0.0, 0.0, scaledSize.width, scaledSize.height)];
    UIImage *compressedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return compressedImage;
}


@end
