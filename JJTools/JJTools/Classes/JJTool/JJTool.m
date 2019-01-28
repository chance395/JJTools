//
//  JJTool.m
//  JJTools
//
//  Created by Brain on 2018/12/13.
//  Copyright © 2018 Brain. All rights reserved.
//
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>
#import "JJTool.h"


@implementation JJTool

+ (UIViewController *)getTopViewController{
    
    return [JJTool getTopViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController*)getTopViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]])
    {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [JJTool getTopViewControllerWithRootViewController:tabBarController.selectedViewController];
        
    } else if ([rootViewController isKindOfClass:[UINavigationController class]])
    {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [JJTool getTopViewControllerWithRootViewController:navigationController.visibleViewController];
        
    } else if (rootViewController.presentedViewController)
    {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [JJTool getTopViewControllerWithRootViewController:presentedViewController];
        
    } else
    {
        return rootViewController;
    }
}

+ (NSString*)getCurrentTimestamp
{
    NSDate *datenow = [NSDate date];
    NSTimeInterval time=[datenow timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

+ (NSString *)getDateTimeFromTimestamp:(NSString*) Timestamp
{
    NSTimeInterval time=[Timestamp doubleValue]/1000;//传入的时间戳str如果是精确到毫秒的记得要/1000
    NSDate *detailDate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; //实例化一个NSDateFormatter对象
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss SS"];
    NSString *currentDateStr = [dateFormatter stringFromDate: detailDate];
    return currentDateStr;
}

- (NSString *)getTimeStrWithString:(NSString *)str{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];// 创建一个时间格式化对象
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; //设定时间的格式
    NSDate *tempDate = [dateFormatter dateFromString:str];//将字符串转换为时间对象
    NSString *timeStr = [NSString stringWithFormat:@"%ld", (long)[tempDate timeIntervalSince1970]*1000];//字符串转成时间戳,精确到毫秒*1000
    return timeStr;
}

+ (BOOL)saveImageWithName:(NSString*)imageName andImage:(UIImage*)image{
    if (imageName && [imageName isKindOfClass:[NSString class]] && imageName.length > 0 && image && [image isKindOfClass:[UIImage class]]) {
        NSData* imageData = UIImageJPEGRepresentation(image,0.5);
        //获取Library/Caches目录
        NSString *imagePath = [JJTool generateImagePathwithName:imageName];
        [imageData writeToFile:imagePath atomically:NO];
        return YES;
    }
    return NO;
}


+ (UIImage*)loadImageWithName:(NSString*)imageName{
    NSString *imagePath = [JJTool generateImagePathwithName:imageName];
    UIImage *reslutImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL fileURLWithPath:imagePath]]];
    return reslutImage;
}


+ (void)deleteImageWithName:(NSString*)imageName{
    NSString *imagePath = [JJTool generateImagePathwithName:imageName];
    if ([[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
    }
}

+ (NSString*)generateImagePathwithName:(NSString*)imageName{
    if (imageName && [imageName isKindOfClass:[NSString class]] && imageName.length > 0){
        NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) lastObject];
        NSString *imagePathTemp = [cachesPath stringByAppendingPathComponent:@"Meixiangshenghuo"];
        NSError *error = nil;
        if (![[NSFileManager defaultManager] fileExistsAtPath:imagePathTemp]){
            [[NSFileManager defaultManager] createDirectoryAtPath:imagePathTemp withIntermediateDirectories:NO attributes:nil error:&error];
        }
        NSString *imagePath = [imagePathTemp stringByAppendingPathComponent:imageName];
        return imagePath;
    }else{
        return @"";
    }
}

+ (void)clearLocalImageCache{
    NSString *cachesPath =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask, YES) lastObject];
    NSString *imagePathTemp = [cachesPath stringByAppendingPathComponent:@"Meixiangshenghuo"];
    NSError *error = nil;
    for (NSString *file in [[NSFileManager defaultManager] contentsOfDirectoryAtPath:imagePathTemp error:&error]) {
        [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@%@", imagePathTemp, file] error:&error];
    }
}

+ (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth {
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetHeight = (targetWidth / width) * height;
    UIGraphicsBeginImageContext(CGSizeMake(targetWidth, targetHeight));
    [sourceImage drawInRect:CGRectMake(0, 0, targetWidth, targetHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)compressImage:(UIImage *)image toTargetsize:(float)size{
    UIImage *img1 = [JJTool compressImage:image toTargetWidth:image.size.width/2];
    NSData *data = UIImageJPEGRepresentation(img1, 0.5);
    if(data.length >= size*1024) {
        [self compressImage:img1 toTargetsize:size];
    }
    return img1;
}

+ (void)changeStringLabel:(UILabel *)lbl withColor:(UIColor *)color font:(UIFont *)font withRange:(NSRange)range{
    
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:lbl.text];
    
    [attString addAttribute:NSFontAttributeName value:font range:range];
    [attString addAttribute:NSForegroundColorAttributeName value:color range:range];
    
    [lbl setAttributedText:attString];
    
}
+(BOOL)textField:(UITextField *) textField withLength:(NSInteger)theMaxLength shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    
    return newLength <= theMaxLength || returnKey;
}
+(NSString *)calculateMoney:(NSString *)money{
    
    if ([money floatValue] == 0) {
        
        return money;
    }
    return  [NSString stringWithFormat:@"%0.2f",[money floatValue]/100.0];
}
+(NSString *)CutOutTime:(NSString *)time{
    
    if (time.length > 11) {
        time = [time substringToIndex:10];
    }
    return time;
}
//iOS开发中获取MAC地址方法
- (NSString *)getMacAddress {
//    int mib[6];
//    size_t len;
//    char *buf;
//    unsigned char *ptr;
//    struct if_msghdr *ifm;
//    struct sockaddr_dl *sdl;
//
//    mib[0] = CTL_NET;
//    mib[1] = AF_ROUTE;
//    mib[2] = 0;
//    mib[3] = AF_LINK;
//    mib[4] = NET_RT_IFLIST;
//
//    if ((mib[5] = if_nametoindex("en0")) == 0) {
//        printf("Error: if_nametoindex error/n");
//        return NULL;
//    }
//
//    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
//        printf("Error: sysctl, take 1/n");
//        return NULL;
//    }
//
//    if ((buf = malloc(len)) == NULL) {
//        printf("Could not allocate memory. error!/n");
//        return NULL;
//    }
//
//    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
//        free(buf);
//        printf("Error: sysctl, take 2");
//        return NULL;
//    }
//
//    ifm = (struct if_msghdr *)buf;
//    sdl = (struct sockaddr_dl *)(ifm + 1);
//    ptr = (unsigned char *)LLADDR(sdl);
//
//    // MAC地址带冒号
//    //     NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2),
//    //     *(ptr+3), *(ptr+4), *(ptr+5)];
//
//    // MAC地址不带冒号
//    NSString *outstring = [NSString
//                           stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr + 1), *(ptr + 2), *(ptr + 3), *(ptr + 4), *(ptr + 5)];
//
//    free(buf);
//
//    return [outstring uppercaseString];
    return nil;
}

/*
 
 * 判断用户输入的密码是否符合规范，符合规范的密码要求：
 1. 长度大于6位
 2. 密码中必须同时包含数字和字母
 
 */

+(BOOL)judgePassWordLegal:(NSString *)pass{
    BOOL result = false;
    if ([pass length] >= 6&& [pass length] <= 20){
        // 判断长度大于6位后再接着判断是否同时包含数字和字符
        
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
 
    return result;
}
//线程相关


@end
