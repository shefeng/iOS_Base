//
//  SFCommonConfig.m
//  iOS_Base
//
//  Created by shefeng on 2023/5/15.
//

#import "SFCommonConfig.h"
#import "SFMacroDefinition.h"

@implementation SFCommonConfig

+ (SFCommonConfig *)sharedConfig {
    static dispatch_once_t once;
    static SFCommonConfig *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[SFCommonConfig alloc] init];
    });
    return sharedInstance;
}

- (UIColor *)navBgColor{
    if(!_navBgColor){
        _navBgColor = kColorWhite;
    }
    return _navBgColor;
}

- (UIColor *)navTitleColor{
    if(!_navTitleColor){
        _navTitleColor = kColor333;
    }
    return _navTitleColor;
}

- (UIFont *)navTitleFont{
    if(!_navTitleFont){
        _navTitleFont = kFont_PF_Regular(18);
    }
    return _navTitleFont;
}

- (UIImage *)navBackImage{
    if(!_navBackImage){
        _navBackImage = [UIImage imageNamed:@""];
    }
    return _navBackImage;
}

- (UIColor *)vcBgColor{
    if(!_vcBgColor){
        _vcBgColor = kColorWhite;
    }
    return _vcBgColor;
}

- (UIImage *)noDataImage{
    if(!_noDataImage){
        _noDataImage = [UIImage imageNamed:@""];
    }
    return _noDataImage;
}

- (UIImage *)noNetWorkImage{
    if(!_noNetWorkImage){
        _noNetWorkImage = [UIImage imageNamed:@""];
    }
    return _noNetWorkImage;
}

- (UIColor *)titleColorForEmptyList{
    if(!_titleColorForEmptyList){
        _titleColorForEmptyList = kColor333;
    }
    return _titleColorForEmptyList;
}

- (UIFont *)titleFontForEmptyList{
    if(!_titleFontForEmptyList){
        _titleFontForEmptyList = kFont_PF_Regular(15);
    }
    return _titleFontForEmptyList;
}

- (NSString *)titleForEmptyList{
    if(!_titleForEmptyList){
        _titleForEmptyList = @"暂无数据";
    }
    return _titleForEmptyList;
}

- (NSString *)titleForNoNetwork{
    if(!_titleForNoNetwork){
        _titleForNoNetwork = @"网络异常,请稍后再试!";
    }
    return _titleForNoNetwork;
}

@end
