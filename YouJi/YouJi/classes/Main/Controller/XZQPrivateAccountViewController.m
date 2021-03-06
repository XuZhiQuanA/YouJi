//
//  XZQPrivateAccountViewController.m
//  YouJi
//
//  Created by dmt312 on 2019/12/23.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "XZQPrivateAccountViewController.h"
#import "XZQNoHighlightedButton.h"
#import "SVProgressHUD.h"
#define topScreenH 60
#define innerBtnH 50
#define innerBtnW 382
#define innerBtnAndYearImageSpaceH 44
@interface XZQPrivateAccountViewController ()

/** 上面的view*/
@property(nonatomic,readwrite,weak) UIView *topView;

/** 中间的middleScrollView*/
@property(nonatomic,readwrite,weak) UIScrollView *middleScrollView;

/** 返回按钮*/
@property(nonatomic,readwrite,weak) UIButton *returnBtn;

/** 下拉btn*/
@property(nonatomic,readwrite,weak) UIButton *selectBtn;

/** 私密账本label*/
@property(nonatomic,readwrite,weak) UILabel *textLabel;

/** 内部的第一个view- 2019的那个*/
@property(nonatomic,readwrite,weak) XZQNoHighlightedButton  *innerFirstBtn;

/** 内部的第二个view- 2018的那个*/
@property(nonatomic,readwrite,weak) XZQNoHighlightedButton  *innerSecondBtn;

/** 第一张Year图*/
@property(nonatomic,readwrite,weak) UIImageView *firstImageView;

/** 第二张Year图*/
@property(nonatomic,readwrite,weak) UIImageView *secondImageView;



/** 公有或者私有账本的父view*/
@property(nonatomic,readwrite,weak) UIView *publicOrPrivateSuperView;

/** 公有账本btn*/
@property(nonatomic,readwrite,weak) UIButton *publicOrPrivateSuperViewSubButtonTopBtn;

/** 私有账本btn*/
@property(nonatomic,readwrite,weak) UIButton *publicOrPrivateSuperViewSubButtonBottomBtn;

@end

@implementation XZQPrivateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    //1.构建子view
    [self setupChildView];
    
}

- (void)setIsPrivate:(BOOL)isPrivate{
    _isPrivate = isPrivate;
    
    if (isPrivate) {
        //私有账本的图片
        
    }else{
        //公有账本的图片
        
    }
}

#pragma mark -----------------------------
#pragma mark 构建界面

