//
//  UILabel+MasonryLayout.m
//  qhg_ios
//
//  Created by Brain on 2018/9/8.
//  Copyright © 2018 In-next. All rights reserved.
//


#import "UILabel+MasonryLayout.h"
#import "UIColor+JJTools.h"

@implementation UILabel (MasonryLayout)

+ (UILabel*)MAGetLabelWithFont:(UIFont*)font text:(NSString*)text textColor:(UIColor*)textColor textAlignment:(NSTextAlignment)textAlignment superView:(UIView*)superView masonrySet:(void(^)(UILabel*currentLabel,MASConstraintMaker*make))block
{
    UILabel *label =[[UILabel alloc]init];
    label.text =text;
    if (textColor) {
        label.textColor =textColor;
    }
    label.textAlignment =textAlignment;
    if (font) {
        label.font =font;
    }
    label.translatesAutoresizingMaskIntoConstraints =NO;
    [superView addSubview:label];
    [label configLongPressGestureRecognizer];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        if (block) {
            block(label,make);
        }
    }];
    
    return label;
    
}

+ (UILabel*)MAGetLabelWithfont:(UIFont*)font text:(NSString*)text hexColorStr:(NSString*)hexColorStr textAlignment:(NSTextAlignment)textAlignment superView:(UIView*)superView masonrySet:(void(^)(UILabel*currentLabel,MASConstraintMaker*make))block
{
    return [UILabel MAGetLabelWithFont:font text:text textColor:[UIColor JJColorWithHexStr:hexColorStr] textAlignment:textAlignment superView:superView masonrySet:block];
    
}


- (CGFloat)JJTextHeightWithFont:(UIFont *)font width:(CGFloat)width
{
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    
    size =[self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size.height;
}


- (CGFloat)JJTextWidthWithFont:(UIFont *)font Height:(CGFloat)height
{
    CGSize size = CGSizeMake(CGFLOAT_MAX, height);
    
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    
    size =[self.text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size.width;
}

#pragma mark--configLongPress
- (BOOL)canBecomeFirstResponder {
    return YES;
}

-(void)configLongPressGestureRecognizer
{
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress)]];
}

- (void)longPress {
    [self becomeFirstResponder];
    UIMenuController * menu = [UIMenuController sharedMenuController];
    UIMenuItem * item1 = [[UIMenuItem alloc]initWithTitle:@"Copy" action:@selector(copyText:)];
    menu.menuItems = @[item1];
    [menu setTargetRect:self.bounds inView:self];
    [menu setMenuVisible:YES animated:YES];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if(action == @selector(copyText:)) return YES;
    return NO;
}

- (void)copyText:(UIMenuController *)menu {
    if (!self.text) return;
    UIPasteboard * paste = [UIPasteboard generalPasteboard];
    paste.string = self.text;
}


@end
