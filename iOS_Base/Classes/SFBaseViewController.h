//
//  SFBaseViewController.h
//  iOS_Base
//
//  Created by shefeng on 2023/5/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFBaseViewController : UIViewController

@property (nonatomic, assign) BOOL needHideNavigationBar;
@property (nonatomic, assign) BOOL isCanUseSideBack;

+ (SFBaseViewController *)topViewController;

- (void)leftBarBtnClickAction;

- (BOOL)isViewControllerPushed;

- (void)adjustInsetWithScrollView:(UIScrollView *)scrollView;

- (void)setupLeftWithCustomView:(UIView *)view;

- (void)setupLeftWithImageNamed:(NSString *)imageName highlightImageNamed:(NSString *)highlightImageName;

- (void)setupRightWithImage:(NSString *)imgName actionBlock:(void (^)(void))action;

- (void)setupRightWithTitle:(NSString *)title font:(UIFont *)font textColor:(UIColor *)textColor actionBlock:(void (^) (void))action;

@end

NS_ASSUME_NONNULL_END