- (void)setupChildView{

    
    //1.topView
    UIView *topView = ({
        
        UIView *topView = [[UIView alloc] init];
        
        UIColor *color = XColor(214, 245, 247);
        topView.backgroundColor = color;
        
        topView;
    });
    self.topView = topView;
    [self.view addSubview:topView];
    
    //1.1返回按钮
    UIButton *btn = ({
        
        UIButton *btn = [[UIButton alloc] init];
        [btn addTarget:self action:@selector(quitPrivateAccountView) forControlEvents:UIControlEventTouchUpInside];
        btn;
        
    });
    self.returnBtn = btn;
    [topView addSubview:btn];
    
    //1.2 label
    UILabel *textLabel = ({
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.text = self.title;
        textLabel.font = [UIFont systemFontOfSize:25];
        textLabel.userInteractionEnabled = true;//XColor(92, 94, 94)
        textLabel.textColor = XColor(92, 94, 94);
        //添加点按手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTextLabel)];
        [textLabel addGestureRecognizer:tap];
        
        textLabel;
        
    });
    self.textLabel = textLabel;
    [topView addSubview:textLabel];
    
    //1.3 下拉btn
    UIButton *selectBtn = ({
        
        UIButton *selectBtn = [[UIButton alloc] init];
        [selectBtn addTarget:self action:@selector(tapTextLabel) forControlEvents:UIControlEventTouchUpInside];
//        selectBtn.backgroundColor = [UIColor redColor];
        selectBtn;
        
    });
    
    self.selectBtn = selectBtn;
    [topView addSubview:self.selectBtn];
    
    
    //2.middleScrollView
    UIScrollView *middleScrollView = ({
        
        UIScrollView *middleScrollView = [[UIScrollView alloc] init];
        middleScrollView.contentSize = CGSizeMake(0, 2*(innerBtnH+PrivateYearImageH + innerBtnAndYearImageSpaceH));
        middleScrollView.backgroundColor = [UIColor whiteColor];
        
        
        middleScrollView;
    });
    self.middleScrollView = middleScrollView;
    [self.view addSubview:middleScrollView];
    
    //2.1 第一个btn
    XZQNoHighlightedButton *innerFirstBtn = ({
        
        XZQNoHighlightedButton *innerFirstBtn = [[XZQNoHighlightedButton alloc] init];
        innerFirstBtn.tag = 1;
        [innerFirstBtn addTarget:self action:@selector(showYearImage:) forControlEvents:UIControlEventTouchUpInside];
        innerFirstBtn.backgroundColor = [UIColor clearColor];
        
        innerFirstBtn;
        
    });
    
    self.innerFirstBtn = innerFirstBtn;
    [middleScrollView addSubview:innerFirstBtn];
    
    //2.2 第二个btn
    XZQNoHighlightedButton *innerSecondBtn = ({
        
        XZQNoHighlightedButton *innerSecondBtn = [[XZQNoHighlightedButton alloc] init];
        innerSecondBtn.tag = 2;
        [innerSecondBtn addTarget:self action:@selector(showYearImage:) forControlEvents:UIControlEventTouchUpInside];
        innerSecondBtn.backgroundColor = [UIColor clearColor];
        
        innerSecondBtn;
        
    });
    
    self.innerSecondBtn = innerSecondBtn;
    [middleScrollView addSubview:innerSecondBtn];
    
    //publicOrPrivateSuperView
    UIView *publicOrPrivateSuperView = ({
        
        UIView *publicOrPrivateSuperView = [[UIView alloc] initWithFrame:CGRectMake(117, 60, 180, 114)];
        publicOrPrivateSuperView.hidden = true;
//        publicOrPrivateSuperView.backgroundColor = [UIColor yellowColor];//117 13 180 161 CGRectMake(145, 13, 100, 35);
        
        publicOrPrivateSuperView;
    });
    
    [self.view addSubview:publicOrPrivateSuperView];
    self.publicOrPrivateSuperView = publicOrPrivateSuperView;
    
    //publicOrPrivateSuperViewBackgroundImageView
    UIImageView *publicOrPrivateSuperViewBackgroundImageView = ({
        
        UIImageView *publicOrPrivateSuperViewBackgroundImageView = [[UIImageView alloc] initWithFrame:publicOrPrivateSuperView.bounds];
        
        publicOrPrivateSuperViewBackgroundImageView.image = [UIImage OriginalImageWithName:@"PrivateAccount_selectedBox" toSize:publicOrPrivateSuperView.bounds.size];
        
        publicOrPrivateSuperViewBackgroundImageView;
        
    });
    [publicOrPrivateSuperView addSubview:publicOrPrivateSuperViewBackgroundImageView];
    
    
    //publicOrPrivateSuperViewSubButtonTop
    UIButton *publicOrPrivateSuperViewSubButtonTopBtn = ({
            
        UIButton *publicOrPrivateSuperViewSubButtonTopBtn = [[UIButton alloc] init];
        [publicOrPrivateSuperViewSubButtonTopBtn addTarget:self action:@selector(returnToPublicAccount:) forControlEvents:UIControlEventTouchUpInside];
//        publicOrPrivateSuperViewSubButtonTopBtn.backgroundColor = XRandomColor;
        [publicOrPrivateSuperViewSubButtonTopBtn setTitle:@"公开账本" forState:UIControlStateNormal];
//        publicOrPrivateSuperViewSubButtonTopBtn.titleLabel.tintColor = [UIColor blackColor];
        [publicOrPrivateSuperViewSubButtonTopBtn setTitleColor:XColor(92, 94, 94) forState:UIControlStateNormal];
        
        publicOrPrivateSuperViewSubButtonTopBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        publicOrPrivateSuperViewSubButtonTopBtn.titleLabel.font = [UIFont systemFontOfSize:25];
        
        publicOrPrivateSuperViewSubButtonTopBtn;
        
    });
    [publicOrPrivateSuperView addSubview:publicOrPrivateSuperViewSubButtonTopBtn];
    self.publicOrPrivateSuperViewSubButtonTopBtn = publicOrPrivateSuperViewSubButtonTopBtn;
    
    
    //publicOrPrivateSuperViewSubButtonBottom
    UIButton *publicOrPrivateSuperViewSubButtonBottomBtn = ({
        
        UIButton *publicOrPrivateSuperViewSubButtonBottomBtn = [[UIButton alloc] init];
        [publicOrPrivateSuperViewSubButtonBottomBtn addTarget:self action:@selector(returnToPrivateAccount:) forControlEvents:UIControlEventTouchUpInside];
//        publicOrPrivateSuperViewSubButtonBottomBtn.backgroundColor = XRandomColor;
        publicOrPrivateSuperViewSubButtonBottomBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 10, 0);
        
        [publicOrPrivateSuperViewSubButtonBottomBtn setTitle:@"私密账本" forState:UIControlStateNormal];
        [publicOrPrivateSuperViewSubButtonBottomBtn setTitleColor:XColor(92, 94, 94) forState:UIControlStateNormal];
        publicOrPrivateSuperViewSubButtonBottomBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        publicOrPrivateSuperViewSubButtonBottomBtn.titleLabel.font = [UIFont systemFontOfSize:25];
        
        publicOrPrivateSuperViewSubButtonBottomBtn;
    });
    
    [publicOrPrivateSuperView addSubview:publicOrPrivateSuperViewSubButtonBottomBtn];
    self.publicOrPrivateSuperViewSubButtonBottomBtn = publicOrPrivateSuperViewSubButtonBottomBtn;
    
}

