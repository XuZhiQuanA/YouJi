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
    
    self.backgroundColor = [UIColor clearColor];
    
    //创建颜色弹框
    [self setupColorPopBox];
    
    //创建大小弹框
    [self setupSizePopBox];
}

- (void)setupColorPopBox{
    
    UIView *view = [[UIView alloc] initWithFrame:self.bounds];
//    view.backgroundColor = [UIColor yellowColor];
    view.hidden = true;
    [self addSubview:view];
    self.colorBoxSuperView = view;
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.bounds];
    imageV.image = [UIImage OriginalImageWithName:@"EditShouZhang_paint_colorPopBoxBackground" toSize:imageV.bounds.size];
    imageV.tag = 1;
    [view addSubview:imageV];
    self.backgroundImageView = imageV;
    
    //布局内部颜色按钮
    for (NSInteger i = 0; i < colorBtnCount; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.layer.cornerRadius = 7.0;
        
        btn.backgroundColor = [self backgroundColorOfEachPaint:i];
        
        btn.tag = (i+2);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        NSInteger x = colorBtnBaseX + (i % colorBtnColomn) * (colorBtnBaseWH + colorBtnBaseSpaceX);
        NSInteger y = colorBtnBaseY + (i / colorBtnColomn) * (colorBtnBaseWH + colorBtnBaseSpaceY);
        
        btn.frame = CGRectMake(x, y, colorBtnBaseWH, colorBtnBaseWH);
        
        [view addSubview:btn];
        
    }
}

#pragma mark -----------------------------
#pragma mark 返回本项目中each画笔的背景颜色
- (UIColor *)backgroundColorOfEachPaint:(NSInteger)tag{
    
    UIColor *color;
    
    switch (tag) {
        case 0:
            color = XColor(0, 0,0);
            break;
        case 1:
            color = XColor(209, 180, 122);
            break;
        case 2:
            color = XColor(159, 140, 122);
            break;
        case 3:
            color = XColor(114, 113, 113);
            break;
            
        case 4:
            color = XColor(69, 159, 227);
            break;
            
        case 5:
            color = XColor(109, 191, 235);
            break;
            
        case 6:
            color = XColor(147, 182, 221);
            break;
            
        case 7:
            color = XColor(96, 114, 177);
            break;
            
        case 8:
            color = XColor(211, 45, 38);
            break;
        
        case 9:
            color = XColor(221, 119, 135);
            break;
            
        case 10:
            color = XColor(220, 119, 165);
            break;
            
        case 11:
            color = XColor(235, 183, 179);
            break;
            
        case 12:
            color = XColor(183, 213, 170);
            break;
            
        case 13:
            color = XColor(153, 192, 67);
            break;
            
        case 14:
            color = XColor(64, 142, 69);
            break;
            
        case 15:
            color = XColor(144, 192, 114);
            break;
            
        case 16:
            color = XColor(246, 237, 82);
            break;
        case 17:
            color = XColor(242, 242, 178);
            break;
        case 18:
            color = XColor(238, 183, 76);
            break;
        case 19:
            color = XColor(229, 148, 90);
            break;
            
        case 20:
            color = XColor(169, 148, 192);
            break;
            
        case 21:
            color = XColor(167, 175, 213);
            break;
            
        case 22:
            color = XColor(172, 213, 215);
            break;
            
        case 23:
            color = XColor(95, 154, 149);
            break;
            
            
        
            
        default:
            break;
    }
    
    return color;
}


- (void)setupSizePopBox{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, sizePopBoxY, self.bounds.size.width, sizePopBoxH)];
    view.hidden = true;
    [self addSubview:view];
    self.sizeBoxSuperView = view;
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:view.bounds];
    imageV.image = [UIImage OriginalImageWithName:@"EditShouZhang_paint_sizePopBoxBackground" toSize:imageV.bounds.size];
    imageV.tag = 2;
    [view addSubview:imageV];
    
    for (NSInteger i = 0; i<sizeBtnCount; i++) {
        
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = (i+28);
        btn.backgroundColor = XColor(187, 187, 187);
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
        
        btn.layer.cornerRadius = btn.frame.size.width*0.5;
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
