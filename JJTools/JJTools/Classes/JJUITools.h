//
//  JJUITools.h
//  qhg_ios
//
//  Created by Brain on 2018/9/10.
//  Copyright © 2018 In-next. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JJUITools : NSObject

/**
 返回一个带有两个图标的textField,underline从最左边图片下划

 @param originY originY
 @param leftLeftImage lleftImage
 @param leftImage leftImage
 @param kmargin margin
 @param strPlaceHolder placeHolder
 @param keyboardType type
 @param bSecurity yes or no
 @param underlinColor underLineColor
 @param superView superView
 @return uitextfield
 */
+(UITextField *)JJTextFieldWithOriginY:(CGFloat)originY withLeftLeftImage:(NSString *)leftLeftImage  leftImage:(NSString*)leftImage margin:(CGFloat)kmargin PlaceHolder:(NSString*)strPlaceHolder keyBoardType:(UIKeyboardType)keyboardType isSecurity:(BOOL)bSecurity underlineColor:(UIColor*)underlinColor superView:(UIView *)superView;

/**
 返回一个带有一个图标的textfield,underLine和textfiled对齐

 @param originY 初始Y
 @param leftImage 左边的图标
 @param kmargin margin
 @param strPlaceHolder placeHolder
 @param keyboardType type
 @param bSecurity yes or no
 @param superView superView
 @return uitextFiled
 */
+(UITextField *)JJTextFieldWithOriginY:(CGFloat)originY leftImage:(NSString*)leftImage margin:(CGFloat)kmargin PlaceHolder:(NSString*)strPlaceHolder keyBoardType:(UIKeyboardType)keyboardType isSecurity:(BOOL)bSecurity superView:(UIView *)superView;

+(UITextField *)JJTextFieldForChangePwDWithOriginY:(CGFloat)originY leftImage:(NSString*)leftImage margin:(CGFloat)kmargin PlaceHolder:(NSString*)strPlaceHolder keyBoardType:(UIKeyboardType)keyboardType isSecurity:(BOOL)bSecurity superView:(UIView *)superView;

/**
 返回满意袋home这种格式的

 @param originY 初始Y
 @param hexColor 左边的颜色
 @param kmargin margin
 @param strPlaceHolder placeHolder
 @param keyboardType type
 @param bSecurity yes or no
 @param underlinColor underLine
 @param rightTitle rightTitle
 @param superView superView
 @return uitextFiled
 */
+(UITextField *)JJTextFieldWithOriginY:(CGFloat)originY leftImageColor:(NSString*)hexColor margin:(CGFloat)kmargin PlaceHolder:(NSString*)strPlaceHolder keyBoardType:(UIKeyboardType)keyboardType isSecurity:(BOOL)bSecurity underlineColor:(UIColor*)underlinColor rightTitle:(NSString*)rightTitle superView:(UIView *)superView;
/**
  返回一个commitBtn

 @param originY 初始Y
 @param title title
 @param font font
 @param kmargin left and right
 @param bthHeight btn Height
 @param textColor textColor
 @param backColor backGroundColor
 @param corners corners
 @param superView superView
 @param target target
 @param selector SEL
 @param block finishBlock
 @return UIButton
 */
+ (UIButton*)JJGetButtonWithOriginY:(CGFloat)originY Title:(NSString*)title font:(UIFont*)font margin:(CGFloat)kmargin btnHeight:(CGFloat)bthHeight textColor:(UIColor*)textColor backGroundColor:(UIColor*)backColor corners:(CGFloat)corners superView:(UIView*)superView target:(id)target action:(SEL)selector masonrySet:(void(^)(UIButton*currentBtn,MASConstraintMaker*make))block;

@end
