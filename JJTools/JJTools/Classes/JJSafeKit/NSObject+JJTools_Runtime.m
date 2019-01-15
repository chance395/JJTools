//
//  NSObject+JJTools_Runtime.m
//  qhg_ios
//
//  Created by Brain on 2018/9/12.
//  Copyright © 2018 In-next. All rights reserved.
//

#import "NSObject+JJTools_Runtime.h"
#import <UIKit/UIKit.h>
@implementation NSObject (JJTools_Runtime)

+ (NSMutableArray*)getPropertyList
{
    unsigned int count;
    objc_property_t *propertyList =class_copyPropertyList([self class], &count);
    NSMutableArray *array =[NSMutableArray array];
    for (unsigned int i =0; i<count; i++)
    {
        const char *propertyName =property_getName(propertyList[i]);
        NSLog(@"propertyList =%@",[NSString stringWithUTF8String:propertyName]);
        [array addObject:[NSString stringWithUTF8String:propertyName]];
    }
    return array;
    
}

+ (NSMutableArray*)getMethodList
{
    unsigned int count ;
    Method *methosList =class_copyMethodList([self class], &count);
    NSMutableArray *array =[NSMutableArray array];
    for (unsigned int i=0; i<count; i++)
    {
        Method method =methosList[i];
        NSLog(@"method =%@",NSStringFromSelector(method_getName(method)));
        [array addObject:NSStringFromSelector(method_getName(method))];
    }
    return array;
}

+ (NSMutableArray*)getIvarList
{
    unsigned int count ;
    Ivar *ivarList =class_copyIvarList([self class], &count);
     NSMutableArray *array =[NSMutableArray array];
    for (unsigned int i=0; i<count; i++)
    {
        Ivar var =ivarList[i];
        const char *varName =ivar_getName(var);
        NSLog(@"var=%@",[NSString stringWithUTF8String:varName]);
        [array addObject:[NSString stringWithUTF8String:varName]];
    }
    return array;
}

+ (NSMutableArray*)getProtocolList
{
    unsigned int count;
    __unsafe_unretained Protocol ** protocolList =class_copyProtocolList([self class], &count);
     NSMutableArray *array =[NSMutableArray array];
    for (unsigned int i =0; i<count; i++)
    {
        Protocol *protocol=protocolList[i];
        const char *proName =protocol_getName(protocol);
        NSLog(@"protocolName =%@",[NSString stringWithUTF8String:proName]);
        [array addObject:[NSString stringWithUTF8String:proName]];
    }
    return array;
}

+ (void)exchangeInstanceMethodWithSelfClass:(Class)selfClass
                           originalSelector:(SEL)originalSelector
                           swizzledSelector:(SEL)swizzledSelector {
    
    Method originalMethod = class_getInstanceMethod(selfClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(selfClass, swizzledSelector);
    BOOL didAddMethod = class_addMethod(selfClass,
                                        originalSelector,
                                        method_getImplementation(swizzledMethod),
                                        method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(selfClass,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

+ (void)SwizzlingMethod:(NSString *)systemMethodString systemClassString:(NSString *)systemClassString toSafeMethodString:(NSString *)safeMethodString targetClassString:(NSString *)targetClassString{
    //获取系统方法IMP
    Method sysMethod = class_getInstanceMethod(NSClassFromString(systemClassString), NSSelectorFromString(systemMethodString));
    //自定义方法的IMP
    Method safeMethod = class_getInstanceMethod(NSClassFromString(targetClassString), NSSelectorFromString(safeMethodString));
    //IMP相互交换，方法的实现也就互相交换了
    method_exchangeImplementations(safeMethod,sysMethod);
}

@end
