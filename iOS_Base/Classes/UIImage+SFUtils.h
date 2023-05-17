//
//  UIImage+SFUtils.h
//  iOS_Base
//
//  Created by shefeng on 2023/5/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (SFUtils)

+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color withFrame:(CGRect)frame;

+ (UIImage *)imageWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor frame:(CGRect)frame;

+ (UIImage *)imageWithStartColor:(UIColor *)startColor endColor:(UIColor *)endColor frame:(CGRect)frame startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

- (UIImage *)resizeWithScale:(CGFloat)imageScale;

- (UIImage *)resizeWithSize:(CGSize)size;

+ (UIImage *)convertViewToImage:(UIView *)view;

//按比例缩放,size 是你要把图显示到 多大区域
- (UIImage *)imageCompressFitSizeScale:(CGSize)targetSize;

//指定宽度按比例缩放
- (UIImage *)imageCompressForWidthScale:(CGFloat)targetWidth;

@end

NS_ASSUME_NONNULL_END
