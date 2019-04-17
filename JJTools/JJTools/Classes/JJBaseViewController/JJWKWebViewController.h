//
//  JJWKWebViewController.h
//  WKWebViewDemo
//
//  Created by Brain on 2019/3/10.
//  Copyright © 2019 justinjing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJWKWebViewController :UIViewController

@property (nonatomic,assign,getter=isHideNav) BOOL    HideNav;

@property (nonatomic,strong) NSString *absUrlStr;

@property (nonatomic,strong) UIColor *progressTintColor;

@property (nonatomic,assign,getter=isHideBottom) BOOL  HideBottom;

@property (nonatomic,assign,getter=isHideLeftItems) BOOL  HideLeftItems;

@property (nonatomic,assign,getter=isCancelSuspension) BOOL CancelSuspension;

@end

NS_ASSUME_NONNULL_END
