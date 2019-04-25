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
 @param superView superView
 @param block block
 @return UIView
 */
+ (UIView*)MAGetUIViewWithBackgroundColor:(UIColor*)viewColor superView:(UIView*)superView masonrySet:(void(^)(UIView*currentView,MASConstraintMaker*make))block DEPRECATED_MSG_ATTRIBUTE("please use another method with corners");

/**
return View

 @param viewColor viewColorStr
 @param corners corners
 @param superView superView
 @param block block
 @return UIView
 */
+ (UIView*)MAGetUIViewWithBackgroundColor:(UIColor*)viewColor corner:(CGFloat)corners superView:(UIView*)superView masonrySet:(void(^)(UIView*currentView,MASConstraintMaker*make))block;


+ (UIView*)MAGetUIViewWithHexBackgroundColor:(NSString*)viewColorStr corner:(CGFloat)corners superView:(UIView*)superView masonrySet:(void(^)(UIView*currentView,MASConstraintMaker*make))block;

@end
