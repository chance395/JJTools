//
//  UIButton+MasonryLayout.m
//  qhg_ios
//
//  Created by Brain on 2018/9/8.
//  Copyright © 2018 In-next. All rights reserved.
//
#import <objc/runtime.h>
#import "UIButton+MasonryLayout.h"
#import "UIColor+JJTools.h"

static char topEdgeKey;
static char leftEdgeKey;
static char bottomEdgeKey;
static char rightEdgeKey;

@implementation JJCustombutton

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    
    switch (self.imageDirection) {
            
        case SAImageEdgeTopLeft:
            return CGRectMake(self.imageEdge.left, self.imageEdge.top, self.imageEdge.bottom, self.imageEdge.right);
            break;
        case SAImageEdgeTopRight:
            return CGRectMake(contentRect.size.width - self.imageEdge.bottom - self.imageEdge.left, self.imageEdge.top, self.imageEdge.bottom, self.imageEdge.right);
            break;
        case SAImageEdgeBottomLeft:
            return CGRectMake(self.imageEdge.left, contentRect.size.height - self.imageEdge.bottom - self.imageEdge.top, self.imageEdge.bottom, self.imageEdge.right);
            break;
        case SAImageEdgeBottomRight:
            return CGRectMake(contentRect.size.width - self.imageEdge.bottom - self.imageEdge.left, contentRect.size.height - self.imageEdge.bottom - self.imageEdge.top, self.imageEdge.bottom, self.imageEdge.right);
            break;
        default:
            return CGRectMake(self.imageEdge.left, self.imageEdge.top, self.imageEdge.bottom, self.imageEdge.right);
            break;
    }
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    return CGRectMake(self.titleEdge.left, self.titleEdge.top, self.frame.size.width - self.titleEdge.left - self.titleEdge.right, self.frame.size.height - self.titleEdge.top - self.titleEdge.bottom);
}

