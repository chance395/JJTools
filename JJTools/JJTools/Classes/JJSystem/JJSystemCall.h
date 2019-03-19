//
//  JJSystemCall.h
//  JJTools
//
//  Created by Brain on 2018/12/11.
//  Copyright © 2018 Brain. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJSystemCall : NSObject

+ (instancetype)sharedApplicationUtil;
/**
 *  拨打电话
 *
 *  @param telNumber 电话号码
 */
- (void)makeTelephoneCall:(NSString *)telNumber;

/**
 *  注册push通知
 */
- (void)registerNotification;


/**
 判断是否开启了定位如果没有就去设置搞

 @param completion block
 */
- (void)judgeLocationPermissionWithCompletion:(void (^)(void))completion;


/**
 判断是否有使用相册的权限没有就去设置

 @param completion block
 */
- (void)judgePhotoPermissionWithCompletion:(void (^)(void))completion;


/**
 添加号码到通讯录

 @param contactName 联系人名字
 @param phoneArr 手机号码
 @param note 备注
 @param completion block
 */
- (void)addContactsToAddressWithName:(NSString*)contactName PhonetArr:(NSArray*)phoneArr noteStr:(NSString*)note completion:(void (^)(void))completion ;

/**
 *  跳转到系统设置页面，iOS8之后可用
 */
- (void)gotoSettings;


/**
 跳转appstore
 */
- (void)goItunesToUpdateApp;

@end

NS_ASSUME_NONNULL_END
