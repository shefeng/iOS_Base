//
//  SFCommonConfig.h
//  iOS_Base
//
//  Created by shefeng on 2023/5/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SFCommonConfig : NSObject

//nav
@property (strong, nonatomic) UIColor *navBgColor;
@property (strong, nonatomic) UIColor *navTitleColor;
@property (strong, nonatomic) UIFont *navTitleFont;
@property (strong, nonatomic) UIImage *navBackImage;
@property (assign, nonatomic) BOOL deleteNavBottomLine;

//vc
@property (strong, nonatomic) UIColor *vcBgColor;

//table&collection
@property (strong, nonatomic) UIImage *noDataImage;
@property (strong, nonatomic) UIImage *noNetWorkImage;
@property (assign, nonatomic) CGFloat vOffsetForEmptyList;
@property (strong, nonatomic) UIColor *titleColorForEmptyList;
@property (strong, nonatomic) UIFont *titleFontForEmptyList;
@property (strong, nonatomic) NSString *titleForEmptyList;
@property (strong, nonatomic) NSString *titleForNoNetwork;

+ (SFCommonConfig *)sharedConfig;

@end

NS_ASSUME_NONNULL_END
