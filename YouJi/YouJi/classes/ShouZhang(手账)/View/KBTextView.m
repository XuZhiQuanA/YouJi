//
//  KBTextView.m
//  YouJi
//
//  Created by dmt312 on 2019/12/9.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "KBTextView.h"

@implementation KBTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    XLog(@"KBTextView - touchesBegan");
    [self becomeFirstResponder];
}

@end
