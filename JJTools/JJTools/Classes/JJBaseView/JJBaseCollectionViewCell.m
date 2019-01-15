//
//  JJBaseCollectionViewCell.m
//  qhg_ios
//
//  Created by Brain on 2018/9/20.
//  Copyright © 2018 In-next. All rights reserved.
//

#import "JJBaseCollectionViewCell.h"

@implementation JJBaseCollectionViewCell


+ (JJBaseCollectionViewCell *)getCellWithCollectionView:(UICollectionView *)collectionView forIndexpath:(NSIndexPath*)indexpath
{
    static NSString * ID = @"JJBaseCollectionViewCell";
    
    JJBaseCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexpath];
      [cell setupSubViews];
    cell.backgroundColor =[UIColor whiteColor];
    return cell;
    
}


-(void)setupSubViews
{
    self.topImage =[UIImageView MAGetImageViewWith:@"" superView:self.contentView masonrySet:^(UIImageView *currentImageView, MASConstraintMaker *make) {
        make.top.mas_equalTo(32);
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(35);
        
    }];
    
    self.veryfiedlabel =[UILabel MAGetLabelWithFont:FONT(9) text:@"必填" textColor:Color_WhiteColor textAlignment:NSTextAlignmentCenter superView:self.contentView masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
        make.height.mas_equalTo(14);
        make.width.mas_equalTo(23);
        make.bottom.equalTo(self.topImage.mas_top).mas_offset(-10);
        make.left.equalTo(self.topImage.mas_right).mas_offset(-10);
        currentLabel.layer.cornerRadius =7;
        currentLabel.layer.masksToBounds =YES;
        currentLabel.backgroundColor =Color_TableViewEmpty_TitleColor;
    }];
    
    self.botlabel =[UILabel MAGetLabelWithFont:FONT(15) text:@"" textColor:[UIColor JJColorWithHexStr:@"#333333"] textAlignment:NSTextAlignmentCenter superView:self.contentView masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
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




+ (JJMineInfoCollectionCell *)getcellMineInfoWithCollectionView:(UICollectionView *)collectionView forIndexpath:(NSIndexPath*)indexpath
{
    static NSString * ID = @"JJMineInfoCollectionCell";
    
    JJMineInfoCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexpath];
    [cell setupSubViews];
    cell.backgroundColor =[UIColor whiteColor];
    return cell;
    
    
}
-(void)setupSubViews
{
    if (!self.topImageInfo) {
        self.topImageInfo =[UIImageView MAGetImageViewWith:@"" superView:self.contentView masonrySet:^(UIImageView *currentImageView, MASConstraintMaker *make) {
            make.top.mas_equalTo(32);
            make.centerX.equalTo(self.contentView);
            make.width.mas_equalTo(35);
            make.height.mas_equalTo(35);
            
        }];
    }
    
    
    if (!self.veryfiedlabelInfo) {
        self.veryfiedlabelInfo =[UILabel MAGetLabelWithFont:FONT(9) text:@"必填" textColor:Color_WhiteColor textAlignment:NSTextAlignmentCenter superView:self.contentView masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
            make.height.mas_equalTo(14);
            make.width.mas_equalTo(23);
            make.bottom.equalTo(self.topImageInfo.mas_top).mas_offset(-10);
            make.left.equalTo(self.topImageInfo.mas_right).mas_offset(-10);
            currentLabel.layer.cornerRadius =7;
            currentLabel.layer.masksToBounds =YES;
            currentLabel.backgroundColor =Color_TableViewEmpty_TitleColor;
        }];
    }
    
    if (!self.botlabelInfo) {
        self.botlabelInfo =[UILabel MAGetLabelWithFont:FONT(15) text:@"" textColor:[UIColor JJColorWithHexStr:@"#333333"] textAlignment:NSTextAlignmentCenter superView:self.contentView masonrySet:^(UILabel *currentLabel, MASConstraintMaker *make) {
            make.top.equalTo(self.topImageInfo.mas_bottom).mas_offset(16);
            make.centerX.equalTo(self.contentView);
        }];
    }
    
    
  
    
}
- (void)configMineInfoJJBaseCollectionViewCellWithDic:(NSDictionary *)dic arrdata:(NSMutableArray *)arrData indexpath:(NSIndexPath*)index isLast:(BOOL)last
{
    self.veryfiedlabelInfo.hidden =YES;
    
    if (index.row ==5) {
        self.veryfiedlabelInfo .hidden =NO;
        
        if ( [dic[@"status"]isEqualToString:@"1"])
        {
            self.veryfiedlabelInfo.text =@"已填";
            self.veryfiedlabelInfo.backgroundColor =Color_TableViewEmpty_TitleColor;
        }
        else
        {
            self.veryfiedlabelInfo.text =@"选填";
            self.veryfiedlabelInfo.backgroundColor =Color_Button_ActiveColor;
            
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


