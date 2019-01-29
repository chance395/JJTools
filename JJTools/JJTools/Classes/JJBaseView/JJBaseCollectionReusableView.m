//
//  JJBaseCollectionReusableView.m
//  JJTools
//
//  Created by Brain on 2019/1/29.
//  Copyright © 2019 Brain. All rights reserved.
//

#import "Masonry.h"
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
#import "JJBaseCollectionReusableView.h"

@interface JJBaseCollectionReusableView ()

@property (nonatomic,strong) UILabel      *Title;
@property (nonatomic,strong) UILabel      *SubTitle;
@end

@implementation JJBaseCollectionReusableView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSubViews];
    }
    return self;
}


-(void)setupSubViews
{
    self.backgroundColor = RGBAColor(249, 249, 249, 1);
    self.Title =[UILabel MAGetLabelWithFont:FONT(15) text:@"" textColor:[UIColor JJColorWithHexStr:@"#333333"] textAlignment:NSTextAlignmentLeft superView:self masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
        make.left.mas_equalTo(17);
        make.centerY.equalTo(self);
        
    }];
    
    self.SubTitle =[UILabel MAGetLabelWithFont:FONT(12) text:@"" textColor:[UIColor JJColorWithHexStr:@"#777777"] textAlignment:NSTextAlignmentLeft superView:self masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
        make.left.equalTo(self.Title.mas_right).mas_offset(15);
        make.centerY.equalTo(self.Title);
    }];
    
}

- (void)configTitleWith:(NSDictionary*)dic
{
    self.Title.text =dic[@"title"];
    self.SubTitle.text =dic[@"subTitle"];
}

@end
