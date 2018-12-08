//
//  JJUITools.m
//  qhg_ios
//
//  Created by Brain on 2018/9/10.
//  Copyright © 2018 In-next. All rights reserved.
//

#import "JJUITools.h"

@implementation JJUITools


+(UITextField *)JJTextFieldWithOriginY:(CGFloat)originY withLeftLeftImage:(NSString *)leftLeftImage  leftImage:(NSString*)leftImage margin:(CGFloat)kmargin PlaceHolder:(NSString*)strPlaceHolder keyBoardType:(UIKeyboardType)keyboardType isSecurity:(BOOL)bSecurity underlineColor:(UIColor*)underlinColor superView:(UIView *)superView
{
   UIView * view =[UIView MAGetViewWithBackgroundColor:[UIColor whiteColor] superView:superView masonrySet:^(UIView *currentView, MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).mas_offset(kmargin);
        make.top.equalTo(superView.mas_top).mas_offset(originY);
        make.width.mas_equalTo(SCREEN_WIDTH-2*kmargin);
        make.height.mas_equalTo(kTextFieldHeight+1);
    }];
    
    UIImage * imagelleft = [UIImage imageNamed:leftLeftImage];
    UIImageView * imvLLeft =[UIImageView MAGetImageViewWith:leftLeftImage superView:view masonrySet:^(UIImageView *currentImageView, MASConstraintMaker *make) {
        make.left.equalTo(view);
        make.centerY.equalTo(view);
        make.width.mas_equalTo(imagelleft.size.width);
        make.height.mas_equalTo(imagelleft.size.height);
    }];
    
    UIImage * image = [UIImage imageNamed:leftImage];
    UIImageView *imvLeft =[UIImageView MAGetImageViewWith:leftImage superView:view masonrySet:^(UIImageView *currentImageView, MASConstraintMaker *make) {
        make.left.equalTo(imvLLeft.mas_right).mas_offset(13);
        make.centerY.equalTo(view);
        make.width.mas_equalTo(image.size.width);
        make.height.mas_equalTo(image.size.height);
    }];
    
    UITextField * tf =[UITextField MAGetTextFieldWithFont:FONT(16) textColor:UIColorFromRGB(0x212C38) placeHolder:strPlaceHolder keybordType:keyboardType isSecurity:bSecurity superView:view masonrySet:^(UITextField *currentTextField, MASConstraintMaker *make) {
        make.left.equalTo(imvLeft.mas_right).mas_offset(17);
        make.top.equalTo(view);
        make.right.equalTo(view.mas_right);
        make.height.mas_equalTo(kTextFieldHeight);
    }];
    
    UIView *vline =[UIView MAGetViewWithBackgroundColor:underlinColor superView:view masonrySet:^(UIView *currentView, MASConstraintMaker *make) {
        make.left.equalTo(view);
        make.top.mas_equalTo(kTextFieldHeight+5);
        make.width.mas_equalTo(SCREEN_WIDTH-2*kmargin);
        make.height.mas_equalTo(0.5);
    }];
    vline.backgroundColor =underlinColor;
    
    return tf;
    
}


+(UITextField *)JJTextFieldWithOriginY:(CGFloat)originY leftImage:(NSString*)leftImage margin:(CGFloat)kmargin PlaceHolder:(NSString*)strPlaceHolder keyBoardType:(UIKeyboardType)keyboardType isSecurity:(BOOL)bSecurity superView:(UIView *)superView
{
    UIView * view =[UIView MAGetViewWithBackgroundColor:[UIColor whiteColor] superView:superView masonrySet:^(UIView *currentView, MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).mas_offset(kmargin);
        make.top.equalTo(superView.mas_top).mas_offset(originY);
        make.width.mas_equalTo(SCREEN_WIDTH-72-2*kmargin);
        make.height.mas_equalTo(kTextFieldHeight);
        currentView.backgroundColor =[UIColor JJColorWithHexStr:@"#F5F7F7"];
    }];
    
    UIImage * imageleft = [UIImage imageNamed:leftImage];
    UIImageView * imvLeft =[UIImageView MAGetImageViewWith:leftImage superView:view masonrySet:^(UIImageView *currentImageView, MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).mas_offset(15);
        make.centerY.equalTo(view);
        make.width.mas_equalTo(imageleft.size.width);
        make.height.mas_equalTo(imageleft.size.height);
    }];
    
    UITextField * tf =[UITextField MAGetTextFieldWithFont:FONT(16) textColor:UIColorFromRGB(0x212C38) placeHolder:strPlaceHolder keybordType:keyboardType isSecurity:bSecurity superView:view masonrySet:^(UITextField *currentTextField, MASConstraintMaker *make) {
        make.left.equalTo(imvLeft.mas_right).mas_offset(9);
        make.top.equalTo(view);
        make.right.equalTo(view.mas_right);
        make.height.mas_equalTo(kTextFieldHeight);
    }];
    
//    UIView *vline =[UIView MAGetViewWithBackgroundColor:underlinColor superView:view masonrySet:^(UIView *currentView, MASConstraintMaker *make) {
//        make.left.equalTo(tf);
//        make.top.mas_equalTo(kTextFieldHeight+5);
//        make.width.mas_equalTo(SCREEN_WIDTH-2*kmargin);
//        make.height.mas_equalTo(0.5);
//    }];
//    vline.backgroundColor =underlinColor;
    
    return tf;
}


