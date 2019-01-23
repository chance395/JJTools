//
//  UILabel+MasonryLayout.h
//  qhg_ios
//
//  Created by Brain on 2018/9/8.
//  Copyright © 2018 In-next. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"Masonry.h"

@interface UILabel (MasonryLayout)


/**
 类返回一个对象

 @param font font 对font设置
 @param text text
 @param textColor color
 @param textAlignment alignment
 @param superView superView
 @param block masonryBlock
 @return uilabel
 */

+ (UILabel*)MAGetLabelWithFont:(UIFont*)font text:(NSString*)text textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)textAlignment superView:(UIView*)superView masonrySet:(void(^)(UILabel*currentLabel,MASConstraintMaker*make))block;

+ (UILabel*)MAGetLabelWithfont:(UIFont*)font text:(NSString*)text hexColorStr:(NSString*)hexColorStr textAlignment:(NSTextAlignment)textAlignment superView:(UIView*)superView masonrySet:(void(^)(UILabel*currentLabel,MASConstraintMaker*make))block;


/**
 返回高度

 @param font font
 @param width width
 @return 高度
 */
- (CGFloat)JJTextHeightWithFont:(UIFont *)font width:(CGFloat)width;

/**
 返回宽度

 @param font font
 @param height height
 @return 高度
 */
- (CGFloat)JJTextWidthWithFont:(UIFont *)font Height:(CGFloat)height;

@end
