//
//  JJBaseHeaderFooterView.h
//  qhg_ios
//
//  Created by Brain on 2018/9/14.
//  Copyright © 2018 In-next. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJBaseTableViewHeaderFooterView : UITableViewHeaderFooterView

@property (nonatomic,strong) UILabel     *headerLabel;
+ (JJBaseTableViewHeaderFooterView *)getHeaderFooterViewWithTableView:(UITableView *)tableView;

@end


@interface JJDetailOrderHeaderView : UITableViewHeaderFooterView

@property (nonatomic,strong) UIView     *vcontentView;
@property (nonatomic,strong) UILabel     *headerLabel;
@property (nonatomic,strong) UILabel     *detailProcessLabel;
@property (nonatomic,strong) UIButton     *arrowBtn;
@property (nonatomic,strong) UIView       *underLineView2;

+ (JJDetailOrderHeaderView *)getHeaderFooterViewWithTableView:(UITableView *)tableView dataArray:(NSMutableArray*)arr;

@end

@interface JJWechatVerifyHeaderView : UITableViewHeaderFooterView


@property (nonatomic,strong) UILabel     *titleLabel;
@property (nonatomic,strong) UILabel     *subTitleLabel;

+ (JJWechatVerifyHeaderView *)getHeaderFooterViewWithTableView:(UITableView *)tableView;

@end
