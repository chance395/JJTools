//
//  UIButton+MasonryLayout.h
//  qhg_ios
//
//  Created by Brain on 2018/9/8.
//  Copyright © 2018 In-next. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"Masonry.h"

//指定imageEdge前两个参数所代表的方向
typedef NS_ENUM(NSUInteger, SAImageEdgeDirection) {
    
    SAImageEdgeTopLeft,
    SAImageEdgeTopRight,
    SAImageEdgeBottomLeft,
    SAImageEdgeBottomRight
};


typedef void (^actionBtnClickBlock)(NSInteger tagIndex,UIButton * currentBtn);

@interface JJCustombutton : UIButton

/**
 *  默认是UIEdgeInsetsZero,必须指定ImageEdgeDirection，指定前两个参数代表的方向，默认为前两个参数分别代表距上、左的距离，后两个参数为宽和高
 */
@property (nonatomic, assign) UIEdgeInsets imageEdge;                //默认是UIEdgeInsetsZero,分别传上、左、宽、高
@property (nonatomic, assign) SAImageEdgeDirection imageDirection;
@property (nonatomic, assign) UIEdgeInsets titleEdge;                //默认是UIEdgeInsetsZero，分别传上、左、下、右，四个参数都为距button的距离

@end

@interface UIButton (MasonryLayout)

@property (nonatomic, assign) CGFloat enlargedEdge;

- (void)JJEnlargedEdgeWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;
/**
 类方法返回UIButton title

 @param title title
 @param font font
 @param textColor textColor 提供RGB和16进制
 @param backColor backGroundColor
 @param corners corners
 @param superView superView
 @param block block
 @return UIButton
 */
+ (UIButton*)MAGetButtonWithTitle:(NSString*)title font:(UIFont*)font textColor:(UIColor*)textColor backGroundColor:(UIColor*)backColor corners:(CGFloat)corners superView:(UIView*)superView target:(id)target action:(SEL)selector masonrySet:(void(^)(UIButton*currentBtn,MASConstraintMaker*make))block;

+ (UIButton*)MAGetButtonWithTitle:(NSString*)title font:(UIFont*)font hexColorStr:(NSString*)TextColorStr hexBackGroundColor:(NSString*)hexBackColor corners:(CGFloat)corners superView:(UIView*)superView target:(id)target action:(SEL)selector masonrySet:(void(^)(UIButton*currentBtn,MASConstraintMaker*make))block;


/**
 类方法返回UIButton image

 @param imageName imageName
 @param superView superView
 @param block block
 @return UIButton
 */
+ (UIButton*)MAGetButtonWithImage:(NSString*)imageName superView:(UIView*)superView target:(id)target action:(SEL)selector masonrySet:(void(^)(UIButton*currentBtn,MASConstraintMaker*make))block;

+ (UIButton*)MAGetButtonWithBackgroundImage:(NSString*)imageName superView:(UIView*)superView target:(id)target action:(SEL)selector masonrySet:(void(^)(UIButton*currentBtn,MASConstraintMaker*make))block;

/**
 返回一个图片和文字并列的btn

 @param titleEdge title frame
 @param imageEdge image frame
 @param imageDirection 设置image的frame的方向
 @param font font
 @param textColor textColor RGB
 @param backColor color RGB
 @param corners corners
 @param superView superView
 @param target target
 @param selector sel
 @param block block
 @return btn
 */
+(UIButton *)MAGetCustomButtonWithTitleEdge:(UIEdgeInsets)titleEdge imageEdge:(UIEdgeInsets)imageEdge imageDirection:(SAImageEdgeDirection)imageDirection Font:(UIFont*)font TextColor:(UIColor*)textColor backGroundColor:(UIColor*)backColor corners:(CGFloat)corners superView:(UIView *)superView target:(id)target action:(SEL)selector masonrySet:(void (^)(UIButton *currentBtn,MASConstraintMaker *make))block;


/**
 runing btn

 @param btn btn
 @param str 显示格式
 @param finish finishblock
 */
-(void)JJStartRunSecond:(UIButton *)btn titleColor:(UIColor*)titleColor stringFormat:(NSString *)str finishBlock:(dispatch_block_t)finish;


/**
 return a arrow btn

 @return btn
 */
+ (UIButton *)JJGetRightArrowCustom;

@end