- (void)showYearImage{
    
}

#pragma mark -----------------------------
#pragma mark 点击公开或者私密账本

//公开
- (void)returnToPublicAccount:(UIButton *)btn{
    
    
    
    __weak typeof(self) weakSelf = self;
    
    self.firstImageName = @"PrivateAccount_2015";
    self.secondImageName = @"PrivateAccount_2017";
    
    self.firstImageView.image = nil;
    self.secondImageView.image = nil;
    
    //展示数据加载中
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
            [weakSelf viewWillLayoutSubviews];
            
            weakSelf.textLabel.text = @"公有账本";
            
            weakSelf.publicOrPrivateSuperView.hidden = true;
        });
    });
    
    
    
//    [self dismissViewControllerAnimated:self completion:^{
//        [weakSelf returnToPrivateAccount:nil];
//    }];
//    //点击WeBtn
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"clickWeBtn" object:nil];
//    //点击手账btn
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"clickShouZhangBtn" object:nil];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"shouzhang" object:nil];
    
    
}

- (void)returnToPrivateAccount:(UIButton *)btn{
    
    
    __weak typeof(self) weakSelf = self;
    
    self.firstImageName = @"PrivateAccount_2018";
    self.secondImageName = @"PrivateAccount_2019";
    
    self.firstImageView.image = nil;
    self.secondImageView.image = nil;
    
    //展示数据加载中
    [SVProgressHUD showWithStatus:@"数据加载中"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
            
            [weakSelf viewWillLayoutSubviews];
            
            weakSelf.textLabel.text = @"私密账本";
            
            weakSelf.publicOrPrivateSuperView.hidden = true;
        });
    });
    
    
}




