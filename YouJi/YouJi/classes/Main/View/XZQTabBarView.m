//
//  XZQTabBarView.m
//  YouJi
//
//  Created by dmt312 on 2019/12/4.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "XZQTabBarView.h"
#import "XZQTopImageBottomLabelButton.h"
#import "XZQNoHighlightedButton.h"

@interface XZQTabBarView()

/** 背景图*/
@property(nonatomic,readwrite,weak) UIImageView *backGroundImageView;

/**之前选中的按钮 */
@property(nonatomic,readwrite,strong) XZQTopImageBottomLabelButton *previousClickedButton;

@end

@implementation XZQTabBarView

#pragma mark -----------------------------
#pragma mark 初始化

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //添加子控件
        [self setupChild];
        
        [self btnClick:self.previousClickedButton];
        
        //监听通知 XZQTabBarControllerWantXZQTabBarViewClickMiddleBtn
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(XZQTabBarControllerClickMiddleBtn) name:@"XZQTabBarControllerWantXZQTabBarViewClickMiddleBtn" object:nil];
        
    }
    
    return self;
}

- (void)setBackGroundImage:(UIImage *)backGroundImage{
    _backGroundImage = backGroundImage;
    
    self.backGroundImageView.image = backGroundImage;
}

#pragma mark -----------------------------
#pragma mark 懒加载
- (UIImageView *)backGroundImageView{
    if (_backGroundImageView == nil) {
        
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:self.bounds];
        _backGroundImageView = imageV;
        [self addSubview:_backGroundImageView];
    }
    
    return _backGroundImageView;
}


#pragma mark -----------------------------
#pragma mark 添加子控件

- (void)setupChild{
    
    //背景图
    [self bringSubviewToFront:self.backGroundImageView];
    
    //大家按钮
    XZQTopImageBottomLabelButton *weBtn = [[XZQTopImageBottomLabelButton alloc] initWithFrame:CGRectMake(70, 29, 31, 55) Title:@"大家" NormalImage:[UIImage OriginalImageWithName:@"We" toSize:CGSizeMake(31, 34)] SelectedImage:[UIImage OriginalImageWithName:@"WeSelected" toSize:CGSizeMake(31, 34)]];
    weBtn.tag = 1;
    [weBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:weBtn];
    
    self.previousClickedButton = weBtn;
    
    //中间按钮
    XZQNoHighlightedButton *middleBtn = [[XZQNoHighlightedButton alloc] initWithFrame:CGRectMake(179, 9, 56, 56)];
    [middleBtn setBackgroundImage:[UIImage OriginalImageWithName:@"plus" toSize:CGSizeMake(56, 56)] forState:UIControlStateNormal];
    middleBtn.tag = 2;
    [middleBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:middleBtn];
    
    //我的按钮
    XZQTopImageBottomLabelButton *myBtn = [[XZQTopImageBottomLabelButton alloc] initWithFrame:CGRectMake(313, 29, 31, 55) Title:@"我的" NormalImage:[UIImage OriginalImageWithName:@"My" toSize:CGSizeMake(31, 34)] SelectedImage:[UIImage OriginalImageWithName:@"My_Selected" toSize:CGSizeMake(31, 34)]];
    myBtn.tag = 3;
    [myBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:myBtn];
    
    
}

#pragma mark -----------------------------
#pragma mark 监听按钮点击
- (void)btnClick:(XZQTopImageBottomLabelButton *)btn{
    
    if (btn.tag != 2) {
        //三部曲
        self.previousClickedButton.selected = NO;
        btn.selected = YES;
        self.previousClickedButton = btn;
    }
    
    XFunc;
    
    switch (btn.tag) {
        case 1:
            //    由XZQTabBarController接收通知
            [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"XZQTabBarViewPostToChangeXZQTabBarControllerCurrentShowedChildControllerView_We"] object:nil];
            break;
            
        case 2:
            [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"XZQTabBarViewPostToChangeXZQTabBarControllerCurrentShowedChildControllerView_Middle"] object:nil];
        break;
            
        case 3:
            [[NSNotificationCenter defaultCenter] postNotificationName:[NSString stringWithFormat:@"XZQTabBarViewPostToChangeXZQTabBarControllerCurrentShowedChildControllerView_My"] object:nil];
        break;
            
        default:
            break;
    }
    

    
}

#pragma mark -----------------------------
#pragma mark XZQTabBarController 点击middleBtn
- (void)XZQTabBarControllerClickMiddleBtn{
    XZQTopImageBottomLabelButton *btn = [self viewWithTag:2];
    [self btnClick:btn];
}



@end
