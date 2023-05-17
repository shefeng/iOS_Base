//
//  SFBaseTableViewCell.m
//  iOS_Base
//
//  Created by shefeng on 2023/5/15.
//

#import "SFBaseTableViewCell.h"

@implementation SFBaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//重用标识符
+ (NSString *)reuseIdentifier{
    return [NSString stringWithFormat:@"k%@ID",NSStringFromClass([self class])];
}

@end
