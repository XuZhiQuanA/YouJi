//
//  XZQNoHighlightedButton.m
//  YouJi
//
//  Created by dmt312 on 2019/12/4.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "XZQNoHighlightedButton.h"

@implementation XZQNoHighlightedButton

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    self.showYearImage = !self.showYearImage;
    
}


- (void)setHighlighted:(BOOL)highlighted{
    
}

@end
