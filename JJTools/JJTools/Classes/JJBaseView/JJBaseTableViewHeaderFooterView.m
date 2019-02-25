//
//  JJBaseHeaderFooterView.m
//  qhg_ios
//
//  Created by Brain on 2018/9/14.
//  Copyright © 2018 In-next. All rights reserved.
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
#import "JJBaseTableViewHeaderFooterView.h"

@interface JJBaseTableViewHeaderFooterView ()
@property (nonatomic,strong) UIView      *behindView;
@property (nonatomic,strong) UIView      *afterView;
@end
@implementation JJBaseTableViewHeaderFooterView

+ (JJBaseTableViewHeaderFooterView *)getHeaderFooterViewWithTableView:(UITableView *)tableView
{
    static NSString * ID = @"JJBaseHeaderFooterView";
    JJBaseTableViewHeaderFooterView *headerView =[tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!headerView) {
        headerView =[[JJBaseTableViewHeaderFooterView alloc]initWithReuseIdentifier:ID];
        [headerView setupSubViews];
    }
    return headerView;
}

- (void)setupSubViews
{
    self.headerLabel =[UILabel MAGetLabelWithFont:FONT(12) text:@"当前订单" textColor:nil textAlignment:NSTextAlignmentCenter superView:self masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(17);
        make.top.equalTo(self.mas_top).mas_offset(14);
    }];
    
    self.behindView =[UIView MAGetUIViewWithBackgroundColor:UIColorFromHex(0xD2D2D2) superView:self masonrySet:^(UIView *currentView, MASConstraintMaker *make) {
        make.right.equalTo(self.headerLabel.mas_left).mas_offset(-16);
        make.top.equalTo(self.mas_top).mas_offset(22);
        make.left.equalTo(self.mas_left).mas_offset(37);
        make.height.mas_equalTo(1);
    }];
    
    self.afterView =[UIView MAGetUIViewWithBackgroundColor:UIColorFromHex(0xD2D2D2) superView:self masonrySet:^(UIView *currentView, MASConstraintMaker *make) {
        make.top.equalTo(self.behindView);
        make.left.equalTo(self.headerLabel.mas_right).mas_offset(16);
        make.right.equalTo(self.mas_right).mas_offset(-37);
        make.height.mas_equalTo(1);
    }];
    
    
}

@end

@implementation JJDetailOrderHeaderView

+ (JJDetailOrderHeaderView *)getHeaderFooterViewWithTableView:(UITableView *)tableView dataArray:(NSMutableArray*)arr
{
    static NSString * ID = @"JJDetailOrderHeaderView";
    JJDetailOrderHeaderView *headerView =[tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!headerView) {
        headerView =[[JJDetailOrderHeaderView alloc]initWithReuseIdentifier:ID];
        [headerView setupSubViews:arr];
        
    }
    return headerView;
}

- (void)setupSubViews:(NSMutableArray*)arr
{

    self.vcontentView =[UIView MAGetUIViewWithBackgroundColor:[UIColor whiteColor] superView:self masonrySet:^(UIView *currentView, MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(80);
    }];
    
    UIView *superView =self.vcontentView;
    

    
    self.headerLabel =[UILabel MAGetLabelWithFont:FONT(12) text:@"当前进度" textColor:[UIColor JJColorWithHexStr:@"#5E5E5E"] textAlignment:NSTextAlignmentLeft superView:superView masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(15);
    }];
    

    
    self.detailProcessLabel =[UILabel MAGetLabelWithFont:FONT(12) text:@"" textColor:[UIColor JJColorWithHexStr:@"#FF6042"] textAlignment:NSTextAlignmentLeft superView:superView masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
        make.left.equalTo(self.headerLabel.mas_left);
        make.top.equalTo(self.headerLabel.mas_bottom).mas_offset(11);
        make.right.equalTo(self.mas_right).mas_offset(-15);
        make.height.mas_equalTo(15);
        currentLabel.numberOfLines =1;
    }];
    
    
    self.arrowBtn =[UIButton MAGetButtonWithImage:@"detail_order_top" superView:superView target:self action:nil masonrySet:^(UIButton *currentBtn, MASConstraintMaker *make) {
                    make.right.equalTo(self.mas_right).mas_offset(-16);
                    make.centerY.equalTo(self.headerLabel);
                    make.width.and.height.mas_equalTo(25);
                   currentBtn.tag =120;
    }];

    self.underLineView2 =[UIView MAGetUIViewWithBackgroundColor:Color_Button_Disabled superView:superView masonrySet:^(UIView *currentView, MASConstraintMaker *make) {
        make.top.equalTo(self.detailProcessLabel.mas_bottom).mas_offset(10);
        make.left.equalTo(self.headerLabel.mas_left);
        make.right.equalTo(self.mas_right).mas_offset(-15);
        make.height.mas_equalTo(1);
    }];
}


@end


@implementation JJWechatVerifyHeaderView

+ (JJWechatVerifyHeaderView *)getHeaderFooterViewWithTableView:(UITableView *)tableView 
{
    static NSString * ID = @"JJWechatVerifyHeaderView";
    JJWechatVerifyHeaderView *headerView =[tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (!headerView) {
        headerView =[[JJWechatVerifyHeaderView alloc]initWithReuseIdentifier:ID];
        [headerView setupSubViews];
        
    }
    return headerView;
}

-(void)setupSubViews
{
    UILabel *title =[UILabel MAGetLabelWithFont:FONT(13) text:@"加分认证" textColor:[UIColor JJColorWithHexStr:@"#444444"] textAlignment:NSTextAlignmentLeft superView:self.contentView masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.centerY.equalTo(self.contentView);
    }];
    
    UILabel *subTitle =[UILabel MAGetLabelWithFont:FONT(13) text:@"选填,认证提高申请通过率" textColor:[UIColor JJColorWithHexStr:@"#808080"] textAlignment:NSTextAlignmentRight superView:self.contentView masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
        make.left.equalTo(title.mas_right).mas_offset(23);
        make.centerY.equalTo(title);
    }];
}


@end
