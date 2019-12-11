//
//  PaintingView.h
//  YouJi
//
//  Created by dmt312 on 2019/12/9.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface PaintingView : UIView
//清屏
- (void)clear;
//撤销
- (void)undo;
//橡皮擦
- (void)erase;
//设置线的宽度
- (void)setLineWith:(CGFloat)lineWidth;
//设置线的颜色
- (void)setLineColor:(UIColor *)color;

/** 要绘制的图片 */
@property (nonatomic, strong) UIImage * image;

//上一步
- (void)returnLastStep;

//下一步
- (void)returnNextStep;

//- (void)saveScreenShot;

@end

NS_ASSUME_NONNULL_END
