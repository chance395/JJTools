//
//  UITextView+MasonryLayout.h
//  XueHua_SCI
//
//  Created by Brain on 2019/4/8.
//  Copyright © 2019 huanglu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"


@interface UITextView (MasonryLayout)

/**
 *  UITextView+placeholder
 */
@property (nonatomic, copy) NSString *placeHolder;

@property (nonatomic , strong) UIColor * placeHolderColor;


/**
  返回一个textView

 @param viewColor background
 @param font font
 @param textColor textColor
 @param placeHolder placeHolder
 @param placeHolderColor placeHolderColor
 @param corner corner
 @param superView superView
 @param block Block
 @return textView
 */
+ (UITextView*)MAGetTextViewWithBackgroundColor:(UIColor*)viewColor textFont:(UIFont*)font textcolor:(UIColor*)textColor placeHolderStr:(NSString *)placeHolder  placeHolderColor:(UIColor*)placeHolderColor corner:(CGFloat)corner  superView:(UIView*)superView masonrySet:(void(^)(UITextView*currentView,MASConstraintMaker*make))block;

@end
