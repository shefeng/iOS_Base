//
//  SFViewController.m
//  iOS_Base_Example
//
//  Created by 金桔科技 on 2023/5/19.
//  Copyright © 2023 shefeng. All rights reserved.
//

#import "SFViewController.h"
#import <Masonry/Masonry.h>

@interface SFViewController ()<UITextViewDelegate>

@property(strong, nonatomic) UITextView *textView;

@end

@implementation SFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setTheLayoutOfBlurViewThroughMasonry];
}

- (void)setTheLayoutOfBlurViewThroughMasonry {
    [self.view addSubview:self.textView];
    
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-20);
        make.top.offset(100);
        make.height.mas_equalTo(275);
    }];
    
    self.textView.layer.borderColor= [UIColor blackColor].CGColor;
    self.textView.layer.borderWidth = .5;
}

- (void)addGestureRecognizer:(UIGestureRecognizer*)gestureRecognizer
{
    if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]])
    {
        [self.view layoutIfNeeded];
        UITextView* textView = (UITextView*)gestureRecognizer.view;
        CGPoint tapLocation = [gestureRecognizer locationInView:textView];
        UITextPosition *textPosition = [textView closestPositionToPoint:tapLocation];
        UITextRange *range = [textView characterRangeAtPoint:tapLocation];
        
    
            
        NSDictionary *attributes = [textView textStylingAtPosition:textPosition inDirection:UITextStorageDirectionForward];
        UIColor *color = attributes[NSForegroundColorAttributeName];
        
        textView.layoutManager.allowsNonContiguousLayout = YES;
        NSLayoutManager *layoutManager = textView.layoutManager;
        CGPoint location = [gestureRecognizer locationInView:textView];


        location.x -= textView.textContainerInset.left;
        location.y -= textView.textContainerInset.top;

        NSUInteger characterIndex = [layoutManager characterIndexForPoint:location
                                                   inTextContainer:textView.textContainer
                          fractionOfDistanceBetweenInsertionPoints:NULL];
//        self.textView.scrollEnabled = YES;
    }
}

- (UITextView *)textView {
    if (!_textView) {
        _textView = [UITextView new];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.editable = false;
        _textView.selectable = false;
        _textView.textColor = [UIColor blackColor];
        _textView.showsVerticalScrollIndicator = false;
        NSString *text = @"欢迎使用“智慧科协”，请您了解，在您使用应用时，部分服务需要您注册成为“智慧科协”用户后方可使用，有关注册，您可以通过《用户协议》详细了解我们为您提供的服务，请您在使用我们的服务前仔细阅读《隐私政策》全文，并充分理解。\n请您登录应用或授权应用使用权限时，审慎阅读并选择接受或不接受《用户协议》和《隐私条款》。除非您接受用户协议和隐私条款所有条款，否则您无权注册、登录或使用协议和条款中所涉服务。您的注册、登录、使用等行为将视为对《用户协议》和《隐私条款》的接受，并同意接受用户协议和隐私条款各项条款的约束。\n在您点击同意之前，请务必审慎阅读并充分理解用户协议和隐私条款内容。欢迎使用“智慧科协”，请您了解，在您使用应用时，部分服务需要您注册成为“智慧科协”用户后方可使用，有关注册，您可以通过《用户协议》详细了解我们为您提供的服务，请您在使用我们的服务前仔细阅读《隐私政策》全文，并充分理解。\n请您登录应用或授权应用使用权限时，审慎阅读并选择接受或不接受《用户协议》和《隐私条款》。除非您接受用户协议和隐私条款所有条款，否则您无权注册、登录或使用协议和条款中所涉服务。您的注册、登录、使用等行为将视为对《用户协议》和《隐私条款》的接受，并同意接受用户协议和隐私条款各项条款的约束。\n在您点击同意之前，请务必审慎阅读并充分理解用户协议和隐私条款内容。";
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:text];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(59, 6)];
        [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(94, 6)];
//        [attributeString addAttribute:NSFontAttributeName value:[UIColor redColor] range:NSMakeRange(0, text.length)];
        _textView.attributedText = attributeString;
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addGestureRecognizer:)];
        [_textView addGestureRecognizer:tapRecognizer];
    }
    return _textView;
}

@end
