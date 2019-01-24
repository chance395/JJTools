//
//  JJUserManager.h
//  JJTools
//
//  Created by Brain on 2018/12/13.
//  Copyright © 2018 Brain. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJUserManager : NSObject

+ (JJUserManager*)sharedUserManager;

//判断用户是否登录，没登陆会弹出登录按钮
- (BOOL)checkLogin:(UIViewController *)viewController;

//是否已经登录
- (BOOL)isLogin;

//弹出登录页面
- (void)showLoginPage:(UIViewController *)viewController;

- (void)showLoginSecondPage:(UIViewController *)viewController;
//退出登录
- (void)logout;

@end

NS_ASSUME_NONNULL_END
