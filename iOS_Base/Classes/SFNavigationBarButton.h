//
//  SFNavigationBarButton.h
//  iOS_Base
//
//  Created by shefeng on 2023/5/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^actionBlock)(void);

@interface SFNavigationBarButton : UIButton

@property (nonatomic, copy) actionBlock actionBlock;

- (void)actionWith:(actionBlock)actionBlock;

@end

NS_ASSUME_NONNULL_END