+(UIButton *)MAGetCustomButtonWithTitleEdge:(UIEdgeInsets)titleEdge imageEdge:(UIEdgeInsets)imageEdge imageDirection:(SAImageEdgeDirection)imageDirection imageName:(NSString*)imageNameStr Font:(UIFont*)font TextColor:(UIColor*)textColor backGroundColor:(UIColor*)backColor corners:(CGFloat)corners superView:(UIView *)superView target:(id)target action:(SEL)selector masonrySet:(void (^)(UIButton *currentBtn,MASConstraintMaker *make))block
{
    JJCustombutton *btn = [JJCustombutton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = font;
    btn.titleEdge = titleEdge;
    btn.imageEdge = imageEdge;
    btn.imageDirection = imageDirection;
    if (textColor) {
        [btn setTitleColor:textColor forState:UIControlStateNormal];
    }
    [btn setBackgroundColor:backColor];
    if (imageNameStr && ![imageNameStr isEqualToString:@""] ) {
        [btn setImage:[UIImage imageNamed:imageNameStr] forState:UIControlStateNormal];
    }
    if (corners>0) {
        btn.layer.cornerRadius =corners;
        btn.layer.masksToBounds =YES;
    }
    if (target && selector) {
        [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    [superView addSubview:btn];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (block) {
            block(btn,make);
        }
    }];
    return btn;
}

@end


@implementation UIButton (MasonryLayout)

- (void)setEnlargedEdge:(CGFloat)enlargedEdge
{
    [self JJEnlargedEdgeWithTop:enlargedEdge left:enlargedEdge bottom:enlargedEdge right:enlargedEdge];
}

- (CGFloat)enlargedEdge
{
    return [(NSNumber *)objc_getAssociatedObject(self, &topEdgeKey) floatValue];
}

- (void)JJEnlargedEdgeWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right
{
    objc_setAssociatedObject(self, &topEdgeKey, [NSNumber numberWithFloat:top], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &leftEdgeKey, [NSNumber numberWithFloat:left], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &bottomEdgeKey, [NSNumber numberWithFloat:bottom], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &rightEdgeKey, [NSNumber numberWithFloat:right], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)enlargedRect
{
    NSNumber * topEdge = objc_getAssociatedObject(self, &topEdgeKey);
    NSNumber * leftEdge = objc_getAssociatedObject(self, &leftEdgeKey);
    NSNumber * bottomEdge = objc_getAssociatedObject(self, &bottomEdgeKey);
    NSNumber * rightEdge = objc_getAssociatedObject(self, &rightEdgeKey);
    
    if (topEdge && leftEdge && bottomEdge && rightEdge)
    {
        CGRect enlargeRect = CGRectMake(self.bounds.origin.x - leftEdge.floatValue,
                                        self.bounds.origin.y - topEdge.floatValue,
                                        self.bounds.size.width + leftEdge.floatValue + rightEdge.floatValue,
                                        self.bounds.size.height + topEdge.floatValue + bottomEdge.floatValue);
        
        return enlargeRect;
    }
    else
    {
        return self.bounds;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.alpha <= 0.01 || !self.userInteractionEnabled || self.hidden)
    {
        return nil;
    }
    
    CGRect enlargeRect = [self enlargedRect];
    return CGRectContainsPoint(enlargeRect, point) ? self : nil;
}

+ (UIButton*)MAGetButtonWithTitle:(NSString*)title font:(UIFont*)font textColor:(UIColor*)textColor backGroundColor:(UIColor*)backColor corners:(CGFloat)corners superView:(UIView*)superView target:(id)target action:(SEL)selector masonrySet:(void(^)(UIButton*currentBtn,MASConstraintMaker*make))block
{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    if (textColor) {
        [btn setTitleColor:textColor forState:UIControlStateNormal];
    }
    btn.titleLabel.font =font;
    if (backColor) {
        btn.backgroundColor =backColor;
    }
    
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    if (corners>0) {
        btn.layer.cornerRadius=corners;
        btn.layer.masksToBounds=YES;
    }
    
    if (target && selector) {
        [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    [superView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (block) {
            block(btn,make);
        }
    }];
    return btn;
}

+ (UIButton*)MAGetButtonWithTitle:(NSString*)title font:(UIFont*)font hexColorStr:(NSString*)TextColorStr hexBackGroundColor:(NSString*)hexBackColor corners:(CGFloat)corners superView:(UIView*)superView target:(id)target action:(SEL)selector masonrySet:(void(^)(UIButton*currentBtn,MASConstraintMaker*make))block
{
    return [UIButton MAGetButtonWithTitle:title font:font textColor:[UIColor JJColorWithHexStr:TextColorStr] backGroundColor:[UIColor JJColorWithHexStr:hexBackColor] corners:corners superView:superView target:target action:selector masonrySet:block];
    
}

+ (UIButton*)MAGetButtonWithImage:(NSString*)imageName superView:(UIView*)superView target:(id)target action:(SEL)selector masonrySet:(void(^)(UIButton*currentBtn,MASConstraintMaker*make))block
{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    if (imageName && ![imageName isEqualToString:@""])
    {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addSubview:btn];

    if (target && selector) {
        [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }

    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (block) {
            block(btn,make);
        }
    }];
    return btn;
    
}

+ (UIButton*)MAGetButtonWithBackgroundImage:(NSString*)imageName superView:(UIView*)superView target:(id)target action:(SEL)selector masonrySet:(void(^)(UIButton*currentBtn,MASConstraintMaker*make))block
{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    if (imageName && ![imageName isEqualToString:@""])
    {
        [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [superView addSubview:btn];
    
    if (target && selector) {
        [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (block) {
            block(btn,make);
        }
    }];
    return btn;
}



-(void)JJStartRunSecond:(UIButton *)btn titleColor:(UIColor*)titleColor stringFormat:(NSString *)str finishBlock:(dispatch_block_t)finish
{
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    __block int timeout = 60; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                if (finish) {
                    finish();
                }
            });
        }else{
            int seconds = timeout % 61;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [btn setTitle:[NSString stringWithFormat:str,strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                btn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

#pragma mark --自定义右箭头
+ (UIButton *)JJGetRightArrowCustom;
{
    UIImage *image= [UIImage imageNamed:@"jump_arrow"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect frame = CGRectMake(0.0, 0.0, image.size.width, image.size.height);
    button.frame = frame;
    
    [button setImage :image forState:UIControlStateNormal];
    
    button.backgroundColor= [UIColor clearColor];
    return button;
}

@end
