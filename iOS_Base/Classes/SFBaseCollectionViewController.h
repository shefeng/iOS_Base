//
//  SFBaseCollectionViewController.h
//  iOS_Base
//
//  Created by shefeng on 2023/5/15.
//

#import "SFBaseViewController.h"
#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFBaseCollectionViewController : SFBaseViewController<DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>

//列表
@property (strong, nonatomic) UICollectionView *collectionView;

//数据源
@property (strong, nonatomic) NSMutableArray *dataArr;

//当前页
@property (nonatomic, assign) NSInteger page;

//刷新数据
- (void)refreshData;

//加载更多
- (void)loadMore;

//页面是否已经请求过数据
- (BOOL)hasLoadData;

//自定义空白视图
- (UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView;

//空白视图竖直方向偏移量
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView;

@end

NS_ASSUME_NONNULL_END
