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

@end

@implementation XZQNavigationView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //添加子控件
        [self setupChild];
        
        [self btnClick:self.previousClickedButton];
    }
    
    return self;
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
}

- (void)btnClick:(XZQOnlyLabelButton *)btn{
    
    XFunc;
    
    //三部曲
    self.previousClickedButton.selected = NO;
    btn.selected = YES;
    self.previousClickedButton = btn;
    XFunc;
}


@end
