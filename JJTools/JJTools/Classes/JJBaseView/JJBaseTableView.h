//
//  JJBaseTableView.h
//  qhg_ios
//
//  Created by Brain on 2018/9/10.
//  Copyright © 2018 In-next. All rights reserved.
//

#import <UIKit/UIKit.h>
#import"Masonry.h"

@interface JJBaseTableView : UITableView

@property(nonatomic,assign) CGFloat   verticalOffset;

@property (nonatomic, getter=isLoading) BOOL loading;

@property (nonatomic,copy  ) NSString    *emptyTitle;

@property (nonatomic,copy  ) NSString    *emptyDescription;

@property (nonatomic,copy  ) NSString    *emptyImageName;

@end
