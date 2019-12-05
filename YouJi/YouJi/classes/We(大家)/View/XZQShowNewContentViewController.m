//
//  XZQShowNewContentViewController.m
//  YouJi
//
//  Created by dmt312 on 2019/12/5.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "XZQShowNewContentViewController.h"

@interface XZQShowNewContentViewController ()

@end

@implementation XZQShowNewContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.backgroundColor = XRandomColor;
    scrollView.contentSize = CGSizeMake(0, 1000);
    [self.view addSubview:scrollView];
    
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
