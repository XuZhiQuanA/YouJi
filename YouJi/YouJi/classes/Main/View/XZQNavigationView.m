//
//  XZQNavigationView.m
//  YouJi
//
//  Created by dmt312 on 2019/12/4.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "XZQNavigationView.h"
#import "XZQOnlyLabelButton.h"

@interface XZQNavigationView()

/**之前选中的按钮 */
@property(nonatomic,readwrite,strong) XZQOnlyLabelButton *previousClickedButton;

@property(nonatomic,readwrite,weak) XZQOnlyLabelButton *shouBtn;

@end

@implementation XZQNavigationView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //添加子控件
        [self setupChild];
        
        [self btnClick:self.previousClickedButton];
        
        //监听通知
        [self receiveNotification];
       
    }
    
    return self;
}

- (void)setIndex:(NSInteger)index{
    _index = index;
    
    XZQOnlyLabelButton *btn = [self viewWithTag:(index+1)];
    
    [self btnClick:btn];
}

#pragma mark -----------------------------
#pragma mark 添加子控件
- (void)setupChild{
    
    //视频按钮
    XZQOnlyLabelButton *videoBtn = [[XZQOnlyLabelButton alloc] initWithFrame:CGRectMake(97, 8, 50, 35) Title:@"视频"];
    videoBtn.tag = 1;
    [videoBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:videoBtn];
    
    self.previousClickedButton = videoBtn;
    
    
    //手账按钮
    XZQOnlyLabelButton *shouBtn = [[XZQOnlyLabelButton alloc] initWithFrame:CGRectMake(267, 8, 50, 35) Title:@"手账"];
    shouBtn.tag = 2;
    [shouBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:shouBtn];
    self.shouBtn = shouBtn;
}

- (void)btnClick:(XZQOnlyLabelButton *)btn{
    
    
    //三部曲
    self.previousClickedButton.selected = NO;
    btn.selected = YES;
    self.previousClickedButton = btn;
    
    switch (btn.tag) {
        case 1:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shipin" object:nil];
            break;
            
        case 2:
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shouzhang" object:nil];
        break;
            
        default:
            break;
    }
    
}

#pragma mark -----------------------------
#pragma mark receiveNotification
- (void)receiveNotification{
    //clickShouZhangBtn
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickShouZhangBtn) name:@"clickShouZhangBtn" object:nil];
}

- (void)clickShouZhangBtn{
    [self btnClick:self.shouBtn];
}



@end
