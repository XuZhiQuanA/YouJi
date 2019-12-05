//
//  XZQTabBarController.m
//  test
//
//  Created by dmt312 on 2019/12/3.
//  Copyright © 2019 xzq. All rights reserved.
//

#import "XZQTabBarController.h"

#import "WeViewController.h"
#import "MyViewController.h"

#import "XZQTabBarView.h"
#import "XZQNavigationView.h"

#import "XZQMySettingView.h"

@interface XZQTabBarController ()

/**我的-设置界面 用于占位的父视图 位于界面的右边 设置界面*/
@property(nonatomic,readwrite,weak) XZQMySettingView *placeHolderRightSuperView;

/** 底部弹出的view*/
@property(nonatomic,readwrite,weak) UIView *bottomPopView;

/** 旋转按钮*/
@property(nonatomic,readwrite,weak) UIButton *rotateBtn;

@end

@implementation XZQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.加载子控制器
    [self setupAllChildViewControllers];
    
    //2.隐藏系统tabbar
    [self hiddenSystemTabBar];
    
    //3.设置上下view
    [self setupTopAndBottomView];
    
    //4.接收通知
    [self addNotification];
    
    //5.我的-设置界面
    [self setupMySettingView];
    
    //6.设置底部弹出view
    [self setupBottomPopView];
    
    //7.设置旋转按钮
    [self setupRotateBtn];
    
    
}


#pragma mark -----------------------------
#pragma mark 加载子控制器
- (void)setupAllChildViewControllers{
    
//    大家
    WeViewController *we = [[WeViewController alloc] init];
    [self addChildViewController:we];
    
//    我的
    MyViewController *my = [[MyViewController alloc] init];
    [self addChildViewController:my];
    
}

#pragma mark -----------------------------
#pragma mark 隐藏系统tabbar
- (void)hiddenSystemTabBar{
    self.tabBar.hidden = YES;
}

#pragma mark -----------------------------
#pragma mark 设置上下view
- (void)setupTopAndBottomView{
    
    //设置上面的view
//    [self setupNavigationView];
    
    //设置下面的view
    [self setupBottomView];
}

//- (void)setupNavigationView{
//
//    XZQNavigationView *navigationView = [[XZQNavigationView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, XZQNavigationViewH)];
//    navigationView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:navigationView];
//
//}

- (void)setupBottomView{
    
    XLog(@"%@",NSStringFromCGRect(self.tabBar.frame));
    
    XZQTabBarView *tabBarView = [[XZQTabBarView alloc] initWithFrame:CGRectMake(-1, self.tabBar.frame.origin.y-40, ScreenW+2, XZQTabBarViewH)];
    

    [self.view addSubview:tabBarView];
    
//      背景图
    tabBarView.backGroundImage = [UIImage OriginalImageWithName:@"backImageOfTabBar" toSize:tabBarView.bounds.size];
}

#pragma mark -----------------------------
#pragma mark 接收通知
- (void)addNotification{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showChildView_We) name:@"XZQTabBarViewPostToChangeXZQTabBarControllerCurrentShowedChildControllerView_We" object:nil];
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showChildView_Middle) name:@"XZQTabBarViewPostToChangeXZQTabBarControllerCurrentShowedChildControllerView_Middle" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showChildView_My) name:@"XZQTabBarViewPostToChangeXZQTabBarControllerCurrentShowedChildControllerView_My" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popMySettingView) name:@"MyViewControllerToPopSettingView" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMyVCView) name:@"XZQMySettingViewWantXZQTabBarControllerReturnToShowMyVCView" object:nil];
    
    
}

- (void)showChildView_We{
    self.selectedIndex = 0;
    XFunc;
}

- (void)showChildView_Middle{
    
    XFunc;
    //显示出来
    self.rotateBtn.alpha = 1;
    
    //旋转
    [UIView animateWithDuration:1.0 animations:^{
        
        //向上移动底部的view
//        [self.bottomPopView setFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        self.bottomPopView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
        
        [self.rotateBtn setTransform:CGAffineTransformMakeRotation(6 * M_PI + M_PI_4)];
        
    }];
    
//    [self.view bringSubviewToFront:self.rotateBtn];
    XLog(@"%@",NSStringFromCGRect(self.bottomPopView.frame));
    
    
}

- (void)showChildView_My{
    XFunc;
    self.selectedIndex = 1;
}


- (void)showMyVCView{
    [UIView animateWithDuration:0.25 animations:^{
        self.placeHolderRightSuperView.frame = CGRectMake(ScreenW, 0, ScreenW, ScreenH);
    }completion:^(BOOL finished) {
            
    }];
}

#pragma mark -----------------------------
#pragma mark 我的-设置界面
- (void)setupMySettingView{
    
    //占位父视图 设置界面的
    XZQMySettingView *placeHolderRightSuperView = ({
        
        XZQMySettingView *placeHolderRightSuperView = [[XZQMySettingView alloc] init];
        placeHolderRightSuperView.backgroundColor = [UIColor redColor];
        self.placeHolderRightSuperView = placeHolderRightSuperView;
        
    });
    
    [self.view addSubview:placeHolderRightSuperView];
    
}

#pragma mark -----------------------------
#pragma mark 布局子控件
- (void)viewWillLayoutSubviews{
    
    //右侧父视图
    self.placeHolderRightSuperView.frame = CGRectMake(ScreenW, 0, ScreenW, ScreenH);
    
    //bottomPopView
    self.bottomPopView.frame = CGRectMake(0, ScreenH, ScreenW, ScreenH);
    
    //rotateBtn
    self.rotateBtn.frame = CGRectMake(179, 9, 56, 56);
    [self.rotateBtn setBackgroundImage:[UIImage OriginalImageWithName:@"plus" toSize:CGSizeMake(56, 56)] forState:UIControlStateNormal];
    
}


#pragma mark -----------------------------
#pragma mark 接收通知

- (void)popMySettingView{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.placeHolderRightSuperView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    }completion:^(BOOL finished) {
//        self.placeHolderRightSuperView.frame = CGRectMake(ScreenW, 0, ScreenW, ScreenH);
    }];
    
}

#pragma mark -----------------------------
#pragma mark 底部弹出的view
- (void)setupBottomPopView{
    
    UIView *bottomPopView = ({
        
        UIView *bottomPopView = [[UIView alloc] init];
        bottomPopView.backgroundColor = [UIColor redColor];
        self.bottomPopView = bottomPopView;
        bottomPopView;
        
    });
    
    [self.view addSubview:bottomPopView];
}

#pragma mark -----------------------------
#pragma mark 设置旋转按钮
- (void)setupRotateBtn{
    
    UIButton *rotateBtn = ({
        
        UIButton *rotateBtn = [[UIButton alloc] init];
        [rotateBtn addTarget:self action:@selector(closeView:) forControlEvents:UIControlEventTouchUpInside];
        self.rotateBtn = rotateBtn;
        self.rotateBtn.alpha = 0;
        rotateBtn;
        
    });
    
    [self.view addSubview:rotateBtn];
    
}

#pragma mark -----------------------------
#pragma mark 监听点击
- (void)closeView:(UIButton *)btn{
    
    self.bottomPopView.frame = CGRectMake(0, ScreenH, ScreenW, ScreenH);
    self.rotateBtn.hidden = YES;
    XFunc;
}




@end
