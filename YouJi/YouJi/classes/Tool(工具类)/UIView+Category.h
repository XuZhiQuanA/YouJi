//
//  UIView+Category.h
//  YouJi
//
//  Created by dmt312 on 2019/12/4.
//  Copyright © 2019 XZQ. All rights reserved.
//




#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Category)
/**
 快速访问一个控件的尺寸和位置
 */

- (CGFloat)getPosition_x;
- (CGFloat)getPosition_y;
- (CGFloat)getPosition_width;
- (CGFloat)getPosition_height;

- (void)setPosition_x:(CGFloat)x;
- (void)setPosition_y:(CGFloat)y;
- (void)setPosition_width:(CGFloat)width;
- (void)setPosition_height:(CGFloat)height;
@end

NS_ASSUME_NONNULL_END
