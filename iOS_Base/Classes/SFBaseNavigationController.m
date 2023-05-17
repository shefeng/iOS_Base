//
//  SFBaseNavigationController.m
//  iOS_Base
//
//  Created by shefeng on 2023/5/15.
//

#import "SFBaseNavigationController.h"
#import "UIImage+SFUtils.h"
#import "SFCommonConfig.h"

@interface SFBaseNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation SFBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
    
    //设置navigationBar颜色
    [self.navigationBar setBackgroundImage:[UIImage imageWithColor:[SFCommonConfig sharedConfig].navBgColor withFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[[UIApplication sharedApplication]statusBarFrame].size.height + self.navigationBar.frame.size.height)] forBarMetrics:UIBarMetricsDefault];
    //毛玻璃效果
    self.navigationBar.translucent = NO;
    //设置标题的样式
    [self.navigationBar setTitleTextAttributes:@{
        NSForegroundColorAttributeName:[SFCommonConfig sharedConfig].navTitleColor,
        NSFontAttributeName:[SFCommonConfig sharedConfig].navTitleFont
    }];
    
    //去掉底部的黑线
    if([SFCommonConfig sharedConfig].deleteNavBottomLine){
        [self.navigationBar setShadowImage:[UIImage new]];
    }
}

#pragma mark - 重写push方法，用于push的时候隐藏tabbar
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count <= 1) {
        return NO;
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return([gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class]);
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    UIViewController *topVC = self.topViewController;
    return [topVC preferredStatusBarStyle];
}

@end
