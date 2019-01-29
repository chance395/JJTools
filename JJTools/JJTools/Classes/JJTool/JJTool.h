//
//  JJTool.h
//  JJTools
//
//  Created by Brain on 2018/12/13.
//  Copyright © 2018 Brain. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJTool : NSObject

/**
 *  获取当前显示的viewcontroller
 *
 *  @return return 当前显示的vc
 */
+ (UIViewController *)getTopViewController;

/**
 *  根据根vc获取最上层vc
 *
 *  @param rootViewController 根vc
 *
 *  @return 最上层vc
 */
+ (UIViewController*)getTopViewControllerWithRootViewController:(UIViewController*)rootViewController;


/**
 *  获取当前时间戳
 *
 *  @return 时间戳字符串
 */
+ (NSString*)getCurrentTimestamp;

+ (NSString *)getDateTimeFromTimestamp:(NSString*) Timestamp;

- (NSString *)getTimeStrWithString:(NSString *)str;

/**
 *  保存图片到沙盒
 *
 *  @param imageName 图片名称
 *  @param image     图片
 *
 *  @return 是否保存成功
 */
+ (BOOL)saveImageWithName:(NSString*)imageName andImage:(UIImage*)image;

/**
 *  从沙盒中获取图片
 *
 *  @param imageName 图片名称
 *
 *  @return 图片
 */
+ (UIImage*)loadImageWithName:(NSString*)imageName;

/**
 *  从沙盒中删除图片
 *
 *  @param imageName 图片名称
 */
+ (void)deleteImageWithName:(NSString*)imageName;

/**
 *  根据图片名称获取图片路径
 *
 *  @param imageName 图片名称
 *
 *  @return 图片路径
 */
+ (NSString*)generateImagePathwithName:(NSString*)imageName;

/**
 *  清空本地存储的照片缓存
 */
+ (void)clearLocalImageCache;

/**
 *  压缩图片尺寸
 *
 *  @param sourceImage 源数据
 *  @param targetWidth 目标宽度
 *
 *  @return 缩小尺寸后的图片
 */
+ (UIImage *)compressImage:(UIImage *)sourceImage toTargetWidth:(CGFloat)targetWidth;

/**
 *  压缩图片到固定大小
 *
 *  @param image 源数据
 *  @param size  目标大小
 *
 *  @return 缩小后的图片
 */
+ (UIImage *)compressImage:(UIImage *)image toTargetsize:(float)size;

/**
 *  压缩图片到固定大小
 *
 *  @param lbl 需要改变的控件
 *  @param color  改变的颜色
 *  @param font  改变的字体
 *  @param range  改变的范围
 *
 *
 */
+ (void)changeStringLabel:(UILabel *)lbl withColor:(UIColor *)color font:(UIFont *)font withRange:(NSRange)range;

//textfield的长度
+(BOOL)textField:(UITextField *) textField withLength:(NSInteger)theMaxLength shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

//金额除以100后转化
+(NSString *)calculateMoney:(NSString *)money;

//截取时间
+(NSString *)CutOutTime:(NSString *)time;
//iOS开发中获取MAC地址方法
- (NSString *)getMacAddress;

/*
 
 * 判断用户输入的密码是否符合规范，符合规范的密码要求：
 1. 长度大于6位
 2. 密码中必须同时包含数字和字母
 
 */

+(BOOL)judgePassWordLegal:(NSString *)pass;



@end

NS_ASSUME_NONNULL_END
