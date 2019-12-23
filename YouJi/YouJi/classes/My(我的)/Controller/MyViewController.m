//
//  MyViewController.m
//  YouJi
//
//  Created by dmt312 on 2019/12/3.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()



/** 用于占位的父视图 界面的其他子视图成为其子视图*/
@property(nonatomic,readwrite,weak) UIView *placeHolderSuperView;

/** 上方的背景图*/
@property(nonatomic,readwrite,weak) UIImageView *topBackGroundImageView;

/** 用户头像*/
@property(nonatomic,readwrite,weak) UIImageView *personImageView;

/** 用户名称*/
@property(nonatomic,readwrite,weak) UILabel *personNameLabel;

/** 右上角btn*/
@property(nonatomic,readwrite,weak) UIButton *rightTopBtn;

/** scrollview*/
@property(nonatomic,readwrite,weak) UIScrollView *scrollView;

/** 公开账本*/
@property(nonatomic,readwrite,weak) UIButton *publicSZBtn;

/** 私有账本*/
@property(nonatomic,readwrite,weak) UIButton *privateSZBtn;

@property(nonatomic,readwrite,strong) NSUserDefaults *userDefault;

@end

@implementation MyViewController

//思路：搞一个占位view 将我的界面的所以子控件放在这个view中 view背景色调淡蓝色 上面两个UIImageView 一个button 下面uiscrollview

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //1.创建子控件
    [self setupChild];
    
    //2.监听通知
    [self addNotification];
    
    //3.之前有没有设置头像
    [self checkPersonalImage];
}

#pragma mark -----------------------------
#pragma mark 检测之前有没有设置过头像
- (void)checkPersonalImage{
    //personalImage
    if ([self.userDefault dataForKey:@"UserHeadImageData"] != nil) {
        NSData *userHeadImageData = [self.userDefault dataForKey:@"UserHeadImageData"];
        UIImage *userHeadImage = [UIImage imageWithData:userHeadImageData];
        self.personImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.personImageView.image = userHeadImage;
    }
}


