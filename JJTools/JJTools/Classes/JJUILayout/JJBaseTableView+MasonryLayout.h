//
//  JJBaseTableView+MasonryLayout.h
//  AFNetworking
//
//  Created by Brian on 2019/5/20.
//

#import "JJBaseTableView.h"
#import"Masonry.h"
NS_ASSUME_NONNULL_BEGIN

@interface JJBaseTableView (MasonryLayout)
/**
 返回tableView
 
 @param style UITableViewStyle
 @param superView superView
 @param block block
 @return tablView
 */
+ (JJBaseTableView *)MaGetTableViewModelWithTableViewStyle:(UITableViewStyle)style SuperView:(UIView*)superView MasonrySet:(void(^)(JJBaseTableView *currentTableView,MASConstraintMaker*make))block;
@end

NS_ASSUME_NONNULL_END
