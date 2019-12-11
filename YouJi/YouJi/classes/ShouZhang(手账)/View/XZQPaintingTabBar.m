//
//  XZQPaintingTabBar.m
//  YouJi
//
//  Created by dmt312 on 2019/12/9.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "XZQPaintingTabBar.h"
#import "XZQPopBoxView.h"
#import "XZQButton.h"

#define btnCount 3
#define colorBtnColomn 8
#define colorBtnLine 3
#define colorBtnCount 24

#define colorBtnBaseX 20
#define colorBtnBaseY 9
#define colorBtnBaseWH 28
#define colorBtnBaseSpaceX 11
#define colorBtnBaseSpaceY 8

#define paintColorPopBoxViewX 37
#define paintColorPopBoxViewY -118
#define paintColorPopBoxViewW 340
#define paintColorPopBoxViewH 118

@interface XZQPaintingTabBar()

/** 背景图*/
@property(nonatomic,readwrite,weak) UIImageView *backgroundImageView;

/** 装按钮的数组*/
@property(nonatomic,readwrite,strong) NSMutableArray *btnsArray;

/** 颜色框superView*/
@property(nonatomic,readwrite,weak) XZQPopBoxView *paintColorPopBoxView;

@end

@implementation XZQPaintingTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        //初始化
        [self initialize];
        
    }
    
    return self;
}

//添加按钮
- (void)initialize{
    
    self.backgroundColor = [UIColor redColor];
    
    //添加一个背景图
    [self setupBackgroundImageOfPaintingTabBar];
    
    //然后添加三个按钮
    [self addBtns];
    
    
}

//布局子控件
- (void)layoutSubviews{
    
    //backgroundImageView
    self.backgroundImageView.frame = self.bounds;
    
    //btns
    [self layoutBtns];
    
    
    XLog(@"XZQPaintingTabBar -- layoutSubviews");
}




#pragma mark -----------------------------
#pragma mark 添加画笔tabbar背景图
- (void)setupBackgroundImageOfPaintingTabBar{
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.bounds];
    imageV.backgroundColor = [UIColor yellowColor];
    [self addSubview:imageV];
    self.backgroundImageView = imageV;
}

#pragma mark -----------------------------
#pragma mark 给paintingTabBar添加按钮
- (void)addBtns{
    
    for (NSInteger i = 0; i < btnCount; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = (i+1);
        [self addSubview:btn];
        [self.btnsArray addObject:btn];
        
        switch (i) {
            case 0:
                [btn addTarget:self action:@selector(hidePaintingTabBarAndShowOrigionalTabBar) forControlEvents:UIControlEventTouchUpInside];
                break;
                
            case 1:
                [btn addTarget:self action:@selector(showPaintColorPopBox:) forControlEvents:UIControlEventTouchUpInside];
            break;
                
            case 2:
                [btn addTarget:self action:@selector(showPaintSizePopBox:) forControlEvents:UIControlEventTouchUpInside];
            break;
                
            default:
                break;
        }
    }
    
}

#pragma mark -----------------------------
#pragma mark 布局按钮
- (void)layoutBtns{
    
    for (UIButton *btn in self.btnsArray) {
        
        switch (btn.tag) {
                
            case 1:
                //从左向右数 按钮1 27 689-676 35 35
                btn.frame = CGRectMake(27, 13, 35, 35);
                [btn setImage:[UIImage OriginalImageWithName:@"EditShouZhang_innerIconOfbottomBar_pen_selected" toSize:btn.frame.size] forState:UIControlStateNormal];
                
                break;
                
            case 2:
                //按钮2 176 689-676 34 34
                btn.frame = CGRectMake(176, 13, 34, 34);//按钮隐藏掉在层级图中是看不见的 控件的alpha==0 在层级图中是可以看见的 是透明的
//                btn.alpha = 0;
                
            break;
                
            case 3:
                //按钮3 294 689-676 34 34
                btn.frame = CGRectMake(294, 13, 34, 34);

            break;
                
            default:
                break;
        }
        
        btn.backgroundColor = XRandomColor;
    }
    
    
}

#pragma mark -----------------------------
#pragma mark 隐藏画笔tabbar显示原来的tabbar
- (void)hidePaintingTabBarAndShowOrigionalTabBar{
    
    //隐藏画笔tabbar
    self.hidden = true;
    
    //显示原来的tabbar
    [[NSNotificationCenter defaultCenter] postNotificationName:@"XZQPaintingTabBarWantShowShowZhangTabBar" object:nil];
    XFunc;
}

#pragma mark -----------------------------
#pragma mark 展示选择画笔颜色的弹框
static NSInteger i = 0;

- (void)showPaintColorPopBox:(UIButton *)btn{

    
    if (i % 2 == 0)
        [self.paintColorPopBoxView showPopBoxColor:showPopBoxColor];
    else
        [self.paintColorPopBoxView showPopBoxColor:showPopBoxNone];
    
    i++;
    
    XFunc;
}


#pragma mark -----------------------------
#pragma mark 展示选择画笔大小的弹框

static NSInteger j = 0;

- (void)showPaintSizePopBox:(UIButton *)btn{

    if (j % 2 == 0)
        [self.paintColorPopBoxView showPopBoxSize:showPopBoxSize];
    else
        [self.paintColorPopBoxView showPopBoxSize:showPopBoxNone];
    
    j++;
    
    XFunc;
    
}






#pragma mark -----------------------------
#pragma mark 展示出颜色框和大小框
- (void)showPopBox{
    XFunc;
    //根据paintColorPopBoxView的展示状态显示出对应的框
    switch (self.paintColorPopBoxView.showState) {
            
        case showPopBoxNone:
            XLog(@"showPopBoxNone");
            break;
            
        case showPopBoxColor:
            XLog(@"showPopBoxColor");
//            self.paintColorPopBoxView.backgroundColor = [UIColor grayColor];
        break;
            
        case showPopBoxSize:
            XLog(@"showPopBoxSize");
        break;
            
        default:
            XLog(@"default");
            break;
    }
    
}


#pragma mark -----------------------------
#pragma mark hitTest
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
   
    XFunc;
    
    UIView *view = [super hitTest:point withEvent:event];
    
    if (view == nil) {
            //转换坐标系
        CGPoint newPoint = [self.paintColorPopBoxView convertPoint:point fromView:self];
            //判断触摸点是否在button上
        if (CGRectContainsPoint(self.paintColorPopBoxView.bounds, newPoint)) {
            view = self.paintColorPopBoxView;
        }
        //NSLog(@"point:%@ : newPoint:%@",NSStringFromCGPoint(point),NSStringFromCGPoint(newPoint));
    }
    
    return view;

    
    
}


#pragma mark -----------------------------
#pragma mark lazy load
- (NSMutableArray *)btnsArray{
    
    if (_btnsArray == nil) {
        _btnsArray = [NSMutableArray array];
    }
    
    return _btnsArray;
}

- (XZQPopBoxView *)paintColorPopBoxView{
    if (_paintColorPopBoxView == nil) {
        XZQPopBoxView *paintColorPopBoxView = [[XZQPopBoxView alloc] initWithFrame:CGRectMake(paintColorPopBoxViewX, paintColorPopBoxViewY, paintColorPopBoxViewW, paintColorPopBoxViewH)];
        paintColorPopBoxView.backgroundColor = [UIColor redColor];
        [self addSubview:paintColorPopBoxView];
        _paintColorPopBoxView = paintColorPopBoxView;
    }
    
    return _paintColorPopBoxView;
}


@end
