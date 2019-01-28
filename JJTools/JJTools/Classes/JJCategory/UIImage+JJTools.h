//
//  UIImage+JJTools.h
//  qhg_ios
//
//  Created by Brain on 2018/9/11.
//  Copyright © 2018 In-next. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"Masonry.h"

@interface UIImage (JJTools)
/** 把颜色转换为图片 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  颜色转图片渐变
 *
 *  @param colors   颜色数组
 *  @param frame    位置
 *  @return UIView
 */
+ (UIImage*)BgImageFromColors:(NSArray*)colors withFrame: (CGRect)frame;
/** 返回一张可以随意拉伸不变形的图片 */
+ (UIImage *)resizableImage:(NSString *)imageName;

/** 从一个控件中截取指定大小的图片 */
+ (UIImage *)imageFromView :(UIView *)view size:(CGSize)size;

/** 从图片中按指定的位置大小截取图片的一部分 */
+ (UIImage *)cutImageFromImage:(UIImage *)image inRect:(CGRect)rect;

/** 生成二维码 */
+ (UIImage *)createQRCodeImageWithString:(NSString *)string size:(CGSize)size;

/** 生成条形码 */
+ (instancetype)createBarCodeImageWithString:(NSString *)string size:(CGSize)size;
+ (CIImage *)generateBarCodeImage:(NSString *)string;
+ (UIImage *)resizeCodeImage:(CIImage *)image withSize:(CGSize)size;
+ (UIImage *)compressOriginalImage:(UIImage *)image toSize:(CGSize)size;
//
//后台模糊效果
+(void)addBlurEffect;
+(void)removeBlurEffect;
/*
 1.白色,参数:
 透明度 0~1,  0为白,   1为深灰色
 半径:默认30,推荐值 3   半径值越大越模糊 ,值越小越清楚
 色彩饱和度(浓度)因子:  0是黑白灰, 9是浓彩色, 1是原色  默认1.8
 “彩度”，英文是称Saturation，即饱和度。将无彩色的黑白灰定为0，最鲜艳定为9s，这样大致分成十阶段，让数值和人的感官直觉一致。
 */
- (UIImage *)imgWithLightAlpha:(CGFloat)alpha radius:(CGFloat)radius colorSaturationFactor:(CGFloat)colorSaturationFactor;
- (UIImage *)imgWithBlur;
@end
