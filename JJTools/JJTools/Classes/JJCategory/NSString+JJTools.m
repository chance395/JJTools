//
//  NSString+JJTools.m
//  qhg_ios
//
//  Created by Brain on 2018/9/11.
//  Copyright © 2018 In-next. All rights reserved.
//
//#import <CommonCrypto/CommonCrypto.h>
//#import "GTMBase64.h"
//#import "GTMDefines.h"
//#import <CommonCrypto/CommonHMAC.h>
//#import <CommonCrypto/CommonDigest.h>
#import "NSString+JJTools.h"
#import "UICKeyChainStore.h"

@implementation NSString (JJTools)


- (NSString*)deleteHeadAndBackWhiteSpace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString*)deleteAllWhiteSpace;
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (NSString*)deleteAllWhiteSpaceAndReturn
{
    NSString *str =@"";
    str =[self stringByReplacingOccurrencesOfString:@" " withString:@""];
    str =[str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str =[str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return str;
}
- (BOOL)isEmptyStr
{
    if (self ==nil ||self ==NULL ||[self isKindOfClass:[NSNull class]]||[self length]==0 ||[self isEqualToString:@""])
    {
        return YES;
    }
    return NO;
}

-(BOOL)isNotEmptyStr
{
    return ![self isEmptyStr];
    
}

- (BOOL)isValidPhoneNumber
{
    NSPredicate *postcodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[1][3,4,5,6,7,8,9][0-9]{9}$"];
    return [postcodeTest evaluateWithObject:self];
}

- (BOOL)isValidEmail
{
    NSPredicate *postcodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*$"];
    return [postcodeTest evaluateWithObject:self];
}

- (BOOL)isValidIDCard
{
    NSString *idCardStr;
    if (self.length == 15) {
        idCardStr = @"^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}[0-9Xx]$";
    } else if (self.length == 18) {
        idCardStr = @"^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$";
    }
    
    NSPredicate *postcodeTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"idCardStr"];
    return [postcodeTest evaluateWithObject:self];
}

- (BOOL)isValidBankCard
{
    if(self.length==0){
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < self.length; i++){
        c = [self characterAtIndex:i];
        if (isdigit(c)){
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--){
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo){
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
    
}


-(BOOL)isHaveChineseChar:(NSString *)str
{
    
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
        {
            return YES;
        }
    }
    return NO;
}

-(BOOL)isHaveNoillegalCharacter:(NSString *)str
{
    NSString *str1 =@"^[A-Za-z0-9\\u4e00-\u9fa5]+$";
    NSPredicate* emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", str1];
    if ([emailTest evaluateWithObject:str]) {
        return NO;
    }
    return YES;
}


- (CGFloat)stringHeightWithFont:(UIFont *)font width:(CGFloat)width
{
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];

    size =[self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size.height;
}

+ (NSString *)processHTMLString:(NSString *)htmlString
{
    /**
     * _infoModel.content就是后台返回的带有html标签的字符串
     * " $img[p].style.width = '100%%';\n"--->就是设置图片的宽度的
     * 100%代表正好为屏幕的宽度
     */
    NSString *string = [NSString stringWithFormat:@"<html> \n"
                        "<head> \n"
                        "<style type=\"text/css\"> \n"
                        "body {font-size:15px;}\n"
                        "</style> \n"
                        "</head> \n"
                        "<body>"
                        "<script type='text/javascript'>"
                        "window.onload = function(){\n"
                        "var $img = document.getElementsByTagName('img');\n"
                        "for(var p in  $img){\n"
                        " $img[p].style.width = '100%%';\n"
                        "$img[p].style.height ='auto'\n"
                        "}\n"
                        "}"
                        "</script>%@"
                        "</body>"
                        "</html>", htmlString];
    
    return string;
}

- (BOOL)isValidAlphanumericWithMinLength:(NSInteger)minLength maxLength:(NSInteger)maxLength
{
    BOOL result = NO;
    NSString * regex = [NSString stringWithFormat:@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{%ld,%ld}$", (long)minLength, (long)maxLength];
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    result = [pred evaluateWithObject:self];
    return result;
}

- (CGFloat)JJTextHeightWithFont:(UIFont *)font width:(CGFloat)width
{
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    
    size =[self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size.height;
}


- (CGFloat)JJTextWidthWithFont:(UIFont *)font Height:(CGFloat)height
{
    CGSize size = CGSizeMake(CGFLOAT_MAX, height);
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    
    size =[self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size.width;
}

+ (NSString *)urlEscape:(NSString *)unencodedString
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (CFStringRef)unencodedString,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 kCFStringEncodingUTF8));
}

+ (NSString *)urlUnescape: (NSString *) input
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL,
                                                                                                 (CFStringRef)input,
                                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                                 kCFStringEncodingUTF8));
}


// 把传入的参数按照get的方式打包到url后面。
+ (NSString *)addQueryStringToUrl:(NSString *)url params:(NSDictionary *)params
{
    if (nil == url) {
        return @"";
    }
    NSMutableString *urlWithQuerystring = [[NSMutableString alloc] initWithString:url];
    
    // Convert the params into a query string
    if (params) {
        for(id key in params) {
            NSString *sKey = [key description];
            NSString *sVal = [[params objectForKey:key] description];
            //是否有？，必须处理这个
            if ([urlWithQuerystring rangeOfString:@"?"].location==NSNotFound) {
                [urlWithQuerystring appendFormat:@"?%@=%@", [NSString urlEscape:sKey], [NSString urlEscape:sVal]];
            } else {
                [urlWithQuerystring appendFormat:@"&%@=%@", [NSString urlEscape:sKey], [NSString urlEscape:sVal]];
            }
        }
    }
    
    return urlWithQuerystring;
}


