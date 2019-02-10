//
//  JJBaseTableView.h
//  qhg_ios
//
//  Created by Brain on 2018/9/10.
//  Copyright © 2018 In-next. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JJBaseTableView ;
@protocol TableViewRefreshBtnDidClickDeleagate <NSObject>

@required

-(void)tabelViewRefreshBtnDidClicked:(JJBaseTableView*)tableView;

@end

@interface JJBaseTableView : UITableView

@property(nonatomic,assign) CGFloat   verticalOffset;

@property (nonatomic, getter=isLoading) BOOL loading;

@property (nonatomic,copy  ) NSString    *emptyTitle;

@property (nonatomic,copy  ) NSString    *emptySubtitle;

@property (nonatomic,copy  ) NSString    *emptyImageName;

@property (nonatomic,strong) NSString    *emptyButtonTitle;

@property (nonatomic,strong) UIColor     *emptyButtonColor;

@property (nonatomic,strong) NSString    *emptyButtonImageStr;

@property (nonatomic,strong) UIView      *emptyCustomView;



@property (nonatomic,weak) id <TableViewRefreshBtnDidClickDeleagate> refreshDelegate ;

@end