+(UITextField *)JJTextFieldForChangePwDWithOriginY:(CGFloat)originY leftImage:(NSString*)leftImage margin:(CGFloat)kmargin PlaceHolder:(NSString*)strPlaceHolder keyBoardType:(UIKeyboardType)keyboardType isSecurity:(BOOL)bSecurity superView:(UIView *)superView
{
    UIView * view =[UIView MAGetViewWithBackgroundColor:[UIColor whiteColor] superView:superView masonrySet:^(UIView *currentView, MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).mas_offset(kmargin);
        make.top.equalTo(superView.mas_top).mas_offset(originY);
        make.width.mas_equalTo(SCREEN_WIDTH-2*kmargin);
        make.height.mas_equalTo(kTextFieldHeight);
        currentView.backgroundColor =[UIColor JJColorWithHexStr:@"#F5F7F7"];
    }];
    
    UIImage * imageleft = [UIImage imageNamed:leftImage];
    UIImageView * imvLeft =[UIImageView MAGetImageViewWith:leftImage superView:view masonrySet:^(UIImageView *currentImageView, MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).mas_offset(15);
        make.centerY.equalTo(view);
        make.width.mas_equalTo(imageleft.size.width);
        make.height.mas_equalTo(imageleft.size.height);
    }];
    
    UITextField * tf =[UITextField MAGetTextFieldWithFont:FONT(16) textColor:UIColorFromRGB(0x212C38) placeHolder:strPlaceHolder keybordType:keyboardType isSecurity:bSecurity superView:view masonrySet:^(UITextField *currentTextField, MASConstraintMaker *make) {
        make.left.equalTo(imvLeft.mas_right).mas_offset(9);
        make.top.equalTo(view);
        make.right.equalTo(view.mas_right);
        make.height.mas_equalTo(kTextFieldHeight);
    }];
    
    return tf;
}

+(UITextField *)JJTextFieldWithOriginY:(CGFloat)originY leftImageColor:(NSString*)hexColor margin:(CGFloat)kmargin PlaceHolder:(NSString*)strPlaceHolder keyBoardType:(UIKeyboardType)keyboardType isSecurity:(BOOL)bSecurity underlineColor:(UIColor*)underlinColor rightTitle:(NSString*)rightTitle superView:(UIView *)superView
{
    UIView * view =[UIView MAGetViewWithBackgroundColor:[UIColor purpleColor] superView:superView masonrySet:^(UIView *currentView, MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).mas_offset(kmargin);
        make.top.equalTo(superView.mas_top).mas_offset(originY);
        make.width.mas_equalTo(SCREEN_WIDTH-2*kmargin);
        make.height.mas_equalTo(kTextFieldHeight+1);
    }];
    
    UIView *left =[UIView MAGetViewWithBackgroundColor:[UIColor JJColorWithHexStr:hexColor] superView:view masonrySet:^(UIView *currentView, MASConstraintMaker *make) {
        make.left.equalTo(view);
        make.centerY.equalTo(view);
        make.width.mas_equalTo(10);
        make.height.mas_equalTo(10);
    }];
    
    UITextField * tf =[UITextField MAGetTextFieldWithFont:FONT(16) textColor:UIColorFromRGB(0x212C38) placeHolder:strPlaceHolder keybordType:keyboardType isSecurity:bSecurity superView:view masonrySet:^(UITextField *currentTextField, MASConstraintMaker *make) {
        make.left.equalTo(left.mas_right).mas_offset(5);
        make.top.equalTo(view);
        make.right.equalTo(view.mas_right);
        make.height.mas_equalTo(kTextFieldHeight);
    }];
    
    UILabel *rightLabel =[UILabel MAGetLabelWithfont:FONT(15) text:rightTitle hexColorStr:@"#BBBBBE" textAlignment:NSTextAlignmentRight superView:view masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
        make.right.equalTo(view);
        make.centerY.equalTo(view);
        make.height.mas_equalTo(17);
        make.width.mas_greaterThanOrEqualTo(65);
    }];
    
    UIView *vline =[UIView MAGetViewWithBackgroundColor:underlinColor superView:view masonrySet:^(UIView *currentView, MASConstraintMaker *make) {
        make.right.equalTo(rightLabel);
        make.top.mas_equalTo(kTextFieldHeight+5);
        make.width.mas_equalTo(SCREEN_WIDTH-2*kmargin);
        make.height.mas_equalTo(0.5);
    }];
    vline.backgroundColor =underlinColor;
    
    return tf;
}
+ (UIButton*)JJGetButtonWithOriginY:(CGFloat)originY Title:(NSString*)title font:(UIFont*)font margin:(CGFloat)kmargin btnHeight:(CGFloat)bthHeight textColor:(UIColor*)textColor backGroundColor:(UIColor*)backColor corners:(CGFloat)corners superView:(UIView*)superView target:(id)target action:(SEL)selector masonrySet:(void(^)(UIButton*currentBtn,MASConstraintMaker*make))block
{
    return [UIButton MAGetButtonWithTitle:title font:font textColor:textColor backGroundColor:backColor corners:corners superView:superView target:target action:selector masonrySet:^(UIButton *currentBtn, MASConstraintMaker *make) {
        make.left.equalTo(superView.mas_left).mas_offset(kmargin);
        make.right.equalTo(superView.mas_right).mas_offset(-kmargin);
        make.top.mas_equalTo(originY);
        make.height.mas_equalTo(bthHeight);
    }];
    
}


@end
