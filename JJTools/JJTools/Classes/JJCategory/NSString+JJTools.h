//
//  NSString+JJTools.h
//  qhg_ios
//
//  Created by Brain on 2018/9/11.
//  Copyright © 2018 In-next. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (JJTools)

/**
 删除字符串前后端空格

 @return 返回一个删除前后端空格的字符串
 */
- (NSString*)deleteHeadAndBackWhiteSpace;

/**
 删除所有的空格

 @return 返回一个删除所有空格的字符串
 */
- (NSString*)deleteAllWhiteSpace;


/**
 删除所有的空格和回车键

 @return 返回一个删除所有空格和回车键的字符串
 */
- (NSString*)deleteAllWhiteSpaceAndReturn;

/**
 是否为空

 @return yes or no
 */
- (BOOL)isEmptyStr;

/**
 是否为空
 
 @return yes or no
 */

-(BOOL)isNotEmptyStr;

/**
 判断是否是有效的电话号码

 @return yes or no
 */
- (BOOL)isValidPhoneNumber;

/**
 判断是否是有效的邮箱

 @return yes or no
 */
- (BOOL)isValidEmail;

/**
 判断是否是有效的身份证号码

 @return yes or no
 */
- (BOOL)isValidIDCard;

/**
 判断是否是有效的银行卡号码

 @return yes or no
 */
- (BOOL)isValidBankCard;


/**
 判断是否含有中文字符

 @param str str
 @return yes or no
 */
-(BOOL)isHaveChineseChar:(NSString *)str;

/**
 判断是否含有特殊字符

 @param str str
 @return yes or no
 */
-(BOOL)isHaveNoillegalCharacter:(NSString *)str;

/**
 返回指定宽度的字符串的高度

 @param font font
 @param width width
 @return 高度
 */
- (CGFloat)stringHeightWithFont:(UIFont *)font width:(CGFloat)width;

/**
 str

 @param htmlString htm
 @return 矫正后的str
 */
+ (NSString *)processHTMLString:(NSString *)htmlString;

/**
 判断是否同时含有数字和字符串并且规定数字和字符串

 @param minLength min
 @param maxLength max
 @return yes or no
 */
- (BOOL)isValidAlphanumericWithMinLength:(NSInteger)minLength maxLength:(NSInteger)maxLength;


/**
 返回高度
 
 @param font font
 @param width width
 @return 高度
 */
- (CGFloat)JJTextHeightWithFont:(UIFont *)font width:(CGFloat)width;

/**
 返回宽度
 
 @param font font
 @param height height
 @return 高度
 */
- (CGFloat)JJTextWidthWithFont:(UIFont *)font Height:(CGFloat)height;


+ (NSString *)urlEscape:(NSString *)unencodedString;

+ (NSString *)urlUnescape: (NSString *) input;

+ (NSString *)addQueryStringToUrl:(NSString *)url params:(NSDictionary *)params;
/**
 MD5加密

 @return 加密后的str
 */
//- (NSString *)MD5FromatString;

/**
 *  生成固定长度的随机字符串
 *
 *  @param iLength 长度
 *
 *  @return 随机字符串
 */
+ (NSString *)generateRandomStringWithLength:(NSInteger)iLength;


/**
 *  生成设备的UUID，iOS6之后可用
 *
 *  @return uuid字符串
 */
+ (NSString *)getUUIDString;//NS_AVAILABLE_IOS(6_0)


/**
 *  对NSString进行des加密
 *
 *  @param plainText  要加密的字符串
 *  @param key        加密的key
 *  @param randomFlag 加密时是否要包含随机数
 *
 *  @return 加密后的字符串
 */
//+ (NSString *)encryptUseDES:(NSString*)plainText key:(NSString *)key isHaveRandomNumber:(BOOL)randomFlag;

/**
 *  解密字符串
 *
 *  @param cipherText 密文字符串
 *  @param key        加密的key
 *  @param randomFlag 加密时是否要包含随机数
 *
 *  @return 解密后的字符串
 */
//+ (NSString *)decryptUseDES:(NSString*)cipherText key:(NSString*)key isHaveRandomNumber:(BOOL)randomFlag;



/**
 *  对NSString进行des加密
 *
 *  @param key  要加密key
 *  @param data 加密的data
 *
 *  @return 加密后的字符串
 */
+(NSString *)HmacSha1:(NSString *)key data:(NSString *)data;


@end
