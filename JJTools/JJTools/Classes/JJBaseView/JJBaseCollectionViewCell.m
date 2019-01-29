//
//  JJBaseCollectionViewCell.m
//  qhg_ios
//
//  Created by Brain on 2018/9/20.
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
#import "JJBaseCollectionViewCell.h"

@implementation JJBaseCollectionViewCell

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
    self.topImage =[UIImageView MAGetImageViewWith:@"" superView:self.contentView masonrySet:^(UIImageView *currentImageView, MASConstraintMaker *make) {
        make.top.mas_equalTo(32);
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(35);
        
    }];
    
    self.veryfiedlabel =[UILabel MAGetLabelWithFont:[UIFont systemFontOfSize:7] text:@"必填" textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentCenter superView:self.contentView masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(23);
        make.bottom.equalTo(self.topImage.mas_top).mas_offset(-10);
        make.left.equalTo(self.topImage.mas_right).mas_offset(-10);
        currentLabel.layer.cornerRadius =7;
        currentLabel.layer.masksToBounds =YES;
        currentLabel.backgroundColor =[UIColor JJColorWithHexStr:@"#333333"];
    }];
    
    self.botlabel =[UILabel MAGetLabelWithFont:[UIFont systemFontOfSize:15] text:@"" textColor:[UIColor JJColorWithHexStr:@"#333333"] textAlignment:NSTextAlignmentCenter superView:self.contentView masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
        make.top.equalTo(self.topImage.mas_bottom).mas_offset(16);
        make.centerX.equalTo(self.contentView);
    }];
    
}


- (void)configJJBaseCollectionViewCellWithDic:(NSDictionary *)dic arrdata:(NSMutableArray *)arrData indexPath:(NSIndexPath *)indexPath
{
    if (dic[@"icon"]) {
        self.topImage.image =[UIImage imageNamed:dic[@"icon"]];
    }
    
    if (dic[@"title"]) {
        self.botlabel.text =dic[@"title"];
    }
    
    self.veryfiedlabel.hidden =YES;
}
@end



@implementation JJMineInfoCollectionCell

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
    self.contentView.backgroundColor =[UIColor whiteColor];
    self.topImageInfo =[UIImageView MAGetImageViewWith:@"" superView:self.contentView masonrySet:^(UIImageView *currentImageView, MASConstraintMaker *make) {
        make.top.mas_equalTo(32);
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(35);
        
    }];
    
    self.botlabelInfo =[UILabel MAGetLabelWithFont:FONT(15) text:@"" textColor:[UIColor JJColorWithHexStr:@"#333333"] textAlignment:NSTextAlignmentCenter superView:self.contentView masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
        make.top.equalTo(self.topImageInfo.mas_bottom).mas_offset(16);
        make.centerX.equalTo(self.contentView);
    }];
  
    
}
- (void)configMineInfoJJBaseCollectionViewCellWithDic:(NSDictionary *)dic arrdata:(NSMutableArray *)arrData indexpath:(NSIndexPath*)index
{
    self.veryfiedlabelInfo.hidden =YES;
    
    if (index.row ==5) {
        self.veryfiedlabelInfo .hidden =NO;
        
        if ( [dic[@"status"]isEqualToString:@"1"])
        {
            self.veryfiedlabelInfo.text =@"已填";
            self.veryfiedlabelInfo.backgroundColor =[UIColor JJColorWithHexStr:@"#333333"];
        }
        else
        {
            self.veryfiedlabelInfo.text =@"选填";
            self.veryfiedlabelInfo.backgroundColor =[UIColor JJColorWithHexStr:@"#333333"];
            
        }
   
    }
    
    if (dic[@"icon"]) {
        self.topImageInfo.image =[UIImage imageNamed:dic[@"icon"]];
    }
    
    if (dic[@"title"]) {
        self.botlabelInfo.text =dic[@"title"];
    }
    

}


@end


