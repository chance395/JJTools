//
//  UIView+MasonryLayout.h
//  qhg_ios
//
//  Created by Brain on 2018/9/9.
//  Copyright © 2018 In-next. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"Masonry.h"


@interface UIView (MasonryLayout)

/**
 return View
 
 @param viewColor viewColor
 @param Corners radius
 @param superView superView
 @param block block
 @return UIView
 */
+ (UIView*)MAGetUIViewWithBackgroundColor:(UIColor*)viewColor cornerRadius:(CGFloat)Corners superView:(UIView*)superView masonrySet:(void(^)(UIView*currentView,MASConstraintMaker*make))block;


+ (UIView*)MAGetUIViewWithHexBackgroundColor:(NSString*)hexStr cornerRadius:(CGFloat)Corners superView:(UIView*)superView masonrySet:(void(^)(UIView*currentView,MASConstraintMaker*make))block;


@end
