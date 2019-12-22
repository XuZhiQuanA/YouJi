//
//  LoginViewController.m
//  YouJi
//
//  Created by dmt312 on 2019/12/21.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "LoginViewController.h"
#import "LRViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
}

- (IBAction)loginOrRegisterBtnClick:(UIButton *)sender {
    
    
    XFunc
    
    switch (sender.tag) {
        case 1:
            XFunc
            //登录
            if (self.parentViewController.view.tag == 1) {
                

//            if ([self.parentViewController isKindOfClass:[LRViewController class]]) {
                LRViewController *vc = (LRViewController *)self.parentViewController;
                vc.childVcViewIndex = 0;
                [vc changeChildVcViewWithIndex:vc.childVcViewIndex];
            }
            break;
            
        case 2:
            XFunc
            //注册
            if (self.parentViewController.view.tag == 1) {
//            if ([self.parentViewController isKindOfClass:[LRViewController class]]) {
                LRViewController *vc = (LRViewController *)self.parentViewController;
                vc.childVcViewIndex = 1;
                [vc changeChildVcViewWithIndex:vc.childVcViewIndex];
            }
        break;
            
        default:
            break;
    }
    
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
