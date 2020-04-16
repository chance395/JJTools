//
//  NSMutableArray+JJTools.h
//  JJTools
//
//  Created by Brian on 2020/1/20.
//  Copyright © 2020 Brain. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableArray (JJTools)

+(NSMutableArray *)removeDuplicateElementWithBasicValueArr:(NSArray*)basicValueArr;
+(NSMutableArray *)removeDuplicateElementWithIdentifier:(NSString*)identifier dicValurArr:(NSArray*)dicValueArr;
@end

NS_ASSUME_NONNULL_END
