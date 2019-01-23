//
//  UIDevice+JJDevice.m
//  qhg_ios
//
//  Created by Brain on 2018/11/27.
//  Copyright © 2018 In-next. All rights reserved.
//

#import "UIDevice+JJDevice.h"
#import <Foundation/Foundation.h>
#include <sys/utsname.h>
@implementation UIDevice (JJDevice)

- (NSString *)machineModel{
    static NSString *model;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        struct utsname systemInfo;
        uname(&systemInfo);
        model = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    });
  
    return model;
}

- (NSString *)machineModelName{
    static NSString *machineModelName;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *model = [self machineModel];
        if (!model) return ;
        NSDictionary *machineModels = @{
                                        //Apple TV
                                        @"AppleTV2,1" : @"Apple TV 2",
                                        @"AppleTV3,1" : @"Apple TV 3",
                                        @"AppleTV3,2" : @"Apple TV 3",
                                        @"AppleTV5,3" : @"Apple TV 4",
                                        @"AppleTV6,2" : @"Apple TV 4K",
                                        
                                        //Apple Watch
                                        @"Watch1,1" : @"Apple Watch 38mm",
                                        @"Watch1,2" : @"Apple Watch 42mm",
                                        @"Watch2,6" : @"Apple Watch Series 1 38mm",
                                        @"Watch2,7" : @"Apple Watch Series 1 42mm",
                                        @"Watch2,3" : @"Apple Watch Series 2 38mm",
                                        @"Watch2,4" : @"Apple Watch Series 2 42mm",
                                        @"Watch3,1" : @"Apple Watch Series 3 38mm",
                                        @"Watch3,2" : @"Apple Watch Series 3 42mm",
                                        @"Watch3,3" : @"Apple Watch Series 3 38mm",
                                        @"Watch3,4" : @"Apple Watch Series 3 42mm",
                                        
                                        //iPad
                                        @"iPad1,1" : @"iPad",
                                        @"iPad2,1" : @"iPad 2 (WiFi)",
                                        @"iPad2,2" : @"iPad 2 (GSM)",
                                        @"iPad2,3" : @"iPad 2 (CDMA)",
                                        @"iPad2,4" : @"iPad 2",
                                        @"iPad2,5" : @"iPad mini (WiFi)",
                                        @"iPad2,6" : @"iPad mini (4G)",
                                        @"iPad2,7" : @"iPad mini (CDMA EV-DO)",
                                        @"iPad3,1" : @"iPad 3 (WiFi)",
                                        @"iPad3,2" : @"iPad 3 (CDMA)",
                                        @"iPad3,3" : @"iPad 3 (4G)",
                                        @"iPad3,4" : @"iPad 4 (WiFi)",
                                        @"iPad3,5" : @"iPad 4 (CDMA)",
                                        @"iPad3,6" : @"iPad 4 (4G)",
                                        @"iPad4,1" : @"iPad Air (WiFi)",
                                        @"iPad4,2" : @"iPad Air (4G)",
                                        @"iPad4,3" : @"iPad Air (4G)",
                                        @"iPad4,4" : @"iPad mini 2 (WiFi)",
                                        @"iPad4,5" : @"iPad mini 2 (4G)",
                                        @"iPad4,6" : @"iPad mini 2 (CDMA EV-DO)",
                                        @"iPad4,7" : @"iPad mini 3 (WiFi)",
                                        @"iPad4,8" : @"iPad mini 3 (4G)",
                                        @"iPad4,9" : @"iPad mini 3 (4G)",
                                        @"iPad5,1" : @"iPad mini 4 (WiFi)",
                                        @"iPad5,2" : @"iPad mini 4 (4G)",
                                        @"iPad5,3" : @"iPad Air 2 (WiFi)",
                                        @"iPad5,4" : @"iPad Air 2 (4G)",
                                        @"iPad6,3" : @"iPad Pro (9.7-inch-WiFi)",
                                        @"iPad6,4" : @"iPad Pro (9.7-inch-4G)",
                                        @"iPad6,7" : @"iPad Pro (12.9-inch-WiFi)",
                                        @"iPad6,8" : @"iPad Pro (12.9-inch-4G)",
                                        @"iPad6,11" : @"iPad 5 (WiFi)",
                                        @"iPad6,12" : @"iPad 5 (4G)",
                                        @"iPad7,1" : @"iPad Pro 2 (12.9-inch-WiFi)",
                                        @"iPad7,2" : @"iPad Pro 2 (12.9-inch-4G)",
                                        @"iPad7,3" : @"iPad Pro (10.5-inch-WiFi)",
                                        @"iPad7,4" : @"iPad Pro (10.5-inch-4G)",
                                        @"iPad7,5" : @"iPad 6 (WiFi)",
                                        @"iPad7,6" : @"iPad 6 (4G)",
                                        
                                        //iPhone
                                        @"iPhone1,1" : @"iPhone",
                                        @"iPhone1,2" : @"iPhone 3G",
                                        @"iPhone2,1" : @"iPhone 3GS",
                                        @"iPhone3,1" : @"iPhone 4",
                                        @"iPhone3,2" : @"iPhone 4",
                                        @"iPhone3,3" : @"iPhone 4",
                                        @"iPhone4,1" : @"iPhone 4S",
                                        @"iPhone5,1" : @"iPhone 5",
                                        @"iPhone5,2" : @"iPhone 5",
                                        @"iPhone5,3" : @"iPhone 5c",
                                        @"iPhone5,4" : @"iPhone 5c",
                                        @"iPhone6,1" : @"iPhone 5s",
                                        @"iPhone6,2" : @"iPhone 5s",
                                        @"iPhone7,2" : @"iPhone 6",
                                        @"iPhone7,1" : @"iPhone 6 Plus",
                                        @"iPhone8,1" : @"iPhone 6s",
                                        @"iPhone8,2" : @"iPhone 6s Plus",
                                        @"iPhone8,4" : @"iPhone SE",
                                        @"iPhone9,1" : @"iPhone 7",
                                        @"iPhone9,3" : @"iPhone 7",
                                        @"iPhone9,2" : @"iPhone 7 Plus",
                                        @"iPhone9,4" : @"iPhone 7 Plus",
                                        @"iPhone10,1" : @"iPhone 8",
                                        @"iPhone10,4" : @"iPhone 8",
                                        @"iPhone10,2" : @"iPhone 8 Plus",
                                        @"iPhone10,5" : @"iPhone 8 Plus",
                                        @"iPhone10,3" : @"iPhone X",
                                        @"iPhone10,6" : @"iPhone X",
                                        @"iPhone11,2" : @"iPhone XS",
                                        @"iPhone11,4" : @"iPhone XS Max",
                                        @"iPhone11,6" : @"iPhone XS Max",
                                        @"iPhone11,8" : @"iPhone XR",
                                        
                                        //iPod touch
                                        @"iPod1,1" : @"iPod touch",
                                        @"iPod2,1" : @"iPod touch 2",
                                        @"iPod3,1" : @"iPod touch 3",
                                        @"iPod4,1" : @"iPod touch 4",
                                        @"iPod5,1" : @"iPod touch 5",
                                        @"iPod7,1" : @"iPod touch 6",
                                        
                                        //Simulator
                                        @"i386" : @"Simulator x86",
                                        @"x86_64" : @"Simulator x64",
                                        };
        machineModelName = machineModels[model];
        if (!machineModelName) machineModelName = model;
    });
    return machineModelName;
}

@end
