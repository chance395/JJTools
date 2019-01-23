//
//  JJSystemCall.m
//  JJTools
//
//  Created by Brain on 2018/12/11.
//  Copyright © 2018 Brain. All rights reserved.
//
#import "JJBaseHeader.h"
#import <Photos/Photos.h>
#import "JJSystemCall.h"
#import <CoreLocation/CoreLocation.h>

@interface JJSystemCall()
@property (strong, nonatomic) UIWebView *mainWebView;
@property (nonatomic, strong) void (^noParameterCompletion)(void);
@end

@implementation JJSystemCall

+ (instancetype)sharedApplicationUtil{
    static JJSystemCall *sharedApplicationUtil = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedApplicationUtil = [[JJSystemCall alloc] init];
    });
    return sharedApplicationUtil;
}

//拨打电话
- (void)makeTelephoneCall:(NSString *)telNumber{
    static const NSInteger telTag = 19009527;
    NSString *str = [NSString stringWithFormat:@"tel:%@",telNumber];
    if (!_mainWebView) {
        _mainWebView = [[UIWebView alloc] initWithFrame:CGRectZero];
        _mainWebView.tag = telTag;
    }
    [self.mainWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    UIView *tempView = [SharedApplication.keyWindow viewWithTag:telTag];
    if (tempView) {
        [tempView removeFromSuperview];
    }
    [SharedApplication.keyWindow addSubview:self.mainWebView];
}

//注册push通知
- (void)registerNotification{
    
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes: UIUserNotificationTypeSound
                                                        | UIUserNotificationTypeAlert
                                                        | UIUserNotificationTypeBadge
                                                                                         categories:nil];
    [SharedApplication registerUserNotificationSettings:notificationSettings];
    [[UIApplication sharedApplication] currentUserNotificationSettings];
}

//是否开启了定位服务
- (void)judgeLocationPermissionWithCompletion:(void (^)(void))completion
{
if (completion) {
    _noParameterCompletion = completion;
}
    CLAuthorizationStatus status=[CLLocationManager authorizationStatus];
    if (![CLLocationManager locationServicesEnabled]    ||
        status == kCLAuthorizationStatusRestricted  ||
        status == kCLAuthorizationStatusDenied
        ){
        [self gotoSettings];
    }
    else{
        self.noParameterCompletion();
    }
    
}

/**
 *  跳转到系统设置页面，iOS8之后可用
 */
- (void)gotoSettings{
    
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: UIApplicationOpenSettingsURLString]]) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString: UIApplicationOpenSettingsURLString]];
    }
}

- (void)goItunesToUpdateApp {
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/app/id%@?mt=8", @"1156341826"]]];
}

- (void)judgePhotoPermissionWithCompletion:(void (^)(void))completion
{
    if (completion) {
        _noParameterCompletion = completion;
    }

 
    if (IOSVERSION >11.0) {
        @Weak(self);
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
       @Strong(self);
            if ( status ==PHAuthorizationStatusRestricted ||status == PHAuthorizationStatusDenied  ) {
                [self gotoSettings];

            }
            else{
                dispatch_async(dispatch_get_main_queue(), ^{
                self.noParameterCompletion();
                });
            }
        }];
    }
    else
    {
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusRestricted ||
            status == PHAuthorizationStatusDenied) {

            [self gotoSettings];
        }
        else{
            dispatch_async(dispatch_get_main_queue(), ^{
           self.noParameterCompletion();
            });
        }
    }
}


@end
