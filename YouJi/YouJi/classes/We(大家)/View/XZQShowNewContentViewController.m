//
//  XZQShowNewContentViewController.m
//  YouJi
//
//  Created by dmt312 on 2019/12/5.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "XZQShowNewContentViewController.h"

@interface XZQShowNewContentViewController ()

/** 背景scrollView*/
@property(nonatomic,readwrite,weak) UIScrollView *backgroundScrollView;

/** 背景图*/
@property(nonatomic,readwrite,weak) UIImageView *backgroundImageView;

@end

@implementation XZQShowNewContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    scrollView.backgroundColor = XRandomColor;
//    scrollView.contentSize = CGSizeMake(0, 1000);
    [self.view addSubview:scrollView];
    self.backgroundScrollView = scrollView;
    
    UIImageView *backgroundImageView = [[UIImageView alloc] init];
    backgroundImageView.frame = scrollView.bounds;
    [scrollView addSubview:backgroundImageView];
    self.backgroundImageView = backgroundImageView;
    
}

- (void)setLongImage:(UIImage *)longImage{
    _longImage = longImage;
    
    CGSize size = longImage.size;
    
    self.backgroundScrollView.contentSize = CGSizeMake(0, size.height+40);
    self.backgroundImageView.frame = CGRectMake(0, 0, ScreenW, size.height);
    self.backgroundImageView.image = longImage;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
