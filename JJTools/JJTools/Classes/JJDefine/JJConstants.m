//
//  JJConstants.m
//  JJTools
//
//  Created by Brain on 2018/12/12.
//  Copyright © 2018 Brain. All rights reserved.
//

#import "JJConstants.h"

@implementation JJConstants

//CGFloat    const kPaddingLeft                           = 35.0f;
//
//CGFloat    const kmarginTextField                       = 35.0f;
//
//CGFloat    const kPaddingLeftForpersonal                = 22.0f;
//CGFloat    const kPaddingLeftForpersonalBetweenArrow    =8.0f;
//CGFloat    const kPaddingTop                            = 12.0f;
//CGFloat    const kTextFieldHeight                       = 50.0;
//
//CGFloat    const kTextFieldLeftMargin                   = 35.0f;
//CGFloat    const kButtonHeight                          = 50.0f;
//CGFloat    const kSeparatorHeight                       = 0.5f;
//CGFloat    const kViewTop                               = 15.0f;
//
//
//CGFloat    const kTextFieldLeftViewWidth                = 45.0f;


NSString * const kNotificationNeedLogin                 = @"NotificationNeedLogin";

NSString * const kNotificationFindModuleAction           = @"kNotificationFindModuleAction";
NSString * const kNotificationCloseFindModuleH5          = @"kNotificationCloseFindModuleH5";

NSString * const kNotificationLoginSuccess              = @"NotificationLoginSuccess";
NSString * const kNotificationLoginOut                  = @"NotificationLoginOut";
NSString * const kNotificationPayPwdSetSuccess          = @"NotificationPayPwdSetSuccess";
NSString * const kfindPsdSuccessFromChangePwd           = @"kfindPsdSuccessFromChangePwd";
NSString * const kNotificationMailIdentifySuccess       = @"kNotificationMailIdentifyCommit" ;//邮箱认证提交

NSString * const kNotificationPayPwdChangeSuccess          = @"kNotificationPayPwdChangeSuccess";//修改交易密码成功


//实名认证成功
NSString * const kNotificationNameIdentifySuccess       = @"kNotificationNameIdentifySuccess" ;//实名认证成功
//手机通讯录上传传成功
NSString * const kNotificationUploadContactsSuccess     = @"kNotificationUploadContactsSuccess" ;
//运营商认证上传成功
NSString * const kNotificationOperatorVerifiedSuccess   = @"kNotificationOperatorVerifiedSuccess" ;
//芝麻认证成功
NSString * const kNotificationSesameVeryfiedSuccess     = @"kNotificationSesameVeryfiedSuccess" ;
//银行卡绑定成功
NSString * const kNotificationBindBankSuccess           = @"kNotificationBindBankSuccess" ;//绑卡成功
//验证faceid
NSString * const kNotificationVeryFaceID           = @"kNotificationVeryFaceID" ;//验证faceid

NSString * const kErrorUnknown                          = @"未知错误";


NSString * const kHttpRequestPost                       = @"post";
NSString * const kHttpRequestGet                        = @"get";
NSString * const kHttpRequestPut                        = @"put";

NSString * const kHttpRequestPatch                       = @"patch";

NSString * const kSaltShA1Key                         =@"douyouhnyoupinpassword123!@#qweasdzxc";

NSString * const kLoginDesKey                        = @"6Ta4OaHZdpA=";

NSInteger  const kTextFieldPwdInputMax                = 16;

NSInteger  const kResponseStatusCode                  = 200;


@end
