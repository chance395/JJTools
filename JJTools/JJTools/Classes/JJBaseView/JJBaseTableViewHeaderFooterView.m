//
//  JJBaseHeaderFooterView.m
//  qhg_ios
//
//  Created by Brain on 2018/9/14.
//  Copyright © 2018 In-next. All rights reserved.
//

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
//    NSUInteger count =arr.count;
//    CGFloat height =0.f;
//    if (count>0) {
//        UILabel * label =[UILabel new];
//        label.text =arr[count-1][@"statusStr"];
//        height =[label JJTextHeightWithFont:FONT(12) width:SCREEN_WIDTH-40];
//    }
    self.vcontentView =[UIView MAGetUIViewWithBackgroundColor:[UIColor whiteColor] superView:self masonrySet:^(UIView *currentView, MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.and.right.mas_equalTo(self);
        make.height.mas_equalTo(80);
    }];
    UIView *superView =self.vcontentView;
    
//    self.lefColor =[UIView MAGetUIViewWithBackgroundColor:[UIColor JJColorWithHexStr:@"#8C88FF"] superView:superView masonrySet:^(UIView *currentView, MASConstraintMaker *make) {
//        make.left.and.top.mas_equalTo(15);
//        make.width.and.height.mas_equalTo(10);
//    }];
    
    self.headerLabel =[UILabel MAGetLabelWithFont:FONT(12) text:@"当前进度" textColor:[UIColor JJColorWithHexStr:@"#5E5E5E"] textAlignment:NSTextAlignmentLeft superView:superView masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(15);
    }];
    
//    self.underLineView =[UIView MAGetUIViewWithBackgroundColor:Color_Button_Disabled superView:superView masonrySet:^(UIView *currentView, MASConstraintMaker *make) {
//        make.left.equalTo(self.lefColor);
//        make.top.equalTo(self.lefColor.mas_bottom).mas_offset(16);
//        make.right.equalTo(self.mas_right).mas_offset(-15);
//        make.height.mas_equalTo(1);
//    }];
//
//    self.currenProcessLabel =[UILabel MAGetLabelWithFont:FONT(15) text:@"当前进度" textColor:[UIColor JJColorWithHexStr:@"#1D1D26"] textAlignment:NSTextAlignmentLeft superView:superView masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
//        make.top.equalTo(self.underLineView.mas_bottom).mas_offset(11);
//        make.left.mas_equalTo(19);
//
//    }];
    
//    self.historyImageView =[UIImageView MAGetImageViewWith:@"history_detail" superView:superView masonrySet:^(UIImageView *currentImageView, MASConstraintMaker *make) {
//        make.left.equalTo(self.currenProcessLabel);
//        make.top.equalTo(self.currenProcessLabel.mas_bottom).mas_offset(15);
//        make.width.and.height.mas_equalTo(15);
//    }];
//
    
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

    self.underLineView2 =[UIView MAGetUIViewWithBackgroundColor:Color_Button_DisabledColor superView:superView masonrySet:^(UIView *currentView, MASConstraintMaker *make) {
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
    
}


@end
