//
//  UIImage+SFUtils.m
//  iOS_Base
//
//  Created by shefeng on 2023/5/15.
//

#import "UIImage+SFUtils.h"

@implementation UIImage (SFUtils)

+ (UIImage *)imageWithColor:(UIColor *)color{
    return [UIImage imageWithColor:color withFrame:CGRectMake(0, 0, 1, 1)];
}

+ (UIImage *)imageWithColor:(UIColor *)color withFrame:(CGRect)frame{
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, frame);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

+ (UIImage *)imageWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor frame:(CGRect)frame{
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = frame;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);

    gradientLayer.colors = @[(__bridge id) startColor.CGColor, (__bridge id) endColor.CGColor];
    
    UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, gradientLayer.opaque, 0);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

+ (UIImage *)imageWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor frame:(CGRect)frame startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = frame;
    gradientLayer.startPoint = startPoint;
    gradientLayer.endPoint = endPoint;

    gradientLayer.colors = @[(__bridge id) startColor.CGColor, (__bridge id) endColor.CGColor];
    
    UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, gradientLayer.opaque, 0);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

- (UIImage *)resizeWithSize:(CGSize)size{
    
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGImageRef imageRef = self.CGImage;
    CGFloat srcWidth = CGImageGetWidth(imageRef);
    CGFloat srcHeight = CGImageGetHeight(imageRef);
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.frame = CGRectMake(0, 0, size.width, size.height);
    
    CGSize s = imageView.frame.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, scale);
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

- (UIImage *)resizeWithScale:(CGFloat)imageScale{
    
    CGFloat scale = [UIScreen mainScreen].scale;
    
    CGImageRef imageRef = self.CGImage;
    CGFloat srcWidth = CGImageGetWidth(imageRef);
    CGFloat srcHeight = CGImageGetHeight(imageRef);
    
    CGFloat destWidth = srcWidth * imageScale;
    CGFloat destHeight = srcHeight * imageScale;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:self];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.frame = CGRectMake(0, 0, destWidth/scale, destHeight/scale);
    
    CGSize s = imageView.frame.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, scale);
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

+ (UIImage *)convertViewToImage:(UIView *)view {
    UIImage *image = [[UIImage alloc]init];
    //UIGraphicsBeginImageContextWithOptions(区域大小, 是否是非透明的, 屏幕密度);
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

//按比例缩放,size 是你要把图显示到 多大区域
- (UIImage *)imageCompressFitSizeScale:(CGSize)targetSize{
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, targetSize) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
            
        }
        else{
            
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [self drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}

//指定宽度按比例缩放
- (UIImage *)imageCompressForWidthScale:(CGFloat)targetWidth{
    UIImage *newImage = nil;
    CGSize imageSize = self.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
 
    if(CGSizeEqualToSize(imageSize, size) == NO){
 
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
 
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
 
        if(widthFactor > heightFactor){
 
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
 
        }else if(widthFactor < heightFactor){
 
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
 
    UIGraphicsBeginImageContext(size);
 
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
 
    [self drawInRect:thumbnailRect];
 
    newImage = UIGraphicsGetImageFromCurrentImageContext();
 
    if(newImage == nil){
 
        NSLog(@"scale image fail");
    }
    UIGraphicsEndImageContext();
    return newImage;
}

@end
