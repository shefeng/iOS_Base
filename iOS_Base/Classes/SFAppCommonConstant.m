//
//  SFAppCommonConstant.m
//  iOS_Base
//
//  Created by shefeng on 2023/5/15.
//

#import "SFAppCommonConstant.h"

@implementation SFAppCommonConstant

+ (SFAppCommonConstant *)sharedCommonConstant{
    
    static SFAppCommonConstant *sharedCommonConstant = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        if (!sharedCommonConstant) {
            sharedCommonConstant = [[SFAppCommonConstant alloc] init];
        }
    });
    return sharedCommonConstant;
}

@end