#pragma mark -----------------------------
#pragma mark 展示年度图片
- (void)showYearImage:(XZQNoHighlightedButton *)btn{
    
    __weak typeof(self)weakSelf = self;
    
    switch (btn.tag) {
            
        case 1:
            //0.根据btn的showYearImage决定是否展示出firstImageView
            //1. firstImageView.hidden = false
            //2. 向下移动secondImageView
            self.firstImageView.hidden = !btn.showYearImage;
            
            if (self.firstImageView.hidden) {
                
                [btn setBackgroundImage:[UIImage OriginalImageWithName:@"PrivateAccount_2018_folded" toSize:btn.bounds.size] forState:UIControlStateNormal];
                
                //非展示状态 正常
                [UIView animateWithDuration:0.5 animations:^{
                    weakSelf.innerSecondBtn.frame = CGRectMake(16, 113, innerBtnW, innerBtnH);
                    weakSelf.secondImageView.frame = CGRectMake(weakSelf.innerSecondBtn.frame.origin.x, CGRectGetMaxY(weakSelf.innerSecondBtn.frame), weakSelf.innerSecondBtn.bounds.size.width, PrivateYearImageH);
                }];
                
            }else{
                //展示状态 向下偏移
                [btn setBackgroundImage:[UIImage OriginalImageWithName:@"PrivateAccount_2018_unfold" toSize:btn.bounds.size] forState:UIControlStateNormal];
                
                //
                [UIView animateWithDuration:0.5 animations:^{
                    weakSelf.innerSecondBtn.frame = CGRectMake(btn.frame.origin.x, CGRectGetMaxY(weakSelf.firstImageView.frame) + innerBtnAndYearImageSpaceH, innerBtnW, innerBtnH);
                    weakSelf.secondImageView.frame = CGRectMake(weakSelf.innerSecondBtn.frame.origin.x, CGRectGetMaxY(weakSelf.innerSecondBtn.frame), weakSelf.innerSecondBtn.bounds.size.width, PrivateYearImageH);
                }];
                
            }
            
            
            
            break;
            
        case 2:
            self.secondImageView.hidden = !btn.showYearImage;
            
            if (self.secondImageView.hidden){
                [btn setBackgroundImage:[UIImage OriginalImageWithName:@"PrivateAccount_2019_folded" toSize:btn.bounds.size] forState:UIControlStateNormal];
            }else{
                [btn setBackgroundImage:[UIImage OriginalImageWithName:@"PrivateAccount_2019_unfold" toSize:btn.bounds.size] forState:UIControlStateNormal];
            }
            
            break;
            
        default:
            break;
    }
    
    
    
}


#pragma mark -----------------------------
#pragma mark textLabel添加点按手势
- (void)tapTextLabel{
    self.publicOrPrivateSuperView.hidden = !self.publicOrPrivateSuperView.hidden;
    XFunc
    
}



#pragma mark -----------------------------
#pragma mark 退出此界面
- (void)quitPrivateAccountView{
    
    [self dismissViewControllerAnimated:self completion:nil];
    
}


