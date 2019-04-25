//
//  UITextView+MasonryLayout.m
//  XueHua_SCI
//
//  Created by Brain on 2019/4/8.
//  Copyright © 2019 huanglu. All rights reserved.
//
#import "UIColor+JJTools.h"
#import "UITextView+MasonryLayout.h"
#import <objc/runtime.h>

static char * const PlaceHloder_key_String = "placeHolder";
static char * const PlaceHloder_key_String_Color = "placeHolderColor";
@implementation UITextView (MasonryLayout)
/** 动态添加属性
 */
- (void)setPlaceHolder:(NSString *)placeHolder
{
    objc_setAssociatedObject(self, PlaceHloder_key_String, placeHolder, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)placeHolder
{
    id placeholder = objc_getAssociatedObject(self, PlaceHloder_key_String);
    if (placeholder) {
        return placeholder ;
    }
    
    return @"";
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor{
    objc_setAssociatedObject(self, PlaceHloder_key_String_Color, placeHolderColor, OBJC_ASSOCIATION_RETAIN);
}


- (UIColor *)placeHolderColor
{
    id color = objc_getAssociatedObject(self, PlaceHloder_key_String_Color);
    if (color) {
        return color;
    }
    return [UIColor whiteColor];
}


+ (UITextView*)MAGetTextViewWithBackgroundColor:(UIColor*)viewColor textFont:(UIFont*)font textcolor:(UIColor*)textColor placeHolderStr:(NSString *)placeHolder  placeHolderColor:(UIColor*)placeHolderColor corner:(CGFloat)corner  superView:(UIView*)superView masonrySet:(void(^)(UITextView*currentView,MASConstraintMaker*make))block
{
    UITextView *textView =[[UITextView alloc]init];
    if (textColor) {
      textView.textColor =textColor;
    }
    if (corner >0) {
        textView.layer.cornerRadius =corner;
        textView.layer.masksToBounds =YES;
    }
    textView.layer.borderWidth =1;
    textView.layer.borderColor =[UIColor lightGrayColor].CGColor;
    if (viewColor) {
        textView.backgroundColor =viewColor;
    }
    if (font) {
        textView.font =font;
    }
    textView.translatesAutoresizingMaskIntoConstraints =NO;
    textView.placeHolderColor = placeHolderColor ? placeHolderColor : [UIColor lightGrayColor];
    textView.placeHolder =placeHolder ? placeHolder : @"";
    [textView configS];
    [superView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (block) {
            block(textView,make);
        }
    }];
    return textView;
}

-(void)configS
{
    UILabel *placeLabel =[[UILabel alloc]init];
    placeLabel.text =self.placeHolder;
    placeLabel.textColor =self.placeHolderColor;
    placeLabel.font =self.font;
    placeLabel.numberOfLines =0;
    [placeLabel sizeToFit];
    [self addSubview:placeLabel];
    [self setValue:placeLabel forKey:@"_placeholderLabel"];
}

@end
