//
//  XZQButton.m
//  YouJi
//
//  Created by dmt312 on 2019/12/11.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "XZQButton.h"

@implementation XZQButton

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.flag = !self.flag;
    
    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    if (CGRectContainsPoint(self.bounds, point)) {
        return self;
    }
        
    return [super hitTest:point withEvent:event];
}

@end
