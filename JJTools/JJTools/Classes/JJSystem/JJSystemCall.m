//
//  JJSystemCall.m
//  JJTools
//
//  Created by Brain on 2018/12/11.
//  Copyright © 2018 Brain. All rights reserved.
//
#import<WebKit/WebKit.h>
#import <Photos/Photos.h>
#import "JJSystemCall.h"
#import <CoreLocation/CoreLocation.h>
#import <AddressBookUI/ABNewPersonViewController.h>


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
    UIView *tempView = [[UIApplication sharedApplication].keyWindow viewWithTag:telTag];
    if (tempView) {
        [tempView removeFromSuperview];
    }
    [[UIApplication sharedApplication].keyWindow addSubview:self.mainWebView];
}

//注册push通知
- (void)registerNotification{
    
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes: UIUserNotificationTypeSound
                                                        | UIUserNotificationTypeAlert
                                                        | UIUserNotificationTypeBadge
                                                                                         categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
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
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] >11.0) {
        __weak typeof(self)weakSelf =self;
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
       
            if ( status ==PHAuthorizationStatusRestricted ||status == PHAuthorizationStatusDenied  ) {
                [weakSelf gotoSettings];

            }
            else{
                dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.noParameterCompletion();
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


// 判断通讯录是否存在某个联系人
-(void)handleExistContactNameByName:(NSString *)contactName
{
        ABAddressBookRef addBook = nil;
        CFErrorRef error = nil;
        addBook = ABAddressBookCreateWithOptions(NULL, &error);
    
        // 申请权限
        ABAddressBookRequestAccessWithCompletion(addBook, ^(bool granted, CFErrorRef error) {
            if (granted) {
                CFArrayRef allPeople = ABAddressBookCopyArrayOfAllPeople(addBook);
                CFIndex number = ABAddressBookGetPersonCount(addBook);
                for (NSInteger index = 0; index < number; index++) {
                    //获取联系人对象的引用
                    ABRecordRef  people = CFArrayGetValueAtIndex(allPeople, index);
                    //获取当前联系人名字
                    NSString*firstName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty));
                    
                    if ([firstName isEqualToString:contactName]) {
                        ABAddressBookRemoveRecord(addBook, people, nil);
                        ABAddressBookSave(addBook, &error);
                        CFRelease(addBook);
                    }
                }
            }
           
        });
        //等待信号触发
    
    }


//添加到通讯录
- (void)addContactsToAddressWithName:(NSString*)contactName PhonetArr:(NSArray*)phoneArr noteStr:(NSString*)note completion:(void (^)(void))completion {

        if (
            ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
            
            [self createAddBookRecordByPhoneArr:phoneArr contactName:contactName andNote:note];
            if (completion) {
                _noParameterCompletion = completion;
            }
            self.noParameterCompletion();
            
        }
        else
        {
            [self gotoSettings];
            
        }
    }

//想了哈,还是不用ios9后面的框架就用这个.反正要适配ios9以前的警告就警告
- (void)createAddBookRecordByPhoneArr:(NSArray *)phoneArr contactName:(NSString *)contactNameStr andNote:(NSString *)note
{
        CFErrorRef error = NULL;
        if (!phoneArr || !contactNameStr) {return;}
        [self handleExistContactNameByName:contactNameStr];
        ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
        ABRecordRef newRecord = ABPersonCreate();
        
        ABRecordSetValue(newRecord, kABPersonFirstNameProperty, (__bridge CFTypeRef)contactNameStr, &error);
        
        //创建一个多值属性(电话)
        ABMutableMultiValueRef multi = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        
        [phoneArr enumerateObjectsUsingBlock:^(NSString *phone, NSUInteger idx, BOOL * _Nonnull stop) {
            // 添加手机号码
            ABMultiValueAddValueAndLabel(multi, (__bridge CFTypeRef)phone, kABPersonPhoneMobileLabel, NULL);
        }];
        
        ABRecordSetValue(newRecord, kABPersonPhoneProperty, multi, &error);
        
        //添加email
        //    ABMutableMultiValueRef multiEmail = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        //    ABMultiValueAddValueAndLabel(multiEmail, (__bridge CFTypeRef)([self.infoDic objectForKey:@"email"]), kABWorkLabel, NULL);
        //    ABRecordSetValue(newRecord, kABPersonEmailProperty, multiEmail, &error);
        
        // 添加备注
        ABRecordSetValue(newRecord, kABPersonNoteProperty, (__bridge CFTypeRef)note, &error);
        
        //添加记录到通讯录操作对象
        ABAddressBookAddRecord(addressBook, newRecord, &error);
        
        //保存通讯录操作对象
        ABAddressBookSave(addressBook, &error);
        
        CFRelease(multi);
        CFRelease(newRecord);
        CFRelease(addressBook);

}

@end
