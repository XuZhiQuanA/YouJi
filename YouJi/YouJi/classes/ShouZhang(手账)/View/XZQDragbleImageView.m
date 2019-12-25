//
//  XZQDragbleImageView.m
//  YouJi
//
//  Created by dmt312 on 2019/12/24.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "XZQDragbleImageView.h"

@implementation XZQDragbleImageView

- (instancetype)init{
    self = [super init];
    
    if (self) {
        
        [self initialize];
        
    }
    
    return self;
}


#pragma mark -----------------------------
#pragma mark 初始化
- (void)initialize{
    
    //0.允许进行交互
    self.userInteractionEnabled = true;
    //1.添加手势
    [self addGesture];
}

#pragma mark -----------------------------
#pragma mark 添加手势
- (void)addGesture{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    //rotate
    UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    [self addGestureRecognizer:rotate];
    
    //
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [self addGestureRecognizer:pinch];
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    
    CGPoint curPoint = [pan translationInView:pan.view];
    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, curPoint.x, curPoint.y);
    
    [pan setTranslation:CGPointZero inView:pan.view];
    
    XFunc;
}

- (void)rotate:(UIRotationGestureRecognizer *)rotate{
    rotate.view.transform = CGAffineTransformRotate(rotate.view.transform, rotate.rotation);
    //复位
    rotate.rotation = 0.0;
    XFunc;
}

- (void)pinch:(UIPinchGestureRecognizer *)pinch{
    CGFloat scale = pinch.scale;
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, scale, scale);
    pinch.scale = 1.0;
    XFunc;
}

#pragma mark -----------------------------
#pragma mark 允许多个手势

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return true;
}



@end
