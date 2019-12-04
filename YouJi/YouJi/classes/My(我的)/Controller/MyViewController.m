//
//  MyViewController.m
//  YouJi
//
//  Created by dmt312 on 2019/12/3.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "MyViewController.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = XRandomColor;
}

//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
