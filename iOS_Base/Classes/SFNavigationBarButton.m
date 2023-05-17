//
//  SFNavigationBarButton.m
//  iOS_Base
//
//  Created by shefeng on 2023/5/15.
//

#import "SFNavigationBarButton.h"

@implementation SFNavigationBarButton

- (void)actionWith:(actionBlock)actionBlock{
    self.actionBlock = actionBlock;
    [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)action:(UIButton *)sender{
    if(self.actionBlock){
        self.actionBlock();
    }
}

@end
