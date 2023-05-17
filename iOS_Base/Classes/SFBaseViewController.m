//
//  SFBaseViewController.m
//  iOS_Base
//
//  Created by shefeng on 2023/5/15.
//

#import "SFBaseViewController.h"
#import "SFBaseNavigationController.h"
#import "SFNavigationBarButton.h"
#import "SFCommonConfig.h"
#import "UIImage+SFUtils.h"
#import "SFWeakStrong.h"
#import "SFMacroDefinition.h"

@interface SFBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation SFBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景色
    self.view.backgroundColor = [SFCommonConfig sharedConfig].vcBgColor;
    
    //判断是否有上级页面来确定是否显示返回按钮
    if ([self isViewControllerPushed]) {
        [self setLeftBarBtn];
    }
    
    if (@available(iOS 15.0, *)) {
        UINavigationBarAppearance *barApp = [UINavigationBarAppearance new];
        
        barApp.backgroundColor = [SFCommonConfig sharedConfig].navBgColor;
        
        [barApp setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
        [barApp setShadowImage:[UIImage imageWithColor:[UIColor whiteColor]]];
        [[UINavigationBar appearance] setScrollEdgeAppearance:barApp];
        self.navigationController.navigationBar.scrollEdgeAppearance = barApp;
        self.navigationController.navigationBar.standardAppearance = barApp;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(self.needHideNavigationBar){
        [self.navigationController setNavigationBarHidden:YES animated:NO];
    }else{
        [self.navigationController setNavigationBarHidden:NO animated:NO];
    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

+ (SFBaseViewController*)topViewController {
    return (SFBaseViewController *)[self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        if ([presentedViewController isKindOfClass:[UIAlertController class]]) {
            UIWindow *window =  [UIApplication sharedApplication].delegate.window;
            UIViewController *vc = window.rootViewController;
            return [self topViewControllerWithRootViewController:vc];
        }
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

#pragma mark - 自定义返回按钮
- (void)setLeftBarBtn{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[SFCommonConfig sharedConfig].navBackImage style:UIBarButtonItemStylePlain target:self action:@selector(leftBarBtnClickAction)];
    [self.navigationItem.leftBarButtonItem setTintColor:kColor333];
}

#pragma mark - 返回按钮点击事件
- (void)leftBarBtnClickAction{
    if([self isViewControllerPushed]){
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

- (BOOL)isViewControllerPushed{
    if (!self.navigationController) {
        return NO;
    }
    NSArray *viewcontrollers = self.navigationController.viewControllers;
    if (viewcontrollers.count >= 1) {
        if ([viewcontrollers objectAtIndex:viewcontrollers.count-1] == self && viewcontrollers[0] != self ) {
            return YES;
        }
    }
    return NO;
}
#pragma mark - For iOS 11
- (void)adjustInsetWithScrollView:(UIScrollView *)scrollView {
    if (@available(iOS 11.0, *)) {
        scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
}

#pragma mark -- Helper
- (void)cancelSideBack{
    if (self.navigationController.viewControllers.count == 1) {
        self.isCanUseSideBack = NO;
        if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
            self.navigationController.interactivePopGestureRecognizer.delegate = self;
        }
    }
}

- (void)startSideBack {
    self.isCanUseSideBack=YES;
    if([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)gestureRecognizer {
    return self.isCanUseSideBack;
}

- (void)setupLeftWithCustomView:(UIView *)view{
    if(self.navigationController){
        [self setLeftWithNavigationItem:self.navigationController.navigationItem customView:view];
    }
}

- (void)setupLeftWithImageNamed:(NSString *)imageName highlightImageNamed:(NSString *)highlightImageName{
    WEAK_SELF
    return [self setLeftWithNavigationItem:self.navigationItem imageName:imageName highlightImageName:highlightImageName action:^{
        STRONG_SELF
        [self naviLeftAction];
    }];
}

- (void)naviLeftAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupRightWithImage:(NSString *)imgName actionBlock:(void (^) (void))action {
    [self setRightWithNavigationItem:self.navigationItem imageName:imgName highlightImageName:imgName action:action];
}

- (void)setupRightWithTitle:(NSString *)title font:(UIFont *)font textColor:(UIColor *)textColor actionBlock:(void (^) (void))action{
    [self setRightWithNavigationItem:self.navigationItem :title font:font textColor:textColor action:action];
}

#pragma mark - 导航栏按钮
- (void)setLeftWithNavigationItem:(UINavigationItem *)item customView:(UIView *)view {
    CGRect rect = view.bounds;
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width + 20, rect.size.height + 20)];
    containerView.backgroundColor = [UIColor clearColor];
    [containerView addSubview:view];
    if (@available(iOS 11.0, *)) {
        view.center = CGPointMake( containerView.bounds.size.width / 2 - 15, containerView.bounds.size.height / 2 );
    } else {
        view.center = CGPointMake( containerView.bounds.size.width / 2, containerView.bounds.size.height / 2 );
    }
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:containerView];
    
    item.leftBarButtonItems = @[[self negativeBarButtonItem:YES], rightItem];
}

- (UIBarButtonItem *)negativeBarButtonItem:(BOOL)isleft {
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = (isleft) ? (-20) : (-16);
    return(negativeSpacer);
}

- (void)setLeftWithNavigationItem:(UINavigationItem *)item imageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName action:(actionBlock)action {
    UIImage *normalImage = [UIImage imageNamed:imageName];
    UIImage *highlightImage = [UIImage imageNamed:highlightImageName];
    SFNavigationBarButton *backButton = [[SFNavigationBarButton alloc] initWithFrame:CGRectMake(0, 0, normalImage.size.width + 30, normalImage.size.height + 20)];
    [backButton setImage:normalImage forState:UIControlStateNormal];
    [backButton setImage:highlightImage forState:UIControlStateHighlighted];
    [backButton actionWith:^() {
        if (action){
            action();
        }
    }];
    [self adjustButtonInsetWith:backButton isLeft:YES];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    item.leftBarButtonItems = @[[self negativeBarButtonItem:YES], leftItem];
}

- (void)setRightWithNavigationItem:(UINavigationItem *)item imageName:(NSString *)imageName highlightImageName:(NSString *)highlightImageName action:(actionBlock)action {
    UIImage *normalImage = [[UIImage imageNamed:imageName] resizeWithScale:[UIScreen mainScreen].bounds.size.width/375.f];
    UIImage *highlightImage = [[UIImage imageNamed:highlightImageName] resizeWithScale:[UIScreen mainScreen].bounds.size.width/375.f];
    
    SFNavigationBarButton *rightButton;
    if (@available (iOS 11.0, *)) {
        rightButton = [[SFNavigationBarButton alloc] initWithFrame:CGRectMake (0, 0, 40, 40)];
    } else {
        rightButton = [[SFNavigationBarButton alloc] initWithFrame:CGRectMake (0, 0, normalImage.size.width + 20, normalImage.size.height + 20)];
    }
    [rightButton setImage:normalImage forState:UIControlStateNormal];
    [rightButton setImage:highlightImage forState:UIControlStateHighlighted];
    [rightButton actionWith:^() {
        if (action){
            action();
        }
    }];
    
    [self adjustButtonInsetWith:rightButton isLeft:NO];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    item.rightBarButtonItems = @[[self negativeBarButtonItem:NO], rightItem];
}

- (void)setRightWithNavigationItem:(UINavigationItem *)item :(NSString *)title font:(UIFont *)font textColor:(UIColor *)textColor action:(actionBlock)action {
    SFNavigationBarButton *rightButton = [[SFNavigationBarButton alloc] initWithFrame:CGRectMake (0, 0, 40, 40)];
    [rightButton setTitle:title forState:UIControlStateNormal];
    [rightButton setTitleColor:textColor forState:UIControlStateNormal];
    rightButton.titleLabel.font = font;
    [rightButton actionWith:^() {
        if (action){
            action();
        }
    }];
    
    [self adjustButtonInsetWith:rightButton isLeft:NO];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    item.rightBarButtonItems = @[[self negativeBarButtonItem:NO], rightItem];
}

- (void)adjustButtonInsetWith:(UIButton *)button isLeft:(BOOL)left {
    if (left) {
        if ( [[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0 ) {
            
        }else{
            if ( [UIScreen mainScreen].bounds.size.width > 375 ) {
                button.imageEdgeInsets = UIEdgeInsetsMake (0, -15, 0, 0);
            }else{
                button.imageEdgeInsets = UIEdgeInsetsMake (0, -5, 0, 0);
            }
        }
    }
    if ( @available (iOS 11.0, *) ) {
        if (left) {
            
        } else {
            button.imageEdgeInsets = UIEdgeInsetsMake (0, 6, 0, -6);
        }
    }
}

@end
