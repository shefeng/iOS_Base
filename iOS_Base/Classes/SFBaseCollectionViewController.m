//
//  SFBaseCollectionViewController.m
//  iOS_Base
//
//  Created by shefeng on 2023/5/15.
//

#import "SFBaseCollectionViewController.h"
#import "SFAppCommonConstant.h"
#import "SFCommonConfig.h"
#import "SFMacroDefinition.h"
#import "UIImage+SFUtils.h"

@interface SFBaseCollectionViewController ()

@end

@implementation SFBaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.collectionView) {
        self.collectionView.emptyDataSetSource = self;
        self.collectionView.emptyDataSetDelegate = self;
    }
}

/**
 刷新数据
 */
- (void)refreshData{
}

/**
 加载更多
 */
- (void)loadMore{
}

/**
 页面是否已经请求过数据
 */
- (BOOL)hasLoadData{
    return _dataArr != nil;
}

#pragma -mark DZNEmptyDataSetSource DZNEmptyDataSetDelegate
/**
 空视图图片
 */
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (![SFAppCommonConstant sharedCommonConstant].isNetWorkReach) {
        return [[SFCommonConfig sharedConfig].noNetWorkImage resizeWithScale:kScreen_Width/375.f];
    }
    
    if (![self hasLoadData]) {
        return [UIImage imageWithColor:[UIColor clearColor]];
    }
    
    return [[SFCommonConfig sharedConfig].noDataImage resizeWithScale:kScreen_Width/375.f];
}

/**
 空视图标题
 */
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    NSString *title = [SFCommonConfig sharedConfig].titleForEmptyList;
    
    if (![self hasLoadData]) {
        title = @"";
    }
    
    if (![SFAppCommonConstant sharedCommonConstant].isNetWorkReach) {
        title = [SFCommonConfig sharedConfig].titleForNoNetwork;
    }
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[SFCommonConfig sharedConfig].titleForNoNetwork attributes: @{
        NSFontAttributeName: [SFCommonConfig sharedConfig].titleFontForEmptyList,
        NSForegroundColorAttributeName: [SFCommonConfig sharedConfig].titleColorForEmptyList
    }];
    
    return string;
}

/**
 空视图点击事件
 */
- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
    [self refreshData];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
    return [SFCommonConfig sharedConfig].vOffsetForEmptyList;
}

- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView{
    return nil;
}

@end
