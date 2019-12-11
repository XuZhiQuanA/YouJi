//
//  UIView+Category.m
//  YouJi
//
//  Created by dmt312 on 2019/12/4.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "UIView+Category.h"




@implementation UIView (Category)
//get方法
- (CGFloat)getPosition_x{
    return self.frame.origin.x;
}
- (CGFloat)getPosition_y{
    return self.frame.origin.y;
}
- (CGFloat)getPosition_width{
    return self.frame.size.width;
}
- (CGFloat)getPosition_height{
    return self.frame.size.height;
}



//set方法
- (void)setPosition_x:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setPosition_y:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setPosition_width:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setPosition_height:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
@end
