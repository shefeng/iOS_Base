//
//  SFBaseModel.m
//  iOS_Base_Example
//
//  Created by shefeng on 2023/5/15.
//  Copyright © 2023 shefeng. All rights reserved.
//

#import "SFBaseModel.h"
#import <MJExtension/MJExtension.h>

@implementation SFBaseModel

/* 保留词替换 */
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
        @"desc" : @"description",
        @"ID" : @"id"
    };
}

/* 驼峰替换 */
+ (NSString *)mj_replacedKeyFromPropertyName121:(NSString *)propertyName{
    if ([propertyName isEqualToString:@"ID"]) {
        return nil;
    }
    return [propertyName mj_underlineFromCamel];
}

/* 防止出现空值 */
- (id)mj_newValueFromOldValue:(id)oldValue property:(MJProperty *)property {
    if ([oldValue isKindOfClass:[NSArray class]]) {
        if (oldValue == [NSNull null]) {
            return @[];
        }
    } else if ([oldValue isKindOfClass:[NSDictionary class]]) {
        if (oldValue == [NSNull null]) {
            return @{};
        }
    } else if ([oldValue isKindOfClass:[NSString class]]) {
        if (oldValue == [NSNull null]) {
            return @"";
        }
    }
    return oldValue;
}

@end