#pragma mark -----------------------------
#pragma mark 创建子控件
- (void)setupChild{
    
    //占位父视图
    UIView *placeHolderSuperView = ({
        
        
        UIView * placeHolderSuperView = [[UIView alloc] init];
        placeHolderSuperView.backgroundColor = XColor(243, 251, 252);
        self.placeHolderSuperView = placeHolderSuperView;
        
        placeHolderSuperView;
        
    });
    
    [self.view addSubview:placeHolderSuperView];
//    self.placeHolderSuperView.backgroundColor = [UIColor redColor];
    
    //上方背景
    UIImageView *topBackGroundImageView = ({
        
        UIImageView *topBackGroundImageView = [[UIImageView alloc] init];
        self.topBackGroundImageView = topBackGroundImageView;
        topBackGroundImageView;
        
    });
    
    [placeHolderSuperView addSubview:topBackGroundImageView];
    
    //人物头像
    UIImageView *personImageView = ({
        
        UIImageView *personImageView = [[UIImageView alloc] init];
        self.personImageView = personImageView;
        
        personImageView;
    });
    
    [placeHolderSuperView addSubview:personImageView];
    
    //用户名称
    UILabel *personNameLabel = ({
        
        UILabel *personNameLabel = [[UILabel alloc] init];
        personNameLabel.text = @"嘿嘿";
        personNameLabel.textAlignment = NSTextAlignmentCenter;
        personNameLabel.font = [UIFont systemFontOfSize:22];
        personNameLabel.textColor = XColor(124, 128, 128);
        self.personNameLabel = personNameLabel;
        personNameLabel;
        
    });

    [placeHolderSuperView addSubview:personNameLabel];
    
    //右上按钮
    UIButton *rightTopBtn = ({
        
        UIButton *rightTopBtn = [[UIButton alloc] init];
        [rightTopBtn addTarget:self action:@selector(popSettingView) forControlEvents:UIControlEventTouchUpInside];
        self.rightTopBtn = rightTopBtn;
        rightTopBtn;
    });
    
    [placeHolderSuperView addSubview:rightTopBtn];
    
    
    //scrollView
    UIScrollView *scrollView = ({
        
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.pagingEnabled = YES;
        self.scrollView = scrollView;
        scrollView;
    });
    
    UIButton *publicSZBtn = [[UIButton alloc] init];
    publicSZBtn.tag = 1;
    [publicSZBtn addTarget:self action:@selector(popSZ:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:publicSZBtn];
    self.publicSZBtn = publicSZBtn;
    
    UIButton *privateSZBtn = [[UIButton alloc] init];
    privateSZBtn.tag = 2;
    [privateSZBtn addTarget:self action:@selector(popSZ:) forControlEvents:UIControlEventTouchUpInside];
    [scrollView addSubview:privateSZBtn];
    self.privateSZBtn = privateSZBtn;
    
    
    [placeHolderSuperView addSubview:scrollView];
    
    

    
    
}

#pragma mark -----------------------------
#pragma mark 监听右上角按钮点击
- (void)popSettingView{
    

    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MyViewControllerToPopSettingView" object:nil];
    
    
    XFunc;
}

//弹出手账界面
- (void)popSZ:(UIButton *)btn{
    
    switch (btn.tag) {
            //公开
        case 1:
            
            //点击WeBtn
            [[NSNotificationCenter defaultCenter] postNotificationName:@"clickWeBtn" object:nil];
            //点击手账btn
            [[NSNotificationCenter defaultCenter] postNotificationName:@"clickShouZhangBtn" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shouzhang" object:nil];
            break;
            
            //私密
        case 2:
        
            break;
            
        default:
            break;
    }
    
}



#pragma mark -----------------------------
#pragma mark 布局子控件
- (void)viewWillLayoutSubviews{
    
    //父视图
    self.placeHolderSuperView.frame = self.view.bounds;
    
    //子视图
    self.topBackGroundImageView.frame = CGRectMake(0, 0, ScreenW, 260);
    self.topBackGroundImageView.image = [UIImage OriginalImageWithName:@"My_topBackGroundImage" toSize:self.topBackGroundImageView.bounds.size];
    
    self.personImageView.frame = CGRectMake(152, 62, 110, 110);
    if (self.personImageView.image == nil) {
        self.personImageView.image = [UIImage OriginalImageWithName:@"My_personImage" toSize:self.personImageView.bounds.size];
    }
    
    
    self.personNameLabel.frame = CGRectMake(105, 199, 327, 31);
    self.personNameLabel.center = CGPointMake(self.personImageView.center.x, self.personNameLabel.center.y);
    
    
    self.rightTopBtn.frame = CGRectMake(368, 19, 30, 25);
    [self.rightTopBtn setBackgroundImage:[UIImage OriginalImageWithName:@"My_rightTopBtnBackGroundImage" toSize:self.rightTopBtn.bounds.size] forState:UIControlStateNormal];
    
    self.scrollView.frame = CGRectMake(94, 301, 226, 325);
    self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width *2, self.scrollView.bounds.size.height);
    self.scrollView.backgroundColor = [UIColor clearColor];
    
    self.publicSZBtn.frame = CGRectMake(0, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    [self.publicSZBtn setBackgroundImage:[UIImage OriginalImageWithName:@"My_public" toSize:self.publicSZBtn.bounds.size] forState:UIControlStateNormal];
    
    self.privateSZBtn.frame = CGRectMake(self.scrollView.bounds.size.width, 0, self.scrollView.bounds.size.width, self.scrollView.bounds.size.height);
    [self.privateSZBtn setBackgroundImage:[UIImage OriginalImageWithName:@"My_private" toSize:self.privateSZBtn.bounds.size] forState:UIControlStateNormal];

    
}








#pragma mark -----------------------------
#pragma mark 隐藏状态栏

//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)dealloc{
    
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"MyViewControllerToPopSettingView" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}


#pragma mark -----------------------------
#pragma mark 监听通知
- (void)addNotification{
    
    //XZQTabBarControllerWantChangeTouXiang
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTouXiang:) name:@"XZQTabBarControllerWantChangeTouXiang" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popSettingView) name:@"XZQTabBarControllerWantShowMySettingView" object:nil];
    
    //saveUserName
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveUserName:) name:@"saveUserName" object:nil];
}

#pragma mark -----------------------------
#pragma mark 改变头像
- (void)changeTouXiang:(NSNotification *)notification{
    
    UIImage *image = notification.userInfo[@"touxiang"];
    self.personImageView.image = image;
    
    
}

- (void)saveUserName:(NSNotification *)notification{
    
    NSString *text = notification.userInfo[@"userName"];
    
    self.personNameLabel.text = text;
    
}

#pragma mark -----------------------------
#pragma mark 懒加载
- (NSUserDefaults *)userDefault{
    if (_userDefault == nil) {
        _userDefault = [NSUserDefaults standardUserDefaults];
    }
    
    return _userDefault;
}


@end
