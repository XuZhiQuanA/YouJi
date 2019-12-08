//
//  ShouZhangViewController.m
//  YouJi
//
//  Created by dmt312 on 2019/12/7.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "ShouZhangViewController.h"

#import "WallPaperView.h"

#define wallPaperViewH 658

@interface ShouZhangViewController ()

/** 壁纸view*/
@property(nonatomic,readwrite,weak) WallPaperView *wallPaperView;

@end

@implementation ShouZhangViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -----------------------------
#pragma mark lazy load
- (WallPaperView *)wallPaperView{
    
    if (_wallPaperView == nil) {
        WallPaperView *paperView = [[WallPaperView alloc] init];
        [self.view addSubview:paperView];
        _wallPaperView = paperView;
    }
    
    return _wallPaperView;
}


//界面所有的按钮都会来到这里
- (IBAction)editSZViewAction:(UIButton *)sender {
    XFunc;
    XLog(@"%ld",sender.tag);
    
    switch (sender.tag) {
        case 1:
            [self returnToFancy];
            break;
        case 2:
        
        break;
            
        case 3:
        
        break;
            
        case 4:
            
            break;
        case 5:
            
            //壁纸 点击壁纸按钮 再去加载这个view 懒加载
            self.wallPaperView.hidden = false;
            
            
        break;
            
        case 6:
        
        break;
            
        case 7:
            
            break;
        case 8:
        
        break;
            
        case 9:
        
        break;
            
        default:
            break;
    }
}

#pragma mark -----------------------------
#pragma mark 布局子控件
- (void)viewWillLayoutSubviews{
    
    //wallPaperView
    self.wallPaperView.frame = CGRectMake(0, 0, ScreenW, wallPaperViewH);
    
}


#pragma mark -----------------------------
#pragma mark 返回到Fancy界面
- (void)returnToFancy{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShouZhangViewControllerWantXZQTabBarControllerShowFancyView" object:nil];
}


@end
