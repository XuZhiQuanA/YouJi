//
//  WallPaperView.m
//  YouJi
//
//  Created by dmt312 on 2019/12/7.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "WallPaperView.h"

#define showPopImageViewY 139
#define showPopImageViewH 519 //554 - 519

#define scrollViewY 194
#define scrollViewH 464 //499

#define wallPaperBtnBaseX 31
#define wallPaperBtnBaseY 21
#define wallPaperBtnBaseW 80
#define wallPaperBtnBaseH 120
#define wallPaperBtnBaseSpaceX 56
#define wallPaperBtnBaseSpaceY 31

#define hiddenSelfBtnX 190
#define hiddenSelfBtnY 152
#define hiddenSelfBtnWH 35

#define colomn 3

@interface WallPaperView()

/** 展示弹框图的UIImageView*/
@property(nonatomic,readwrite,weak) UIImageView *showPopImageView;

/** 隐藏自己的按钮*/
@property(nonatomic,readwrite,weak) UIButton *hiddenSelfBtn;

/** 展示用scrollview*/
@property(nonatomic,readwrite,weak) UIScrollView *scrollView;

/** 壁纸按钮数组*/
@property(nonatomic,readwrite,strong) NSMutableArray *wallPaperArray;
    
@end

@implementation WallPaperView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        
        //初始化
        [self initialize];
    }
    
    return self;
    
}

//初始化
- (void)initialize{
    
    //自身view初始化
    [self initializeSelfView];
    
    //添加显示弹框图的UIImageView
    [self setupShowPopImageView];
    
    //隐藏自己的btn
    [self setupHiddenSelfBtn];
    
    //添加scrollview
    [self setupScrollView];
    
    //创建scrollview内部的按钮
    [self setupWallPaperBtn];
    
}

//自身view初始化
- (void)initializeSelfView{
    
    //本身view alpha whiteColor
//    self.alpha = 0.5;
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    self.hidden = true;
}

#pragma mark -----------------------------
#pragma mark 布局子控件

- (void)layoutSubviews{
    
//    布局本身子控件
    
    //showPopImageView
    self.showPopImageView.frame = CGRectMake(0, showPopImageViewY, ScreenW, showPopImageViewH);
    self.showPopImageView.image = [UIImage OriginalImageWithName:@"EditShouZhang_wallPagerPopBox_backgroundImage" toSize:self.showPopImageView.frame.size];
    
    //hiddenSelfBtn
    self.hiddenSelfBtn.frame = CGRectMake(hiddenSelfBtnX, hiddenSelfBtnY, hiddenSelfBtnWH, hiddenSelfBtnWH);
    [self.hiddenSelfBtn setImage:[UIImage OriginalImageWithName:@"EditShouZhang_wallPaperPopBox_towardBottomArrow" toSize:self.hiddenSelfBtn.frame.size] forState:UIControlStateNormal];
    
    //scrollView
    self.scrollView.frame = CGRectMake(0, scrollViewY, ScreenW, scrollViewH);
    self.scrollView.contentSize = CGSizeMake(0, scrollViewH+20);
    
    //壁纸按钮
    [self layoutWallPaperBtns];
    
}

- (void)layoutWallPaperBtns{
    
    CGFloat x = 0;
    CGFloat y = 0;
    NSInteger i = 0;
    for (UIButton *btn in self.wallPaperArray) {
        x = (btn.tag % colomn) * (wallPaperBtnBaseW + wallPaperBtnBaseSpaceX) + wallPaperBtnBaseX;
        y = (btn.tag / colomn) * (wallPaperBtnBaseH + wallPaperBtnBaseSpaceY) + wallPaperBtnBaseY;
        btn.frame = CGRectMake(x, y, wallPaperBtnBaseW, wallPaperBtnBaseH);
        btn.tag = (i+1);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage OriginalImageWithName:[NSString stringWithFormat:@"EditShouZhang_wallPaper_%ld",(long)i] toSize:btn.frame.size] forState:UIControlStateNormal];
        i++;
    }
    
}

#pragma mark -----------------------------
#pragma mark btnClick

- (void)btnClick:(UIButton *)btn{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:btn.currentImage forKey:@"wallPaper"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeWallPaper" object:nil userInfo:dict];

}

#pragma mark -----------------------------
#pragma mark touchBegan

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = touches.allObjects[0];
//    隐藏本身
    if (CGRectContainsPoint(self.showPopImageView.frame, [touch locationInView:self]) == false) {//如果点击的点不在在showPopImageView的frame里面
        self.hidden = true;
    }
    
}

#pragma mark -----------------------------
#pragma mark 添加显示弹框图的UIImageView
- (void)setupShowPopImageView{
    
    UIImageView *showPopImageView = [[UIImageView alloc] init];
    showPopImageView.userInteractionEnabled = true;
    [self addSubview:showPopImageView];
    self.showPopImageView = showPopImageView;
}

#pragma mark -----------------------------
#pragma mark 隐藏自己的按钮
- (void)setupHiddenSelfBtn{
    UIButton *btn = [[UIButton alloc] init];
    [btn addTarget:self action:@selector(hiddenSelf:) forControlEvents:UIControlEventTouchUpInside];
    self.hiddenSelfBtn = btn;
    [self addSubview:btn];
}

- (void)hiddenSelf:(UIButton *)btn{
    self.hidden = true;
}


#pragma mark -----------------------------
#pragma mark 添加scrollview
- (void)setupScrollView{
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
}


#pragma mark -----------------------------
#pragma mark 创建scrollview内部的按钮
- (void)setupWallPaperBtn{
    
    NSInteger count = 9;
    
    for (NSInteger i = 0; i < count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = i;
        [self.wallPaperArray addObject:btn];
        [self.scrollView addSubview:btn];
    }
    
}

#pragma mark -----------------------------
#pragma mark 懒加载
- (NSMutableArray *)wallPaperArray{
    if (_wallPaperArray == nil) {
        _wallPaperArray = [NSMutableArray array];
    }
    
    return _wallPaperArray;
}


@end