- (NSString *)MD5FromatString
{
//    if(self == nil || [self length] == 0)
//        return nil;
//
//    const char *value = [self UTF8String];
//    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
//    unsigned char x = strlen(value);
//    CC_MD5(value,x, outputBuffer);
//
//    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
//    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
//        [outputString appendFormat:@"%02x",outputBuffer[count]];
//    }
//    return outputString;
    return nil;
}

+ (NSString *)generateRandomStringWithLength:(NSInteger)iLength{
    char data[iLength];
    for (int x = 0; x < iLength; x++) {
        int j = '0' + (arc4random_uniform(75));
        if((j >= 58 && j <= 64) || (j >= 91 && j <= 96)){
            --x;
        }else{
            data[x] = (char)j;
        }
    }
    NSString *text = [[NSString alloc] initWithBytes:data length:iLength encoding:NSUTF8StringEncoding];
    return text;
}

+ (NSString*)getUUIDString{

    UICKeyChainStore * keychain = [UICKeyChainStore keyChainStoreWithService:@"JJKeyChainKey"];
    NSString *currentDeviceUUIDStr =keychain[@"uuid"];
    
    if (currentDeviceUUIDStr == nil || [currentDeviceUUIDStr isEqualToString:@""])
    {
        NSUUID * currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
        currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
        [keychain setString:currentDeviceUUIDStr forKey:@"uuid"];
    }
    return currentDeviceUUIDStr;

}

//加密
+ (NSString *)encryptUseDES:(NSString*)plainText key:(NSString *)key isHaveRandomNumber:(BOOL)randomFlag{
//    NSString *ciphertext = nil;
//    const char *textBytes = [plainText UTF8String];
//    NSUInteger dataLength = [plainText length];
//    unsigned char buffer[1024];
//    memset(buffer, 0, sizeof(char));
//    CCCryptorStatus cryptStatus;
//    size_t numBytesEncrypted = 0;
//    if (randomFlag) {
//        Byte iv[] = {1,2,3,4,5,6,7,8};
//        cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
//                              kCCOptionPKCS7Padding,
//                              [key UTF8String], kCCKeySizeDES,
//                              iv,
//                              textBytes, dataLength,
//                              buffer, 1024,
//                              &numBytesEncrypted);
//    }else{
//        cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
//                              kCCOptionPKCS7Padding | kCCOptionECBMode,
//                              [key UTF8String], kCCKeySizeDES,
//                              nil,
//                              textBytes, dataLength,
//                              buffer, dataLength + kCCBlockSizeAES128,
//                              &numBytesEncrypted);
//    }
//
//    if (cryptStatus == kCCSuccess) {
//        NSData *data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesEncrypted];
//        ciphertext = [[NSString alloc] initWithData:[GTMBase64 encodeData:data] encoding:NSUTF8StringEncoding];
//    }
//    return ciphertext;
    return nil;
}

//解密
+ (NSString *)decryptUseDES:(NSString*)cipherText key:(NSString*)key isHaveRandomNumber:(BOOL)randomFlag{
//    NSData* cipherData = [GTMBase64 decodeString:cipherText];
//    unsigned char buffer[1024];
//    memset(buffer, 0, sizeof(char));
//    size_t numBytesDecrypted = 0;
//    CCCryptorStatus cryptStatus;
//    if (randomFlag) {
//        Byte iv[] = {1,2,3,4,5,6,7,8};
//        cryptStatus = CCCrypt(kCCDecrypt,
//                              kCCAlgorithmDES,
//                              kCCOptionPKCS7Padding,
//                              [key UTF8String],
//                              kCCKeySizeDES,
//                              iv,
//                              [cipherData bytes],
//                              [cipherData length],
//                              buffer,
//                              1024,
//                              &numBytesDecrypted);
//    }else{
//        cryptStatus = CCCrypt(kCCDecrypt,
//                              kCCAlgorithmDES,
//                              kCCOptionPKCS7Padding | kCCOptionECBMode,
//                              [key UTF8String],
//                              kCCKeySizeDES,
//                              nil,
//                              [cipherData bytes],
//                              [cipherData length],
//                              buffer,
//                              [cipherData length] + kCCBlockSizeAES128,
//                              &numBytesDecrypted);
//    }
//    NSString* plainText = nil;
//    if (cryptStatus == kCCSuccess) {
//        NSData* data = [NSData dataWithBytes:buffer length:(NSUInteger)numBytesDecrypted];
//        plainText = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    }
//    return plainText;
    return nil;
}


/**
 *  对NSString进行des加密
 *
 *  @param key  要加密key
 *  @param data 加密的data
 *
 *  @return 加密后的字符串
 */
+(NSString *)HmacSha1:(NSString *)key data:(NSString *)data{
    
    
//    const char *cKey  = [key cStringUsingEncoding:NSUTF8StringEncoding];
//
//
//
//    const char *cData = [data cStringUsingEncoding:NSUTF8StringEncoding];
//
//
//
//    uint8_t cHMAC[CC_SHA1_DIGEST_LENGTH];
//
//
//
//    CCHmac(kCCHmacAlgSHA1, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
//
//
//
//    //NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC length:CC_SHA1_DIGEST_LENGTH];
//
//
//
//    NSString *hash;
//
//
//
//    NSMutableString * output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
//
//
//
//    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
//
//
//
//        [output appendFormat:@"%02x", cHMAC[i]];
//
//
//
//    hash = output;
//
//
//
//    return hash;
    return nil;
}


@end
