//
//  JJBaseTableViewCell.h
//  qhg_ios
//
//  Created by Brain on 2018/9/9.
//  Copyright © 2018 In-next. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JJColorDefine.h"
#import "Masonry.h"

typedef NS_ENUM (NSInteger,JJTableViewCellCustomAccessoryType)
{
    TableViewCellCustomAccessoryTypeNone =0,
    TableViewCellCustomAccessoryTypeDisclosureIndicator =1,
};

typedef void(^JJBaseTableViecCellSeparatorLineLayoutBlock)(UIView*topLine,UIView*bottomLine,BOOL isLastLineInSection);

@interface JJBaseTableViewCell : UITableViewCell

+ (JJBaseTableViewCell *)getCellWithTableView:(UITableView *)tableView;
- (void)configJJBaseTableViewCellWithDic:(NSDictionary *)dic arrdata:(NSMutableArray *)arrData indexPath:(NSIndexPath *)indexPath;
- (void)setupSubViews;

@property (nonatomic, strong) NSIndexPath * indexPath;

@property (nonatomic, strong) UILabel * customTextLabel;
@property (nonatomic, strong) UILabel * customDetailTextLabel;

@property (nonatomic, assign) JJTableViewCellCustomAccessoryType customAccessoryType;

@property (nonatomic, strong) UIView * customAccessoryView;

/*
 *  For SATableViewCellCustomAccessoryTypeDisclosureIndicator action
 */
@property (nonatomic, copy) void (^disclosureIndicatorButtonDidPress)(JJBaseTableViewCell * aCell);

@property (nonatomic, assign) BOOL  showCustomSeparatorLine; // Default YES

@property (nonatomic, copy) JJBaseTableViecCellSeparatorLineLayoutBlock  separatorLineLayoutBlock;

@end
