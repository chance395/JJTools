//
//  JJConstants.h
//  JJTools
//
//  Created by Brain on 2018/12/12.
//  Copyright © 2018 Brain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface JJConstants : NSObject

////侧边距
//extern CGFloat    const kPaddingLeft;
//
////personalInfo的侧边距
//
//extern CGFloat    const kPaddingLeftForpersonal;
//
//extern CGFloat    const kPaddingLeftForpersonalBetweenArrow;
//
////上边距
//extern CGFloat    const kPaddingTop;
////textfield 高度
//extern CGFloat    const kTextFieldHeight;
////按钮高度
//extern CGFloat    const kButtonHeight;
////分割线高度
//extern CGFloat    const kSeparatorHeight;
////view距顶部距离
//extern CGFloat    const kViewTop;
//
////textfield 左view宽度
//extern CGFloat    const kTextFieldLeftViewWidth;
//
////textfield 左间距
//extern CGFloat    const kTextFieldLeftMargin;

//通知
extern NSString * const kNotificationNeedLogin;         //需要用户登录
extern NSString * const kNotificationFindModuleAction;     //发现模块
extern NSString * const kNotificationCloseFindModuleH5;

extern NSString * const kNotificationLoginSuccess    ;//登录成功
extern NSString * const kNotificationLoginOut;//登录失败
extern NSString * const kNotificationMailIdentifySuccess;//邮箱认证提交
extern NSString * const kNotificationPayPwdSetSuccess;//交易密码设置成功
extern NSString * const kfindPsdSuccessFromChangePwd;
extern NSString * const kNotificationPayPwdChangeSuccess ;
//实名认证成功
extern NSString * const kNotificationNameIdentifySuccess      ;//实名认证成功
//手机通讯录上传传成功
extern NSString * const kNotificationUploadContactsSuccess    ;
//运营商认证上传成功
extern NSString * const kNotificationOperatorVerifiedSuccess   ;
//芝麻认证成功
extern NSString * const kNotificationSesameVeryfiedSuccess     ;
//银行卡绑定成功
extern NSString * const kNotificationBindBankSuccess        ;//绑卡成功
//验证faceid
extern NSString * const kNotificationVeryFaceID;
//错误描述
extern NSString * const kErrorUnknown;

//http请求方式
extern NSString * const kHttpRequestPost;
extern NSString * const kHttpRequestGet;
extern NSString * const kHttpRequestPatch;
extern NSString * const kHttpRequestPut;
//加密秘钥
extern NSString * const kLoginDesKey;

//盐值加密秘钥
extern NSString * const kSaltShA1Key;

extern NSString * const kLoginDesKey;

extern NSInteger  const kTextFieldPwdInputMax;

extern NSInteger  const kResponseStatusCode;

@end

NS_ASSUME_NONNULL_END
