//
//  JJBaseTableView+MasonryLayout.m
//  AFNetworking
//
//  Created by Brian on 2019/5/20.
//

#import "JJBaseTableView+MasonryLayout.h"

@implementation JJBaseTableView (MasonryLayout)
/**
 返回tableView
 
 @param style UITableViewStyle
 @param superView superView
 @param block block
 @return tablView
 */
+ (JJBaseTableView *)MaGetTableViewModelWithTableViewStyle:(UITableViewStyle)style SuperView:(UIView*)superView MasonrySet:(void(^)(JJBaseTableView *currentTableView,MASConstraintMaker*make))block
{
    JJBaseTableView * tab =[[JJBaseTableView alloc]initWithFrame:CGRectZero style:style];
    tab.separatorStyle =UITableViewCellSeparatorStyleNone;
    [superView addSubview:tab];
    [tab mas_makeConstraints:^(MASConstraintMaker *make) {
        if (block) {
            block(tab,make);
        }
    }];
    
    return tab;
}

@end
