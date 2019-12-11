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

#import "FancyTabBarViewController.h"

#import "ShouZhangViewController.h"

#define rotateX 179
#define rotateY 656
#define rotateWH 56


@interface XZQTabBarController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

/**我的-设置界面 用于占位的父视图 位于界面的右边 设置界面*/
@property(nonatomic,readwrite,weak) XZQMySettingView *placeHolderRightSuperView;

/** 底部弹出的view*/
@property(nonatomic,readwrite,weak) UIView *bottomPopView;


/** tabBarView*/
@property(nonatomic,readwrite,weak) XZQTabBarView *tabBarView;

/**点击中间加号出现的VC */
@property(nonatomic,readwrite,strong) FancyTabBarViewController *fancyVc;

/** 当底部的view弹出时背后的白色view*/
@property(nonatomic,readwrite,weak) UIView *backView;

/** 编辑手账控制器*/
@property(nonatomic,readwrite,weak) ShouZhangViewController *szVc;

/** 相册管理Vc*/
@property(nonatomic,readwrite,strong) UIImagePickerController *picker;


@end

@implementation XZQTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1.加载子控制器
    [self setupAllChildViewControllers];
    
    //2.隐藏系统tabbar
    [self hiddenSystemTabBar];
    
    //3.设置底部view
    [self setupBottomView];
    
    //4.接收通知
    [self addNotification];
    
    //5.我的-设置界面
    [self setupMySettingView];
    
    //5.1底部弹出时后面的白色view
    [self backViewOfBottomViewPop];
    
    //6.设置底部弹出view
    [self setupBottomPopView];
    
    //7.设置FancyView
    [self setupFancyView];
    
    //8.设置手账View
    [self setupShouZhangView];
    
    
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
    
//    FancyVC
    FancyTabBarViewController *fancyVc = [[FancyTabBarViewController alloc] init];
    [self addChildViewController:fancyVc];
    
    self.fancyVc = fancyVc;
    
//    手账编辑控制器
    ShouZhangViewController *szVc = [[ShouZhangViewController alloc] init];
    [self addChildViewController:szVc];
    
    self.szVc = szVc;
    
}

#pragma mark -----------------------------
#pragma mark 隐藏系统tabbar
- (void)hiddenSystemTabBar{
    self.tabBar.hidden = YES;
}

- (void)setupFancyView{
    [self.view addSubview:self.fancyVc.view];
    self.fancyVc.view.backgroundColor = [UIColor clearColor];
    self.fancyVc.view.hidden = true;
}

- (void)setupBottomView{
    
    XLog(@"%@",NSStringFromCGRect(self.tabBar.frame));
    
    XZQTabBarView *tabBarView = [[XZQTabBarView alloc] initWithFrame:CGRectMake(-1, self.tabBar.frame.origin.y-40, ScreenW+2, XZQTabBarViewH)];
    
    [self.view addSubview:tabBarView];
    
//      背景图
    tabBarView.backGroundImage = [UIImage OriginalImageWithName:@"backImageOfTabBar" toSize:tabBarView.bounds.size];
    
    self.tabBarView = tabBarView;
}



#pragma mark -----------------------------
#pragma mark 接收通知
- (void)addNotification{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showChildView_We) name:@"XZQTabBarViewPostToChangeXZQTabBarControllerCurrentShowedChildControllerView_We" object:nil];
    

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showChildView_Middle) name:@"XZQTabBarViewPostToChangeXZQTabBarControllerCurrentShowedChildControllerView_Middle" object:nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showChildView_My) name:@"XZQTabBarViewPostToChangeXZQTabBarControllerCurrentShowedChildControllerView_My" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popMySettingView) name:@"MyViewControllerToPopSettingView" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMyVCView) name:@"XZQMySettingViewWantXZQTabBarControllerReturnToShowMyVCView" object:nil];
    
    //FancyTabBarWantXZQTabBarControllerQuitBottomView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(quitBottomView) name:@"FancyTabBarWantXZQTabBarControllerQuitBottomView" object:nil];
    
    //FancyTabBarViewControllerWantXZQTabBarControllerShowShouZhangViewController
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showShouZhangEditView) name:@"FancyTabBarViewControllerWantXZQTabBarControllerShowShouZhangViewController" object:nil];
    //ShouZhangViewControllerWantXZQTabBarControllerShowFancyView
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showFancyView) name:@"ShouZhangViewControllerWantXZQTabBarControllerShowFancyView" object:nil];
    
    //XZQMySettingViewWantShowSystemAlbum
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSystemAlbum) name:@"XZQMySettingViewWantShowSystemAlbum" object:nil];
    
    
}

- (void)showChildView_We{
    self.selectedIndex = 0;
    XFunc;
}

