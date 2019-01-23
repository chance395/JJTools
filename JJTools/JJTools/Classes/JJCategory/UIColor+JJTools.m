//
//  UIColor+JJTools.m
//  qhg_ios
//
//  Created by Brain on 2018/9/17.
//  Copyright © 2018 In-next. All rights reserved.
//

#import "UIColor+JJTools.h"

@implementation UIColor (JJTools)

+(UIColor *)JJRandomColor
{
    CGFloat r=arc4random_uniform(256);
    CGFloat g=arc4random_uniform(256);
    CGFloat b=arc4random_uniform(256);
    
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1];
}

+(UIColor *)JJColorWithHexStr:(NSString *)hexColor alpha:(CGFloat)alpha
{
    //先移除前缀
    NSString *colorStr = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([colorStr hasPrefix:@"0X"]||[colorStr hasPrefix:@"0x"]) {
        colorStr=[colorStr substringFromIndex:2];//从第三个字符开始取
    }
    else if ([colorStr hasPrefix:@"#"]) {
        colorStr=[colorStr substringFromIndex:1];//去掉＃从第二个开始
    }
    else{
        return [UIColor clearColor] ;
    }
    
    //判断
    if (colorStr.length !=6) {
        return [UIColor clearColor];//格式不对，返回
    }
    
    else{
        //提取值
        NSRange range;
        range.length=2;
        //r
        range.location=0;
        NSString*rStr=[colorStr substringWithRange:range];
        //g
        range.location=2;
        NSString*gStr=[colorStr substringWithRange:range];
        //b
        range.location=4;
        NSString*bStr=[colorStr substringWithRange:range];
        //转换成rgb
        unsigned int r,g,b;
        [[NSScanner scannerWithString:rStr]scanHexInt:&r];
        [[NSScanner scannerWithString:gStr]scanHexInt:&g];
        [[NSScanner scannerWithString:bStr]scanHexInt:&b];
        
        return [UIColor colorWithRed:r/255.5f green:g/255.5f blue:b/255.5f alpha:alpha];
        
    }
}

+(UIColor *)JJColorWithHexStr:(NSString *)hexColor
{
    return [UIColor JJColorWithHexStr:hexColor alpha:1.0];
    
}
+(UIColor *)JJColorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b alpha:(CGFloat)alpha{
    
    return [UIColor colorWithRed:r/255.0f green:g/255.0f  blue:b/255.0f alpha:alpha];
    
}

@end
