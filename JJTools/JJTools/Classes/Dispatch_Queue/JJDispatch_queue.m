//
//  JJDispatch_queue.m
//  JJTools
//
//  Created by Brain on 2019/1/22.
//  Copyright © 2019 Brain. All rights reserved.
//

#import <objc/runtime.h>
#import "JJDispatch_queue.h"

@interface JJDispatch_queue ()
@property (nonatomic, strong) void (^dispath_queueNoParaCompletion)(void);
@property (nonatomic, strong) void (^dispath_queueCompletion)(dispatch_semaphore_t semaphore);

@end

@implementation JJDispatch_queue

static void *dispath_queueNoParaCompletionKey = &dispath_queueNoParaCompletionKey;
static void *dispath_queueCompletionKey = &dispath_queueCompletionKey;

+(void (^)(void))dispath_queueNoParaCompletion
{
    return objc_getAssociatedObject(self, &dispath_queueNoParaCompletionKey);
}

+(void (^)(dispatch_semaphore_t))dispath_queueCompletion
{
    return objc_getAssociatedObject(self, &dispath_queueCompletionKey);
}

+ (void)setDispath_queueNoParaCompletion:(void (^)(void))dispath_queueNoParaCompletion
{
   objc_setAssociatedObject(self, &dispath_queueNoParaCompletionKey, dispath_queueNoParaCompletion, OBJC_ASSOCIATION_COPY);
}

+(void)setDispath_queueCompletion:(void (^)(dispatch_semaphore_t))dispath_queueCompletion
{
  objc_setAssociatedObject(self, &dispath_queueCompletionKey, dispath_queueCompletion, OBJC_ASSOCIATION_COPY);
}

+(void)callMainQueueWithCompletionBlock:(void(^)(void))completionBlock
{
    if (completionBlock) {
        self.dispath_queueNoParaCompletion = completionBlock;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        !self.dispath_queueNoParaCompletion ? :self.dispath_queueNoParaCompletion();
    });
    
}

+(void)callGlobalQueueUsePriority_DefaultWithCompletionBlock:(void(^)(void))completionBlock
{
    if (completionBlock) {
        self.dispath_queueNoParaCompletion = completionBlock;
    }
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(global, ^{
         !self.dispath_queueNoParaCompletion ? :self.dispath_queueNoParaCompletion();
    });
}

+(void)callGlobalQueueUsePriority_HighWithCompletionBlock:(void(^)(void))completionBlock
{
    if (completionBlock) {
        self.dispath_queueNoParaCompletion = completionBlock;
    }
    dispatch_queue_t global = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(global, ^{
        !self.dispath_queueNoParaCompletion ? :self.dispath_queueNoParaCompletion();
    });
}

+(void)callAsyncQueueUseConcurrentStr:(char*)constChar WithCompletionBlock:(void(^)(void))completionBlock
{
    if (completionBlock) {
        self.dispath_queueNoParaCompletion = completionBlock;
    }
    dispatch_queue_t  queue =dispatch_queue_create(constChar, DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        !self.dispath_queueNoParaCompletion ? :self.dispath_queueNoParaCompletion();
    });
}

+(void)callAfterQueueUseConcurrentStr:(int64_t)timeInterval WithCompletionBlock:(void(^)(void))completionBlock
{
    if (completionBlock) {
        self.dispath_queueNoParaCompletion = completionBlock;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(timeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        !self.dispath_queueNoParaCompletion ? :self.dispath_queueNoParaCompletion();
    });
}

+(void)callSemaphoreSyncQueueUseConcurrentStr:(char*)constChar  WithCompletionBlock:(void(^)(dispatch_semaphore_t semaphore))completionBlock
{
    if (completionBlock) {
        self.dispath_queueCompletion = completionBlock;
    }
    dispatch_queue_t  queue = dispatch_queue_create(constChar, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
        !self.dispath_queueCompletion ? :self.dispath_queueCompletion(semaphore);
    });
  
}

@end
