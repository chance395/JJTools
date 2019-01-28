//
//  JJUserManager.m
//  JJTools
//
//  Created by Brain on 2018/12/13.
//  Copyright © 2018 Brain. All rights reserved.
//
#import <objc/runtime.h>
#import "JJTool.h"
#import "JJMacroDefine.h"
#import "JJUserManager.h"
#import "JJBaseLoginFirstViewController.h"
#import "JJBaseLoginSecondViewController.h"
#import "JJBaseNavigationViewController.h"

@implementation JJUserManager

+ (JJUserManager*)sharedUserManager{
    static JJUserManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[JJUserManager alloc] init];
    });
    return manager;
}

- (void)encodeWithCoder:(NSCoder *)aCoder{
    unsigned int count = 0;
    Ivar *vars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        Ivar ivar = vars[i];
        const char *name = ivar_getName(ivar);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        [aCoder encodeObject:value forKey:key];
    }
    free(vars);
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    unsigned int count = 0;
    if (self = [super init]) {
        Ivar *vars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            Ivar var = vars[i];
            const char *name = ivar_getName(var);
            //归档
            NSString *key = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:key];
            [self setValue:value forKey:key];
        }
        free(vars);
    }
    return self;
}

- (BOOL)checkLogin:(UIViewController *)viewController{
    NSString *token = getStringValue([UserDefaults objectForKey:@"token"]);
    if (token.length == 0) {
        if (![[JJTool getTopViewController] isKindOfClass:[JJBaseLoginFirstViewController   class]]){
            JJBaseLoginFirstViewController *vcLogin = [[JJBaseLoginFirstViewController alloc] init];
            JJBaseNavigationViewController *vcNavigation = [[JJBaseNavigationViewController alloc] initWithRootViewController:vcLogin];
            [viewController presentViewController:vcNavigation animated:YES completion:nil];
        }
        return NO;
    }
    return YES;
}

- (BOOL)isLogin{
    NSString *token = getStringValue([UserDefaults objectForKey:@"token"]);
    if (token.length > 0) {
        return YES;
    }
    return NO;
}

- (void)showLoginPage:(UIViewController *)viewController{
    if (![[JJTool getTopViewController] isKindOfClass:[JJBaseLoginFirstViewController   class]]){
        JJBaseLoginFirstViewController *vcLogin = [[JJBaseLoginFirstViewController alloc] init];
        JJBaseNavigationViewController *vcNavigation = [[JJBaseNavigationViewController alloc] initWithRootViewController:vcLogin];
        [viewController presentViewController:vcNavigation animated:YES completion:nil];
        
    }
}

- (void)showLoginSecondPage:(UIViewController *)viewController{
    if (![[JJTool getTopViewController] isKindOfClass:[JJBaseLoginFirstViewController   class]]){
        JJBaseLoginSecondViewController*vcLogin = [[JJBaseLoginSecondViewController alloc] init];
        JJBaseNavigationViewController *vcNavigation = [[JJBaseNavigationViewController alloc] initWithRootViewController:vcLogin];
        [viewController presentViewController:vcNavigation animated:YES completion:nil];
        
    }
}

//退出登录
- (void)logout{
    
    //存本地
    [UserDefaults setObject:@"" forKey:@"realNameStatus"];//实名认证状态 2表示认证通过 其它为否 ,
    [UserDefaults setObject:@"" forKey:@"userBankStatus"];//银行卡认证状态 2表示认证通过 其它为否 ,
    
    [UserDefaults setObject:@""  forKey:@"token"];
    
    [UserDefaults setObject:@"" forKey:@"idNum"];
    [UserDefaults setObject:@"" forKey:@"userName"];
    
    
//    [UserDefaults setObject:@{} forKey:USER_MANAGER];
    
    //清空认证状态信息
    [UserDefaults setObject:@"" forKey:@"isCard"];
    [UserDefaults setObject:@"" forKey:@"isVerified"];
    [UserDefaults setObject:@"" forKey:@"isPhone"];
    [UserDefaults setObject:@"" forKey:@"isOperator"];
    [UserDefaults setObject:@"" forKey:@"lockChain"];
    
    [UserDefaults setObject:@"" forKey:@"versionhome"];
    
    [UserDefaults synchronize];
}






@end
