//
//  UIColor+JJTools.h
//  qhg_ios
//
//  Created by Brain on 2018/9/17.
//  Copyright © 2018 In-next. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JJTools)

/**
 返回随机颜色

 @return 返回一个随机颜色
 */
+(UIColor *)JJRandomColor;

/**
 返回一个UIColor

 @param hexColor 16进制
 @param alpha 不透明度
 @return UIColor
 */
+(UIColor *)JJColorWithHexStr:(NSString *)hexColor alpha:(CGFloat)alpha;


+(UIColor *)JJColorWithHexStr:(NSString *)hexColor;
/**
 由RGB返回一个UIColor

 @param r red
 @param g green
 @param b blue
 @param alpha 不透明度
 @return UIColor
 */
+(UIColor *)JJColorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha;

@end
