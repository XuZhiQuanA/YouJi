//
//  XZQMySettingView.m
//  YouJi
//
//  Created by dmt312 on 2019/12/5.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "XZQMySettingView.h"
#import "XZQTableViewCellOne.h"
#import "XZQTableViewCellTwo.h"
#import "XZQTableViewCellThree.h"

@interface XZQMySettingView()<UITableViewDataSource,UITableViewDelegate>

/** 占位父视图*/
@property(nonatomic,readwrite,weak) UIView *placeHolderSuperView;

/** 上方的占位父视图*/
@property(nonatomic,readwrite,weak) UIView *topPlaceHolderSuperView;

/** 中间的占位父视图*/
@property(nonatomic,readwrite,weak) UIView *middlePlaceHolderSuperView;

/** 左边的返回按钮*/
@property(nonatomic,readwrite,weak) UIButton *leftReturnBtn;

/** 中间的标题文字*/
@property(nonatomic,readwrite,weak) UILabel *middleTitleLabel;

/** 退出登录按钮*/
@property(nonatomic,readwrite,weak) UIButton *quitLoginBtn;

/** 数据列表*/
@property(nonatomic,readwrite,weak) UITableView *tableView;



@end

@implementation XZQMySettingView

NSString * const IDOne = @"TableViewCellOne";
NSString * const IDTwo = @"TableViewCellTwo";
NSString * const IDThree = @"TableViewCellThree";
NSString * const IDDefault = @"TableViewCellDefault";

const CGFloat quitLoginBtnW = 250;
const CGFloat quitLoginBtnH = 49;

//初始化
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
       //添加子控件
        [self addChild];
        
    }
    
    return self;
}

#pragma mark -----------------------------
#pragma mark 添加子控件
- (void)addChild{
    
     
    
    //placeHolderSuperView
    UIView *placeHolderSuperView = ({
        
        
        UIView *placeHolderSuperView = [[UIView alloc] init];
        self.placeHolderSuperView = placeHolderSuperView;
        placeHolderSuperView;
        
    });
    
    [self addSubview:placeHolderSuperView];
    
    //topPlaceHolderSuperView
    UIView *topPlaceHolderSuperView = ({
        
        
        UIView *topPlaceHolderSuperView = [[UIView alloc] init];
        self.topPlaceHolderSuperView = topPlaceHolderSuperView;
        self.topPlaceHolderSuperView.backgroundColor = XColor(243, 249, 250);
        topPlaceHolderSuperView;
        
    });
    
    //leftReturnBtn
    UIButton *leftReturnBtn = ({
        
        UIButton *leftReturnBtn = [[UIButton alloc] init];
        [leftReturnBtn addTarget:self action:@selector(returnToMyView:) forControlEvents:UIControlEventTouchUpInside];
        self.leftReturnBtn = leftReturnBtn;
        
        leftReturnBtn;
    });
    
    [topPlaceHolderSuperView addSubview:leftReturnBtn];
    
    //middleTitleLabel
    UILabel *middleTitleLabel = ({
        
        UILabel *middleTitleLabel = [[UILabel alloc] init];
        self.middleTitleLabel = middleTitleLabel;
        self.middleTitleLabel.text = @"设 置";
        self.middleTitleLabel.font = [UIFont systemFontOfSize:25];
        self.middleTitleLabel.textColor = XColor(92, 94, 94);
        middleTitleLabel;
    });
    
    [topPlaceHolderSuperView addSubview:middleTitleLabel];
    
    
    [placeHolderSuperView addSubview:topPlaceHolderSuperView];
    
    //middlePlaceHolderSuperView
    UIView *middlePlaceHolderSuperView = ({
        
        
        UIView *middlePlaceHolderSuperView = [[UIView alloc] init];
        middlePlaceHolderSuperView.backgroundColor = [UIColor blueColor];
        self.middlePlaceHolderSuperView = middlePlaceHolderSuperView;
        middlePlaceHolderSuperView;
        
    });
    [placeHolderSuperView addSubview:middlePlaceHolderSuperView];
    
    
    UITableView *tableView = ({
        
        UITableView *tableView = [[UITableView alloc] init];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = 67;
        self.tableView = tableView;
        tableView;
    });
    
    [middlePlaceHolderSuperView addSubview:tableView];
    
    //quitLoginBtn
    UIButton *quitLoginBtn = ({
        
        UIButton *quitLoginBtn = [[UIButton alloc] init];
        quitLoginBtn.titleLabel.text = @"退出登录";
        quitLoginBtn.backgroundColor = [UIColor yellowColor];
//        [quitLoginBtn addTarget:self action:@selector(quitToMyView:) forControlEvents:UIControlEventTouchUpInside];
        self.quitLoginBtn = quitLoginBtn;
        quitLoginBtn;
        
    });
    
    [middlePlaceHolderSuperView addSubview:quitLoginBtn];
    
    
    
}

#pragma mark -----------------------------
#pragma mark 布局子控件
- (void)layoutSubviews{
    
    //placeHolderSuperView
    self.placeHolderSuperView.frame = self.bounds;
    
    //topPlaceHolderSuperView
    self.topPlaceHolderSuperView.frame = CGRectMake(0, 0, ScreenW, 60);
    
    //middlePlaceHolderSuperView
    self.middlePlaceHolderSuperView.frame = CGRectMake(0, 68, ScreenW, 626);
    
    //leftReturnBtn
    self.leftReturnBtn.frame = CGRectMake(30, 18, 16, 25);
    [self.leftReturnBtn setBackgroundImage:[UIImage OriginalImageWithName:@"My_leftReturnArrow" toSize:self.leftReturnBtn.bounds.size] forState:UIControlStateNormal];
    
    //middleTitleLabel
    self.middleTitleLabel.frame = CGRectMake(178, 13, 59, 35);
    
    //tableView
    self.tableView.frame = CGRectMake(0, 0, ScreenW, 217);
    
    //quitLoginBtn
    self.quitLoginBtn.frame = CGRectMake(82, 577, quitLoginBtnW, quitLoginBtnH);
    
    
    

}


#pragma mark -----------------------------
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    switch (indexPath.row) {
        case 0:
//            cell = [tableView dequeueReusableCellWithIdentifier:IDOne];
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XZQTableViewCellOne class]) owner:nil options:nil] firstObject];
            break;
            
        case 1:
//            cell = [tableView dequeueReusableCellWithIdentifier:IDTwo];
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XZQTableViewCellTwo class]) owner:nil options:nil] firstObject];
        break;
            
        case 2:
//            cell = [tableView dequeueReusableCellWithIdentifier:IDThree];
            cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([XZQTableViewCellThree class]) owner:nil options:nil] firstObject];
        break;
            
        default:
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDDefault];
            break;
    }
    
    
    return cell;
}

#pragma mark -----------------------------
#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    XFunc;
}

#pragma mark -----------------------------
#pragma mark 监听返回按钮
- (void)returnToMyView:(UIButton *)btn{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"XZQMySettingViewWantXZQTabBarControllerReturnToShowMyVCView" object:nil];

}

- (void)quitToMyView:(UIButton *)btn{
    
    XFunc;
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"XZQMySettingViewWantXZQTabBarControllerToShowMyVCView" object:nil];
    
}



@end