#pragma mark -----------------------------
#pragma mark 布局子view
- (void)viewWillLayoutSubviews{
    
    XFunc
    
    //1.topView
    self.topView.frame = CGRectMake(0, 0, ScreenW, topScreenH);
    
    //1.1返回按钮
    self.returnBtn.frame = CGRectMake(30, 18, 16, 25);
    
    if (self.returnBtn.currentBackgroundImage == nil)
        [self.returnBtn setBackgroundImage:[UIImage OriginalImageWithName:@"My_leftReturnArrow" toSize:CGSizeMake(self.returnBtn.bounds.size.width, self.returnBtn.bounds.size.height)] forState:UIControlStateNormal];
    
    //1.2 textLabel
    self.textLabel.frame = CGRectMake(145, 13, 100, 35);
    [self.textLabel sizeToFit];
    
    //1.3 selectBtn
    self.selectBtn.frame = CGRectMake(254, 24, 15, 13);
    
    [self.selectBtn setBackgroundImage:[UIImage OriginalImageWithName:@"PrivateAccount_bottomArrow" toSize:CGSizeMake(self.selectBtn.bounds.size.width, self.selectBtn.bounds.size.height)] forState:UIControlStateNormal];
    [self.selectBtn setBackgroundImage:[UIImage OriginalImageWithName:@"PrivateAccount_topArrow" toSize:CGSizeMake(self.selectBtn.bounds.size.width, self.selectBtn.bounds.size.height)] forState:UIControlStateSelected];
    
    
    //2.middleScrollView
    self.middleScrollView.frame = CGRectMake(0, topScreenH, ScreenW, ScreenH-topScreenH);
    
    //2.1 first
    self.innerFirstBtn.frame = CGRectMake(16, 23, innerBtnW, innerBtnH);
    
    self.firstImageView.frame = CGRectMake(self.innerFirstBtn.frame.origin.x, CGRectGetMaxY(self.innerFirstBtn.frame), self.innerFirstBtn.bounds.size.width, PrivateYearImageH);
    
    
    
    if (self.firstImageView.image == nil)
//        self.firstImageView.image = [UIImage OriginalImageWithName:@"PrivateAccount_2018" toSize:self.firstImageView.bounds.size];
        self.firstImageView.image = [UIImage OriginalImageWithName:self.firstImageName toSize:self.firstImageView.bounds.size];
    
    if (self.firstImageView.hidden)
        [self.innerFirstBtn setBackgroundImage:[UIImage OriginalImageWithName:@"PrivateAccount_2018_folded" toSize:self.innerFirstBtn.bounds.size] forState:UIControlStateNormal];
    
    //2.2 second
    if (self.innerFirstBtn.showYearImage) {
        //展示状态 向下偏移
        self.innerSecondBtn.frame = CGRectMake(16, PrivateYearImageH, innerBtnW, innerBtnH);
        
    }else{
        //非展示状态 正常
        self.innerSecondBtn.frame = CGRectMake(16, 113, innerBtnW, innerBtnH);
    }
    
    self.secondImageView.frame = CGRectMake(self.innerSecondBtn.frame.origin.x, CGRectGetMaxY(self.innerSecondBtn.frame), self.innerSecondBtn.bounds.size.width, PrivateYearImageH);
    if (self.secondImageView.image == nil) {
//        self.secondImageView.image = [UIImage OriginalImageWithName:@"PrivateAccount_2019" toSize:self.secondImageView.bounds.size];
        self.secondImageView.image = [UIImage OriginalImageWithName:self.secondImageName toSize:self.secondImageView.bounds.size];
    }
    
    //
    if (self.secondImageView.hidden)
        [self.innerSecondBtn setBackgroundImage:[UIImage OriginalImageWithName:@"PrivateAccount_2019_folded" toSize:self.innerFirstBtn.bounds.size] forState:UIControlStateNormal];
        
    
    
    //publicOrPrivateSuperView
    self.publicOrPrivateSuperView.frame = CGRectMake(117, 60, 180, 120);
    
    //publicOrPrivateSuperViewSubButtonTopBtn
    self.publicOrPrivateSuperViewSubButtonTopBtn.frame = CGRectMake(0, 0, self.publicOrPrivateSuperView.bounds.size.width, self.publicOrPrivateSuperView.bounds.size.height*0.5);
    
    //publicOrPrivateSuperViewSubButtonBottomBtn
    self.publicOrPrivateSuperViewSubButtonBottomBtn.frame = CGRectMake(0, self.publicOrPrivateSuperView.bounds.size.height*0.5, self.publicOrPrivateSuperViewSubButtonTopBtn.bounds.size.width, self.publicOrPrivateSuperViewSubButtonTopBtn.bounds.size.height);
}

#pragma mark -----------------------------
#pragma mark 隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return true;
}

#pragma mark -----------------------------
#pragma mark 懒加载
- (UIImageView *)firstImageView{
    
    if (_firstImageView == nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.hidden = true;
        imageV.backgroundColor = [UIColor yellowColor];
        [self.middleScrollView addSubview:imageV];
        _firstImageView = imageV;
    }
    
    return _firstImageView;
}

- (UIImageView *)secondImageView{
    if (_secondImageView == nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.hidden = true;
        imageV.backgroundColor = [UIColor greenColor];
        [self.middleScrollView addSubview:imageV];
        _secondImageView = imageV;
    }
    
    return _secondImageView;
}

//- (UIView *)publicOrPrivateSuperView{
//
//    if (_publicOrPrivateSuperView == nil) {
//
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(117, 60, 180, 114)];
//        view.hidden = true;
//        view.backgroundColor = [UIColor yellowColor];//117 13 180 161 CGRectMake(145, 13, 100, 35);
//        [self.view addSubview:view];
//
//        UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:view.bounds];
//        [view addSubview:backgroundImageView];
//        backgroundImageView.image = [UIImage OriginalImageWithName:@"" toSize:view.bounds.size];
//
//        _publicOrPrivateSuperView = view;
//    }
//
//    return _publicOrPrivateSuperView;
//}

- (void)viewWillAppear:(BOOL)animated{
    
}

@end
