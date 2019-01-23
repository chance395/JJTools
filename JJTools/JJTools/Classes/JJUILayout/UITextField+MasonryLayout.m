//
//  UITextField+MasonryLayout.m
//  qhg_ios
//
//  Created by Brain on 2018/9/9.
//  Copyright © 2018 In-next. All rights reserved.
//
#import "UITextField+MasonryLayout.h"
@implementation UITextField (MasonryLayout)

+(UITextField*)MAGetTextFieldWithFont:(UIFont*)font textColor:(UIColor*)textColor placeHolder:(NSString*)placeHolder keybordType:(UIKeyboardType)keyboardType isSecurity:(BOOL)security superView:(UIView*)superView masonrySet:(void(^)(UITextField*currentTextField,MASConstraintMaker*make))block
{
    UITextField *textField =[[UITextField alloc]init];
    textField.font =font;
    textField.textColor =textColor;
    if (placeHolder) {
        textField.placeholder =placeHolder;
    }
    textField.translatesAutoresizingMaskIntoConstraints =NO;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.secureTextEntry =security;
    textField.keyboardType=keyboardType;
    [superView addSubview:textField];
    
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        if (block) {
            block(textField,make);
        }
    }];
    return textField;
}


@end

