//
//  XZQShowZhangScrollView.m
//  YouJi
//
//  Created by dmt312 on 2019/12/5.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "XZQShowZhangScrollView.h"

const CGFloat btnBaseX = 22;
const CGFloat btnBaseY = 253;
const NSInteger column = 2;

const CGFloat btnW = 176;
const CGFloat btnH = 270;
const CGFloat btnXSpace = 18;
const CGFloat btnYSpace = 33;

@interface XZQShowZhangScrollView()

@property(nonatomic,readwrite,weak) UIImageView *topImageView;

@property(nonatomic,readwrite,strong) NSMutableArray *btnArray;

@end

@implementation XZQShowZhangScrollView

#pragma mark -----------------------------
#pragma mark 懒加载
- (NSMutableArray *)btnArray{
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    
    return _btnArray;
}




- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //设置子控件
        [self setupChild];
    }
    
    return self;
}

//设置子控件
- (void)setupChild{
    
    
    
    //1. 加入上面的UIImageView
    UIImageView *topImageView = [[UIImageView alloc] init];
    topImageView.backgroundColor = XRandomColor;
    [self addSubview:topImageView];
    self.topImageView = topImageView;
    
    //2. 下面的按钮
    for (NSInteger i = 0; i<6; i++) {
        UIButton *btn = [[UIButton alloc] init];
        [btn addTarget:self action:@selector(popNewContent:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        [self addSubview:btn];
        [self.btnArray addObject:btn];
    }
}

- (void)layoutSubviews{
    
    XFunc;
    
    
    self.topImageView.frame = CGRectMake(0, XZQNavigationViewH, self.bounds.size.width, XZQShouZhangImageViewH);
    self.topImageView.image = [UIImage OriginalImageWithName:@"ShouZhang_Top" toSize:self.topImageView.bounds.size];
    
    
    
    for (UIButton *btn in self.btnArray) {
        
        CGFloat x = (btn.tag % column) * (btnW + btnXSpace) + btnBaseX;
        CGFloat y = (btn.tag / column) * (btnH + btnYSpace) + btnBaseY;
        
        btn.frame = CGRectMake(x, y, btnW, btnH);
        [btn setBackgroundImage:[UIImage OriginalImageWithName:[NSString stringWithFormat:@"ShouZhang_btn_background_%ld",btn.tag] toSize:btn.bounds.size] forState:UIControlStateNormal];
        
        [self addSubview:btn];
    }
    
    
    
    
}

#pragma mark -----------------------------
#pragma mark 监听按钮点击
- (void)popNewContent:(UIButton *)btn{
    
    XFunc;
    
    self.index = [self.btnArray indexOfObject:btn];
    [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"popNewContent_%ld",btn.tag] object:nil];
    
}


@end
