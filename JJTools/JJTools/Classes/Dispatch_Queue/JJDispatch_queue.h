//
//  JJDispatch_queue.h
//  JJTools
//
//  Created by Brain on 2019/1/22.
//  Copyright © 2019 Brain. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJDispatch_queue : NSObject

/**
调用主线程

 @param completionBlock block
 */
+(void)callMainQueueWithCompletionBlock:(void(^)(void))completionBlock;
/**
 异步串行全局队列优先级一般
 
 @param completionBlock block
 */
+(void)callGlobalQueueUsePriority_DefaultWithCompletionBlock:(void(^)(void))completionBlock;
/**
 异步串行全局队列优先级高
 
 @param completionBlock block
 */
+(void)callGlobalQueueUsePriority_HighWithCompletionBlock:(void(^)(void))completionBlock;

/**
 异步串行队列

 @param constChar name
 @param completionBlock block
 */
+(void)callAsyncQueueUseConcurrentStr:(char*)constChar WithCompletionBlock:(void(^)(void))completionBlock;

/**
 延时多线程

 @param timeInterval timeInterval
 @param completionBlock block
 */
+(void)callAfterQueueUseConcurrentStr:(int64_t)timeInterval WithCompletionBlock:(void(^)(void))completionBlock;

/**
 同步并发,用于有顺序的事件
 在回调中第一个执行事件发送信号dispatch_semaphore_signal(semaphore);
 第二个事件在接收到信号dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);后触发
 如果有第三个第四个重复上面的步骤;
 completionBlock
 {
 [self actionA:{...dispatch_semaphore_signal(semaphore);}];
 dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
 [self actionB:{...}];
 .....
 };
 @param constChar name
 @param completionBlock block
 */
+(void)callSemaphoreSyncQueueUseConcurrentStr:(char*)constChar  WithCompletionBlock:(void(^)(dispatch_semaphore_t semaphore))completionBlock;
@end

NS_ASSUME_NONNULL_END
