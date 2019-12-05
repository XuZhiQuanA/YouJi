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

@interface XZQTabBarController ()

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
    

    
}

- (void)showChildView_We{
    self.selectedIndex = 0;
    XFunc;
}

- (void)showChildView_Middle{
    XFunc;
}

- (void)showChildView_My{
    XFunc;
    self.selectedIndex = 1;
}







@end
