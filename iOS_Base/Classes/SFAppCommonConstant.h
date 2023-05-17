//
//  SFAppCommonConstant.h
//  iOS_Base
//
//  Created by shefeng on 2023/5/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFAppCommonConstant : NSObject

//当前网络状态
@property (nonatomic,assign) BOOL isNetWorkReach;

+ (SFAppCommonConstant *)sharedCommonConstant;

@end

NS_ASSUME_NONNULL_END
