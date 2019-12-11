//
//  XZQPopBoxView.m
//  YouJi
//
//  Created by dmt312 on 2019/12/10.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "XZQPopBoxView.h"

#define btnCount 3
#define colorBtnColomn 8
#define colorBtnLine 3
#define colorBtnCount 24

#define colorBtnBaseX 20
#define colorBtnBaseY 9
#define colorBtnBaseWH 28
#define colorBtnBaseSpaceX 11
#define colorBtnBaseSpaceY 8

#define sizePopBoxY 71
#define sizePopBoxH 48

#define sizeBtnCount 7

#define sizeBtnBaseX 72
#define sizeBtnBaseY 23


@interface XZQPopBoxView()

/** 背景图片*/
@property(nonatomic,readwrite,weak) UIImageView *backgroundImageView;

/** 颜色框的superView*/
@property(nonatomic,readwrite,weak) UIView *colorBoxSuperView;

/** 大小框的superView*/
@property(nonatomic,readwrite,weak) UIView *sizeBoxSuperView;

@end

@implementation XZQPopBoxView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
            
        //初始化
        [self initialize];
    
    }
    
    return self;
}

- (void)initialize{
    
    self.backgroundColor = [UIColor redColor];
    
    //创建颜色弹框
    [self setupColorPopBox];
    
    //创建大小弹框
    [self setupSizePopBox];
}

- (void)setupColorPopBox{
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
    view.backgroundColor = [UIColor yellowColor];
    view.hidden = true;
    [self addSubview:view];
    self.colorBoxSuperView = view;
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.bounds];
    imageV.tag = 1;
    [view addSubview:imageV];
    self.backgroundImageView = imageV;
    
    //布局内部颜色按钮
    for (NSInteger i = 0; i < colorBtnCount; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = XRandomColor;
        btn.tag = (i+2);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger x = colorBtnBaseX + (i % colorBtnColomn) * (colorBtnBaseWH + colorBtnBaseSpaceX);
        NSInteger y = colorBtnBaseY + (i / colorBtnColomn) * (colorBtnBaseWH + colorBtnBaseSpaceY);
        
        btn.frame = CGRectMake(x, y, colorBtnBaseWH, colorBtnBaseWH);
        
        [view addSubview:btn];
        
    }
}

- (void)setupSizePopBox{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, sizePopBoxY, self.bounds.size.width, sizePopBoxH)];
    view.hidden = true;
    [self addSubview:view];
    self.sizeBoxSuperView = view;
    
    for (NSInteger i = 0; i<sizeBtnCount; i++) {
        
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = (i+28);
        btn.backgroundColor = XRandomColor;
        [view addSubview:btn];
        
        switch (i) {
            case 0:
                btn.frame = CGRectMake(35, 23, 4, 4);
                break;
            case 1:
                btn.frame = CGRectMake(69, 22, 6, 6);
                break;
                
            case 2:
                btn.frame = CGRectMake(105, 20, 9, 9);
                break;
                
            case 3:
                btn.frame = CGRectMake(144, 19, 12, 12);
                break;
            case 4:
                btn.frame = CGRectMake(186, 17, 15, 15);
                break;
                
            case 5:
                btn.frame = CGRectMake(231, 15, 20, 20);
                break;
                
            case 6:
                btn.frame = CGRectMake(281, 12, 25, 25);
                break;
            
                
            default:
                break;
        }
    }
    
    
}


- (void)showPopBoxColor:(showPopBox)state{
    
    if (state == showPopBoxColor)
        self.hidden = false;
    else
        self.hidden = true;
    
    [self showPopBoxColor];

    
        
    
}

- (void)showPopBoxSize:(showPopBox)state{
    
    if (state == showPopBoxSize)
        self.hidden = false;
    else
        self.hidden = true;
    
    [self showPopBoxSize];
    
    
    
}




- (void)showPopBoxColor{
    
    if (self.sizeBoxSuperView.hidden == false)
        self.sizeBoxSuperView.hidden = true;
    
    self.colorBoxSuperView.hidden = self.colorBoxSuperView.hidden == true ? false : true;
    
//    self.hidden = self.colorBoxSuperView.hidden;

    if (self.colorBoxSuperView.hidden == true)
        self.hidden = self.colorBoxSuperView.hidden;
        
    
}

- (void)showPopBoxSize{
    if (self.colorBoxSuperView.hidden == false)
        self.colorBoxSuperView.hidden = true;
    self.sizeBoxSuperView.hidden = self.sizeBoxSuperView.hidden == true ? false : true;
//    self.hidden = self.sizeBoxSuperView.hidden;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    XLog(@"XZQPopBoxView - touchesBegan");
    
    UITouch *touch = touches.allObjects[0];
    
    CGPoint point = [touch locationInView:self];
    
    UIView *view = [self hitTest:point withEvent:event];
    
    XLog(@"%ld",(long)view.tag);
    
    if (view.tag > 2 && view.tag < 35) {
        
        //颜色btn
        UIButton *btn = (UIButton *)view;
        [self btnClick:btn];
        
//    }else if (view.tag > 28 && view.tag < 35){
//
//        //大小btn
//        UIButton *btn = (UIButton *)view;
//        [self btnClick:btn];
    }

}

#pragma mark -----------------------------
#pragma mark 按钮点击
- (void)btnClick:(UIButton *)btn{
    
//    if (btn.tag > 2 && btn.tag < 27 ) {//颜色按钮
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[NSString stringWithFormat:@"%ld",btn.tag] forKey:@"TagOfBtn"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"XZQPopBoxViewWantChangeColorAndSizeOfPen" object:nil userInfo:dict];
//    }else if (btn.tag > 28 && btn.tag < 35){
//
//    }
    
    XFunc;
}


#pragma mark -----------------------------
#pragma mark hitTest

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    
    XFunc;
    
    UIView *view = [super hitTest:point withEvent:event];
    
    if (view == nil) {
            //转换坐标系
        CGPoint newPoint = [self.colorBoxSuperView convertPoint:point fromView:self];
            //判断触摸点是否在button上
        if (CGRectContainsPoint(self.colorBoxSuperView.bounds, newPoint)) {
            view = self.colorBoxSuperView;
        }
        //NSLog(@"point:%@ : newPoint:%@",NSStringFromCGPoint(point),NSStringFromCGPoint(newPoint));
    }
    
    return view;
    
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//
//    XFunc;
//
//    //1.判断自己能否接收事件
//    if (self.userInteractionEnabled == NO || self.hidden == YES || self.alpha <= 0.01) {
//        //不能接收事件
//        return nil;
//    }
//    //2.点在不在自己身上
//    if (![self pointInside:point withEvent:event]) {
//        return nil;
//    }
//
//    //3.从后往前遍历自己的子控件,把事件传递给子控件,调用子控件的hitTest,
//    int count = (int)self.subviews.count;
//
//    for (int i = count - 1; i >= 0; i--) {
//
//        //获取子控件
//        UIView *childView = self.subviews[i];
//
//        //把当前点的坐标系转换成子控件的坐标系
//        CGPoint childP = [self convertPoint:point toView:childView];
//
//        UIView *fitView = [childView hitTest:childP withEvent:event];
//
//        if (fitView) {
//            return fitView;
//        }
//
//    }
//    //4.如果子控件没有找到最适合的View,那么自己就是最适合的View.
//    return self;
//
//}




@end
