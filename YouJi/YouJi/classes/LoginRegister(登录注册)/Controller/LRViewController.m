//
//  LRViewController.m
//  YouJi
//
//  Created by dmt312 on 2019/12/21.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "LRViewController.h"
#import "LoginViewController.h"
#import "RegisterViewController.h"

@interface LRViewController ()

@property(nonatomic,readwrite,weak) LoginViewController *loginVc;

@property(nonatomic,readwrite,weak) RegisterViewController *registerVc;

@property(nonatomic,readwrite,weak) UIScrollView *contentScrollView;

@end

@implementation LRViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //0.设置view的tag为1
    self.view.tag = 1;
    
    //1.添加子控制器
    [self addChildVC];
    
    //2.默认登录界面先出现
//    self.childVcViewIndex = 0;
    [self changeChildVcViewWithIndex:self.childVcViewIndex];
    
    
}

#pragma mark -----------------------------
#pragma mark 添加view

- (void)addChildVC{
    
    XFunc
    
    LoginViewController *loginVc = [[LoginViewController alloc] init];
    [self addChildViewController:loginVc];
    self.loginVc = loginVc;
    
    RegisterViewController *registerVc = [[RegisterViewController alloc] init];
    [self addChildViewController:registerVc];
    self.registerVc = registerVc;
    
}
#pragma mark -----------------------------
#pragma mark 切换子控件view

- (void)changeChildVcViewWithIndex:(NSInteger)index{
    XFunc
    UIViewController *vc;
    
    if (index < self.childViewControllers.count && index >= 0) {
        vc = self.childViewControllers[index];
    }
    
    if ([vc isViewLoaded] == false){
        
        UIView *view = vc.view;
        view.frame = CGRectMake(index*ScreenW, 0, ScreenW, ScreenH);
        [self.contentScrollView addSubview:view];
        
    }
    
    [self.contentScrollView setContentOffset:CGPointMake(index*ScreenW, self.contentScrollView.contentOffset.y) animated:YES];
    
}





#pragma mark -----------------------------
#pragma mark 懒加载
- (UIScrollView *)contentScrollView{
    
    if (_contentScrollView == nil) {
        
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        scrollView.contentSize = CGSizeMake(ScreenW*2, 0);
        scrollView.scrollEnabled = false;
        _contentScrollView = scrollView;
        [self.view addSubview:_contentScrollView];
    }
    
    return _contentScrollView;
    
}

- (BOOL)prefersStatusBarHidden{
    return true;
}



@end
