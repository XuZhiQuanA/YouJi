//
//  XZQPrivateAccountViewController.m
//  YouJi
//
//  Created by dmt312 on 2019/12/23.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "XZQPrivateAccountViewController.h"
#import "XZQNoHighlightedButton.h"

#define topScreenH 60
#define middleScrollViewContentSizeH 1425
@interface XZQPrivateAccountViewController ()

/** 上面的view*/
@property(nonatomic,readwrite,weak) UIView *topView;

/** 中间的middleScrollView*/
@property(nonatomic,readwrite,weak) UIScrollView *middleScrollView;

/** 返回按钮*/
@property(nonatomic,readwrite,weak) UIButton *returnBtn;

/** 私密账本label*/
@property(nonatomic,readwrite,weak) UILabel *textLabel;

/** 下拉btn*/
@property(nonatomic,readwrite,weak) UIButton *selectBtn;

/** 内部的第一个view- 2019的那个*/
@property(nonatomic,readwrite,weak) XZQNoHighlightedButton  *innerFirstBtn;

/** 内部的第二个view- 2018的那个*/
@property(nonatomic,readwrite,weak) XZQNoHighlightedButton  *innerSecondBtn;

/** 第一张Year图*/
@property(nonatomic,readwrite,weak) UIImageView *firstImageView;

/** 第二张Year图*/
@property(nonatomic,readwrite,weak) UIImageView *secondImageView;

@end

@implementation XZQPrivateAccountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    //1.构建子view
    [self setupChildView];
    
    //2.
    
}

#pragma mark -----------------------------
#pragma mark 构建界面

- (void)setupChildView{
    
    //1.topView
    UIView *topView = ({
        
        UIView *topView = [[UIView alloc] init];
        
        UIColor *color = XColor(214, 245, 247);
        color = [color colorWithAlphaComponent:0.9];
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
        textLabel.text = @"私密账本";
        textLabel.font = [UIFont systemFontOfSize:25];
        textLabel;
        
    });
    self.textLabel = textLabel;
    [topView addSubview:textLabel];
    
    //1.3 下拉btn
    UIButton *selectBtn = ({
        
        UIButton *selectBtn = [[UIButton alloc] init];
        selectBtn.backgroundColor = [UIColor redColor];
        selectBtn;
        
    });
    
    self.selectBtn = selectBtn;
    [topView addSubview:self.selectBtn];
    
    
    //2.middleScrollView
    UIScrollView *middleScrollView = ({
        
        UIScrollView *middleScrollView = [[UIScrollView alloc] init];
        middleScrollView.contentSize = CGSizeMake(0, middleScrollViewContentSizeH);
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
        innerFirstBtn.backgroundColor = [UIColor redColor];
        
        innerFirstBtn;
        
    });
    
    self.innerFirstBtn = innerFirstBtn;
    [middleScrollView addSubview:innerFirstBtn];
    
    //2.2 第二个btn
    XZQNoHighlightedButton *innerSecondBtn = ({
        
        XZQNoHighlightedButton *innerSecondBtn = [[XZQNoHighlightedButton alloc] init];
        innerSecondBtn.tag = 2;
        [innerSecondBtn addTarget:self action:@selector(showYearImage:) forControlEvents:UIControlEventTouchUpInside];
        innerSecondBtn.backgroundColor = [UIColor redColor];
        
        innerSecondBtn;
        
    });
    
    self.innerSecondBtn = innerSecondBtn;
    [middleScrollView addSubview:innerSecondBtn];
    
}

- (void)showYearImage{
    
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
                //非展示状态 正常
                [UIView animateWithDuration:0.5 animations:^{
                    weakSelf.innerSecondBtn.frame = CGRectMake(16, 113, 382, 50);
                    weakSelf.secondImageView.frame = CGRectMake(weakSelf.innerSecondBtn.frame.origin.x, CGRectGetMaxY(weakSelf.innerSecondBtn.frame), weakSelf.innerSecondBtn.bounds.size.width, 100);
                }];
                
                
            }else{
                //展示状态 向下偏移
                
                [UIView animateWithDuration:0.5 animations:^{
                    weakSelf.innerSecondBtn.frame = CGRectMake(16, 668, 382, 50);
                    weakSelf.secondImageView.frame = CGRectMake(weakSelf.innerSecondBtn.frame.origin.x, CGRectGetMaxY(weakSelf.innerSecondBtn.frame), weakSelf.innerSecondBtn.bounds.size.width, 100);
                }];
            }
            
            
            
            break;
            
        case 2:
            self.secondImageView.hidden = !btn.showYearImage;
            break;
            
        default:
            break;
    }
    
}

#pragma mark -----------------------------
#pragma mark 展示YearImageView




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
    if (self.selectBtn.currentBackgroundImage == nil)
        [self.selectBtn setBackgroundImage:[UIImage OriginalImageWithName:@"" toSize:CGSizeMake(self.selectBtn.bounds.size.width, self.selectBtn.bounds.size.height)] forState:UIControlStateNormal];
        
    
    //2.middleScrollView
    self.middleScrollView.frame = CGRectMake(0, topScreenH, ScreenW, ScreenH-topScreenH);
    
    //2.1 first
    self.innerFirstBtn.frame = CGRectMake(16, 23, 382, 50);
    
    self.firstImageView.frame = CGRectMake(self.innerFirstBtn.frame.origin.x, CGRectGetMaxY(self.innerFirstBtn.frame), self.innerFirstBtn.bounds.size.width, 100);
    
    
    
    //2.2
    if (self.innerFirstBtn.showYearImage) {
        //展示状态 向下偏移
        self.innerSecondBtn.frame = CGRectMake(16, 668, 382, 50);
    }else{
        //非展示状态 正常
        self.innerSecondBtn.frame = CGRectMake(16, 113, 382, 50);
    }
    
    self.secondImageView.frame = CGRectMake(self.innerSecondBtn.frame.origin.x, CGRectGetMaxY(self.innerSecondBtn.frame), self.innerSecondBtn.bounds.size.width, 100);
    
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

@end
