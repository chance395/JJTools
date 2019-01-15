//
//  NSObject+JJTools_Runtime.h
//  qhg_ios
//
//  Created by Brain on 2018/9/12.
//  Copyright © 2018 In-next. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (JJTools_Runtime)

/**
 获取属性列表
 */
+ (NSMutableArray*)getPropertyList;

/**
 获取方法列表
 */
+ (NSMutableArray*)getMethodList;

/**
 获取成员变量
 */
+ (NSMutableArray*)getIvarList;

/**
 获取协议列表
 */
+ (NSMutableArray*)getProtocolList;

/**
 交换两个方法

 @param selfClass class
 @param originalSelector 被交换的
 @param swizzledSelector 交换的
 */
+ (void)exchangeInstanceMethodWithSelfClass:(Class)selfClass
                           originalSelector:(SEL)originalSelector
                           swizzledSelector:(SEL)swizzledSelector;

/**
 *  交换两个函数实现指针  参数均为NSString类型
 *
 *  @param systemMethodString 系统方法名string
 *  @param systemClassString  系统实现方法类名string
 *  @param safeMethodString   自定义hook方法名string
 *  @param targetClassString  目标实现类名string
 */
+ (void)SwizzlingMethod:(NSString *)systemMethodString systemClassString:(NSString *)systemClassString toSafeMethodString:(NSString *)safeMethodString targetClassString:(NSString *)targetClassString;

@end
