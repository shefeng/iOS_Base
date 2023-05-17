//
//  SFBaseCollectionViewCell.m
//  iOS_Base
//
//  Created by shefeng on 2023/5/15.
//

#import "SFBaseCollectionViewCell.h"

@implementation SFBaseCollectionViewCell

//重用标识符
+ (NSString *)reuseIdentifier{
    return [NSString stringWithFormat:@"k%@ID",NSStringFromClass([self class])];
}

@end
