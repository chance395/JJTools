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

@property (nonatomic,assign,getter=isShowNav) BOOL    ShowNav;

@property (nonatomic,strong) NSString *absUrlStr;

@property (nonatomic,strong) UIColor *progressTintColor;

@property (nonatomic,assign,getter=isShowBottom) BOOL  ShowBottom;

@property (nonatomic,assign,getter=isShowLeftItems) BOOL  ShowLeftItems;

@property (nonatomic,assign,getter=isSuspension) BOOL Suspension;

@end

NS_ASSUME_NONNULL_END
