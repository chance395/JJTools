//
//  JJBaseComponent.m
//  qhg_ios
//
//  Created by Brain on 2018/9/19.
//  Copyright © 2018 In-next. All rights reserved.
//

#import "JJMacroDefine.h"
#import "JJFontDefine.h"
#import "JJColorDefine.h"
#import "UIColor+JJTools.h"
#import "UILabel+MasonryLayout.h"
#import "UIButton+MasonryLayout.h"
#import "UIImageView+MasonryLayout.h"
#import "UIView+MasonryLayout.h"
#import "UITextField+MasonryLayout.h"
#import "UIImage+JJTools.h"
#import "JJBaseComponent.h"

@interface JJBaseComponent ()

@end
@implementation JJBaseComponent


@end

@interface JJTitleVerticalSubtitleComponent()
@end
@implementation JJTitleVerticalSubtitleComponent

- (instancetype)initWithFrame:(CGRect)frame WithTitleStr:(NSString*)title titleColor:(UIColor*)titlecolor subTitle:(NSString*)str color:(UIColor*)subtitlecolor  font:(UIFont*)font width:(CGFloat)width
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViewsWithTitleStr:title titleColor:titlecolor subTitle:str color:subtitlecolor font:font width:width];
    }
    return self;
}

- (void)setupSubViewsWithTitleStr:(NSString*)title titleColor:(UIColor*)titlecolor subTitle:(NSString*)str color:(UIColor*)subtitlecolor  font:(UIFont*)font width:(CGFloat)width
{
    self.titleLabel =[UILabel MAGetLabelWithFont:font text:title textColor:titlecolor textAlignment:NSTextAlignmentCenter superView:self masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
        make.left.and.top.equalTo(self);
        make.centerX.equalTo(self);
    }];
    
    self.subTitleLabel =[UILabel MAGetLabelWithFont:font text:str textColor:subtitlecolor textAlignment:NSTextAlignmentCenter superView:self masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(2);
        make.centerX.equalTo(self);
    }];
    
    
}
@end



@implementation JJTitleHorizontalSubtitleComponent

- (instancetype)initWithFrame:(CGRect)frame WithTitleStr:(NSString*)title  subTitle:(NSString*)str
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViewsWithTitleStr:title subTitle:str];
    }
    return self;
}

- (void)setupSubViewsWithTitleStr:(NSString*)title  subTitle:(NSString*)str
{
    self.titleLabel =[UILabel MAGetLabelWithFont:FONT(13) text:title textColor:[UIColor JJColorWithHexStr:@"#333333"] textAlignment:NSTextAlignmentLeft superView:self masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
        make.left.and.top.equalTo(self);
        make.centerX.equalTo(self);
    }];
    
    self.subTitleLabel =[UILabel MAGetLabelWithFont:FONT(13) text:str textColor:[UIColor JJColorWithHexStr:@"#333333"] textAlignment:NSTextAlignmentRight superView:self masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
       make.right.and.top.equalTo(self);
       make.centerX.equalTo(self);
    }];
}

@end

@implementation JJMine_Wechat_VerifyComponent

+(JJMine_Wechat_VerifyComponent*)MAGetComponentWithBackgroundColor:(UIColor*)viewColor paramDic:(NSDictionary*)paramDic superView:(UIView*)superView masonrySet:(void(^)(UIView*currentView,MASConstraintMaker*make))block
{
    JJMine_Wechat_VerifyComponent *component =[[JJMine_Wechat_VerifyComponent alloc]init];
    if (viewColor) {
        component.backgroundColor =viewColor;
    }
    
    [superView addSubview:component];
    [component mas_makeConstraints:^(MASConstraintMaker *make) {
        if (block) {
            block(component,make);
        }
    }];
    [component setupSubViewsWithParamDic:paramDic];
    
    return component;
}

-(void)setupSubViewsWithParamDic:(NSDictionary*)dic
{
    self.iconImageView =[UIImageView MAGetImageViewWith:dic[@"imageStr"] superView:self masonrySet:^(UIImageView *currentImageView, MASConstraintMaker *make) {
        make.left.and.top.equalTo(self);
        make.height.and.width.mas_equalTo(40);
    }];
    
    self.titleLabel =[UILabel MAGetLabelWithFont:FONT(16) text:dic[@"title"] textColor:[UIColor JJColorWithHexStr:@"#353030"] textAlignment:NSTextAlignmentLeft superView:self masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).mas_offset(18);
        make.top.equalTo(self.iconImageView);
        
    }];
    
    self.subTitleLabel =[UILabel MAGetLabelWithFont:FONT(11) text:dic[@"subTitle"] textColor:[UIColor JJColorWithHexStr:@"#808080"] textAlignment:NSTextAlignmentRight superView:self masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.iconImageView);
    }];
    
}


@end
