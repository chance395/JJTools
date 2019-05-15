//
//  JJMacroDefine.h
//  JJTools
//
//  Created by Brain on 2018/12/11.
//  Copyright © 2018 Brain. All rights reserved.
//

#ifndef JJMacroDefine_h
#define JJMacroDefine_h

//-------------------获取设备大小-------------------------

//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define ViewWidth(v)                                  v.frame.size.width
#define ViewHeight(v)                                 v.frame.size.height
#define ViewX(v)                                      v.frame.origin.x
#define ViewY(v)                                      v.frame.origin.y
#define WIDTHRADIUS                                   SCREEN_WIDTH/375.0
#define WIDTHRADIUS SCREEN_WIDTH/375.0
#define KEY_WINDOW [UIApplication sharedApplication].keyWindow
#define NAVIGATIONBAR_HEIGHT 64.0f
#define TABBAR_HEIGHT 49.0f
#define WIDTHRADIUS                                   SCREEN_WIDTH/375.0
#define Tabbar_Height                                 49
#define Nav_Height                                    64
#define SCREEN_SCALE             SCREEN_WIDTH / 375.f//屏幕宽度比率
//判断机型
#define isIPhone4 CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size)
#define isIPhone5 CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size)
#define isIPhone6 CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size)
#define isIPhone6p CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size)
#define isIPhoneX CGSizeEqualToSize(CGSizeMake(375, 812), [[UIScreen mainScreen] bounds].size)

//-------------------打印日志-------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#   define JJLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define JJLog(...)
#endif

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//获取沙盒 Document
#define SandboxPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

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
#define FONT(F) [UIFont fontWithName:@"PingFangSC-Regular" size:F]
#define normalFont(f) [UIFont systemFontOfSize:f]
#define boldFont(f)  [UIFont boldSystemFontOfSize:f]
//----------------------系统----------------------------


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

//----------------------图片----------------------------

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义UIImage对象

#define ImageNamed(fileName) [UIImage imageNamed:fileName]



//防止崩溃
#define getStringValue(x)                    x==nil?@"":[NSString stringWithFormat:@"%@",x]

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )

//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)

//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)

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

#endif /* JJMacroDefine_h */
