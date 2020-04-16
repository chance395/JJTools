//
//  NSArray+JJTools.m
//  JJTools
//
//  Created by Brian on 2020/1/20.
//  Copyright © 2020 Brain. All rights reserved.
//

#import "NSArray+JJTools.h"

@implementation NSArray (JJTools)

+(NSArray *)removeDuplicateElementWithBasicValueArr:(NSArray*)basicValueArr
{
    NSSet *set =[NSSet setWithArray:basicValueArr];
    return [[set allObjects]mutableCopy];
}

+(NSArray *)removeDuplicateElementWithIdentifier:(NSString*)identifier dicValurArr:(NSArray*)dicValueArr
{
    NSArray *arr =[dicValueArr valueForKeyPath:[NSString stringWithFormat:@"distinctUnionOfObjects.%@",identifier]];
    NSMutableArray *finalArr =[NSMutableArray array];
    for (NSString*key in arr) {
        [finalArr addObject:[arr filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"%@ = %@",identifier,key]]].firstObject];
    }
    return [finalArr mutableCopy];
}

@end