- (void)showChildView_Middle{
    
    XFunc;
    //显示出来
//    self.rotateBtn.hidden = false;
    self.fancyVc.view.hidden = false;
    
    self.backView.hidden = false;
    
    //通知
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"XZQTabBarControllerWantFancyTabBarShowedAndRotateInnerMiddleBtn" object:nil];
    
    //旋转
    [UIView animateWithDuration:0.3 animations:^{

        //向上移动底部的view
        self.bottomPopView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    
        //加了这行代码 必须得点击两次才有效果 6 * M_PI就不行 M_PI可以 并且transform代码有效果的时候 self.bottomPopView.frame = CGRectMake(0, 0, ScreenW, ScreenH);底部view不上来
//        [self.rotateBtn setTransform:CGAffineTransformMakeRotation(6 * M_PI + M_PI_4)];
//        [self.rotateBtn setTransform:CGAffineTransformMakeRotation(M_PI)];


    }];
    
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
    
    self.fancyVc.view.frame = self.view.bounds;
    
    self.backView.frame = self.view.bounds;
    
    self.szVc.view.frame = self.view.bounds;
    
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

- (void)showShouZhangEditView{
    
    self.szVc.view.hidden = false;
    
}

- (void)showFancyView{
    
    self.szVc.view.hidden = true;
    
    //点击middle按钮
    [[NSNotificationCenter defaultCenter] postNotificationName:@"XZQTabBarControllerWantXZQTabBarViewClickMiddleBtn" object:nil];
    
}

#pragma mark -----------------------------
#pragma mark 底部弹出的view
- (void)setupBottomPopView{
    
    UIView *bottomPopView = ({
        
        UIView *bottomPopView = [[UIView alloc] init];
        bottomPopView.backgroundColor = XColor(243, 250, 251);
        self.bottomPopView = bottomPopView;
        bottomPopView;
        
    });
    
    [self.view addSubview:bottomPopView];
}


#pragma mark -----------------------------
#pragma mark 监听点击
- (void)closeView:(UIButton *)btn{
    
    self.bottomPopView.frame = CGRectMake(0, ScreenH, ScreenW, ScreenH);
    
    XFunc;
}


#pragma mark -----------------------------
#pragma mark 底部弹出时背后的view
- (void)backViewOfBottomViewPop{
    UIView *backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor whiteColor];
    backView.hidden = YES;
    [self.view addSubview:backView];
    self.backView = backView;
    
}

#pragma mark -----------------------------
#pragma mark 关闭bottomView
- (void)quitBottomView{
    self.fancyVc.view.hidden = true;
    self.bottomPopView.frame = CGRectMake(0, ScreenH, ScreenW, ScreenH);
    self.backView.hidden = true;
}

#pragma mark -----------------------------
#pragma mark 设置手账view
- (void)setupShouZhangView{

    self.szVc.view.hidden = YES;
    [self.view addSubview:self.szVc.view];
}


#pragma mark -----------------------------
#pragma mark 展示系统相册
- (void)showSystemAlbum{
    XFunc;
    [self presentViewController:self.picker animated:YES completion:nil];
}

#pragma mark -----------------------------
#pragma mark UIImagePickerControllerDelegate || UINavigationControllerDelegate代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
//    获取图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];

    XLog(@"imagePickerController - %@",image);
    
//    self.showSelectedImageFromAlbum.hidden = false;
//    self.showSelectedImageFromAlbum.image = image;
    
//    获取图片后返回
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:image forKey:@"touxiang"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"XZQTabBarControllerWantChangeTouXiang" object:nil userInfo:dict];
}

//按取消按钮时候的功能
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
//    返回
//    [picker dismissViewControllerAnimated:YES completion:nil];
    [picker dismissViewControllerAnimated:YES completion:nil];
    
//    [UIView animateWithDuration:0.25 animations:^{
//        self.placeHolderRightSuperView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
//    }];
    
    
    
    
    
}



#pragma mark -----------------------------
#pragma mark lazy load
- (UIImagePickerController *)picker{
    
    if (_picker == nil) {
        _picker = [[UIImagePickerController alloc] init];
        _picker.delegate = self;
        _picker.allowsEditing = true;
        _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    return _picker;
}





#pragma mark -----------------------------
#pragma mark 移除通知


/// 移除通知
- (void)dealloc{
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"XZQTabBarViewPostToChangeXZQTabBarControllerCurrentShowedChildControllerView_We" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"XZQTabBarViewPostToChangeXZQTabBarControllerCurrentShowedChildControllerView_Middle" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"XZQTabBarViewPostToChangeXZQTabBarControllerCurrentShowedChildControllerView_My" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MyViewControllerToPopSettingView" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"XZQMySettingViewWantXZQTabBarControllerReturnToShowMyVCView" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"FancyTabBarWantXZQTabBarControllerQuitBottomView" object:nil];
//    //FancyTabBarViewControllerWantXZQTabBarControllerShowShouZhangViewController
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"FancyTabBarViewControllerWantXZQTabBarControllerShowShouZhangViewController" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ShouZhangViewControllerWantXZQTabBarControllerShowFancyView" object:nil];
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"XZQMySettingViewWantShowSystemAlbum" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


@end
