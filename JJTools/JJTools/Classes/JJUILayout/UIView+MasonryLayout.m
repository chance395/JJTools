//
//  UIView+MasonryLayout.m
//  qhg_ios
//
//  Created by Brain on 2018/9/9.
//  Copyright © 2018 In-next. All rights reserved.
//

#import "UIView+MasonryLayout.h"
#import "UIColor+JJTools.h"

@implementation UIView (MasonryLayout)

+ (UIView*)MAGetUIViewWithBackgroundColor:(UIColor*)viewColor superView:(UIView*)superView masonrySet:(void(^)(UIView*currentView,MASConstraintMaker*make))block
{
    UIView *view =[[UIView alloc]init];
    if (viewColor) {
        view.backgroundColor =viewColor;
    }
    view.translatesAutoresizingMaskIntoConstraints =NO;
    [superView addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        if (block) {
            block(view,make);
        }
    }];
    return view;
}

+ (UIView*)MAGetUIViewWithHexBackgroundColor:(NSString*)hexStr superView:(UIView*)superView masonrySet:(void(^)(UIView*currentView,MASConstraintMaker*make))block
{
   return   [UIView MAGetUIViewWithBackgroundColor:[UIColor JJColorWithHexStr:hexStr] superView:superView masonrySet:block];
}

+ (UIView*)MAGetUIViewWithBackgroundColor:(UIColor*)viewColor corner:(CGFloat)corners superView:(UIView*)superView masonrySet:(void(^)(UIView*currentView,MASConstraintMaker*make))block
{
    UIView *View =[UITextView MAGetUIViewWithBackgroundColor:viewColor superView:superView masonrySet:block];
    if (corners) {
        View.layer.cornerRadius =corners;
        View.layer.masksToBounds =YES;
    }
    return View;
}

+ (UIView*)MAGetUIViewWithHexBackgroundColor:(NSString*)viewColorStr corner:(CGFloat)corners superView:(UIView*)superView masonrySet:(void(^)(UIView*currentView,MASConstraintMaker*make))block;

{
    return [UIView MAGetUIViewWithBackgroundColor:[UIColor JJColorWithHexStr:viewColorStr] corner:corners superView:superView masonrySet:block];
}


@end
