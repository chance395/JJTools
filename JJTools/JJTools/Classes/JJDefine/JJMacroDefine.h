//
//  JJMacroDefine.h
//  JJTools
//
//  Created by Brain on 2018/12/11.
//  Copyright © 2018 Brain. All rights reserved.
//

#ifndef JJMacroDefine_h
#define JJMacroDefine_h

//----------------------颜色类---------------------------
// rgb颜色转换（16进制->10进制）
#define UIColorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define UIColorFromHexWithAlph(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

// 获取RGB颜色
#define RGBAColor(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
//------------------------字体类--------------------------
#define FontSystem(f)                               [UIFont systemFontOfSize:f]
#define FontBoldSystem(f)                           [UIFont boldSystemFontOfSize:f]
//简体字体定义
#define FONT(F)                                     [UIFont fontWithName:@"PingFangSC-Regular" size:F]



//----------------------系统----------------------------
//主要单例
#define UserDefaults                                [NSUserDefaults standardUserDefaults]
//will return a object
#define UserDefaultsGetter(key)\
^(){\
return [UserDefaults   objectForKey:key];\
}()

#define UserDefaultsSetter(object,key)\
^(){\
NSCAssert(object != nil, @"object can not be nil");\
[UserDefaults  setObject:object forKey:key];\
[UserDefaults synchronize];\
}()

#define NotificationCenter                          [NSNotificationCenter defaultCenter]
#define SharedApplication                           [UIApplication sharedApplication]
#define Bundle                                      [NSBundle mainBundle]
#define MainScreen                                  [UIScreen mainScreen]

//Application delegate
#define ApplicationDelegate                         ((AppDelegate *)[[UIApplication sharedApplication] delegate])

//定义UIImage对象

#define ImageNamed(fileName) [UIImage imageNamed:fileName]



//获取系统版本
#define IOSVERSION                                   [[[UIDevice currentDevice] systemVersion] floatValue]

//当前应用的版本号
#define AppVersion                        [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]


//获取应用名称
#define APP_NAME                          [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]



//防止崩溃
#define getStringValue(x)                    x==nil?@"":[NSString stringWithFormat:@"%@",x]


//-------------------Weak & Strong----------------------

#define Weak(obj) autoreleasepool{} __weak typeof(obj) w##obj = obj;
#define Strong(obj) autoreleasepool{} __strong typeof(obj) obj = w##obj;//配套上面的方法使用


#endif /* JJMacroDefine_h */
