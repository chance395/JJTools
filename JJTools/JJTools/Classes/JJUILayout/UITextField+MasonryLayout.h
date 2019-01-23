//
//  UITextField+MasonryLayout.h
//  qhg_ios
//
//  Created by Brain on 2018/9/9.
//  Copyright © 2018 In-next. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@interface UITextField (MasonryLayout)

/**
 textField
 
 @param font font
 @param textColor textColor
 @param placeHolder place
 @param keyboardType type
 @param security   security
 @param superView superView
 @param block block
 @return UITextField
 */
+(UITextField*)MAGetTextFieldWithFont:(UIFont*)font textColor:(UIColor*)textColor placeHolder:(NSString*)placeHolder keybordType:(UIKeyboardType)keyboardType isSecurity:(BOOL)security superView:(UIView*)superView masonrySet:(void(^)(UITextField*currentTextField,MASConstraintMaker*make))block;

@end
