//
//  JJBaseCollectionReusableView.h
//  JJTools
//
//  Created by Brain on 2019/1/29.
//  Copyright © 2019 Brain. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJBaseCollectionReusableView : UICollectionReusableView

//这里面不能用tableViewCell那种模式两种初始化顺序不一样必须使用init方法
- (instancetype)initWithFrame:(CGRect)frame;
- (void)configTitleWith:(NSDictionary*)dic;

@end

NS_ASSUME_NONNULL_END
