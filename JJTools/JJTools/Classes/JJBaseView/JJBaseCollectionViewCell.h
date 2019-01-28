//
//  JJBaseCollectionViewCell.h
//  qhg_ios
//
//  Created by Brain on 2018/9/20.
//  Copyright © 2018 In-next. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJBaseCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *topImage;

@property (strong, nonatomic) UILabel *botlabel;

@property (strong, nonatomic) UILabel *   veryfiedlabel;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)configJJBaseCollectionViewCellWithDic:(NSDictionary *)dic arrdata:(NSMutableArray *)arrData indexPath:(NSIndexPath *)indexPath;

@end

@interface JJMineInfoCollectionCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *topImageInfo;

@property (strong, nonatomic) UILabel *botlabelInfo;

@property (strong, nonatomic) UILabel *   veryfiedlabelInfo;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)configMineInfoJJBaseCollectionViewCellWithDic:(NSDictionary *)dic arrdata:(NSMutableArray *)arrData indexpath:(NSIndexPath*)index ;

@end


