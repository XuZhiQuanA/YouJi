//
//  LoginViewController.m
//  YouJi
//
//  Created by dmt312 on 2019/12/21.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "LoginViewController.h"
#import "LRViewController.h"
#import "SVProgressHUD.h"
#import "XZQTabBarController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;

@property(nonatomic,readwrite,strong) NSUserDefaults *userDefault;

@property (weak, nonatomic) IBOutlet UIImageView *personalImageView;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    
    //之前有没有设置头像
    [self checkPersonalImage];
}

#pragma mark -----------------------------
#pragma mark 检测之前有没有设置过头像
- (void)checkPersonalImage{
    //personalImage
    if ([self.userDefault dataForKey:@"UserHeadImageData"] != nil) {
        NSData *userHeadImageData = [self.userDefault dataForKey:@"UserHeadImageData"];
        UIImage *userHeadImage = [UIImage imageWithData:userHeadImageData];
        self.personalImageView.contentMode = UIViewContentModeScaleAspectFit;
        self.personalImageView.image = userHeadImage;
    }
}


- (IBAction)loginOrRegisterBtnClick:(UIButton *)sender {
    
    XFunc
    
    switch (sender.tag) {
        case 1:
            XFunc
            //登录
            [self checkUserAccountAndPwd];
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

#pragma mark -----------------------------
#pragma mark 数据部分
//检测电话号码和密码
- (void)checkUserAccountAndPwd{
    
    //号码
    if (self.phoneNumberTextField.text.length != 11) {
        
        //提示电话号码格式不正确
        [self popBoxWithString:@"电话号码格式不正确" delay:1.0];
        return;
        
    }
    
    //密码不为空
    if (self.pwdTextField.text.length == 0){
        
        [self popBoxWithString:@"密码不能为空" delay:1.0];
        
        return;
    }
    
    //输入数据和偏好设置进行对比
    
    //比较账号
    if ([self.phoneNumberTextField.text isEqualToString:(NSString *)[self.userDefault objectForKey:@"phoneNumber"]] == false) {
        
        [self popBoxWithString:@"该号码尚未注册" delay:1.0];
        
        return;
    }
    
    
   //比较密码
    if ([self.pwdTextField.text isEqualToString:(NSString *)[self.userDefault objectForKey:@"pwd"]] == false) {
        
        [self popBoxWithString:@"密码不正确" delay:1.0];
        
        return;
    }
        
    //登录成功
//    [self popBoxWithString:@"登录成功" delay:1.0];
    [self popBoxWithString:@"loading... 客官请稍等~" delay:3.0 completion:^{
        //切换tab view controller 子控制器
        [self changeTabViewChildVc];
    }];
    
    
    
}

#pragma mark -----------------------------
#pragma mark 传递一个提示框字符串
- (void)popBoxWithString:(NSString *)str delay:(CGFloat)delay{
    
    [self popBoxWithString:str delay:delay completion:nil];
    
}

- (void)popBoxWithString:(NSString *)str delay:(CGFloat)delay completion:(void(^)(void))completion{
    
    if ([str containsString:@"成功"] || [str containsString:@"loading"])
        [SVProgressHUD showSuccessWithStatus:str];
    else
        [SVProgressHUD showErrorWithStatus:str];


    __weak typeof(self) weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //退出提示框
        [SVProgressHUD dismiss];
        
        //退出键盘
        [weakSelf.phoneNumberTextField resignFirstResponder];
        [weakSelf.pwdTextField resignFirstResponder];
        
        //
        if (completion)
            completion();
        
        
    });
    
    
        

}

#pragma mark -----------------------------
#pragma mark 切换tab view controller 子控制器
- (void)changeTabViewChildVc{
    
    XZQTabBarController *tabVc = [[XZQTabBarController alloc] init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = tabVc;

}

#pragma mark -----------------------------
#pragma mark touchbegin

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.phoneNumberTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
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
