//
//  JJBaseComponent.h
//  qhg_ios
//
//  Created by Brain on 2018/9/19.
//  Copyright © 2018 In-next. All rights reserved.
//
#import "Masonry.h"
#import <UIKit/UIKit.h>

@interface JJBaseComponent : UIView

@end

@interface JJTitleVerticalSubtitleComponent : UIView

@property(nonatomic,strong) UILabel                     * titleLabel;

@property(nonatomic,strong) UILabel                     * subTitleLabel;

- (instancetype)initWithFrame:(CGRect)frame WithTitleStr:(NSString*)title titleColor:(UIColor*)titlecolor subTitle:(NSString*)str color:(UIColor*)subtitlecolor  font:(UIFont*)font width:(CGFloat)width;

@end

@interface JJTitleHorizontalSubtitleComponent : UIView

@property(nonatomic,strong) UILabel                     * titleLabel;

@property(nonatomic,strong) UILabel                     * subTitleLabel;

- (instancetype)initWithFrame:(CGRect)frame WithTitleStr:(NSString*)title  subTitle:(NSString*)str;

@end

@interface JJMine_Wechat_VerifyComponent : JJBaseComponent

@property(nonatomic,strong) UIImageView                 * iconImageView;

@property(nonatomic,strong) UILabel                     * titleLabel;

@property(nonatomic,strong) UILabel                     * subTitleLabel;

+(JJMine_Wechat_VerifyComponent*)MAGetComponentWithBackgroundColor:(UIColor*)viewColor paramDic:(NSDictionary*)paramDic superView:(UIView*)superView masonrySet:(void(^)(UIView*currentView,MASConstraintMaker*make))block;

@end

