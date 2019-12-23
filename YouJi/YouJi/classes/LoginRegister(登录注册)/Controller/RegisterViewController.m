//
//  RegisterViewController.m
//  YouJi
//
//  Created by dmt312 on 2019/12/21.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "RegisterViewController.h"
#import "LRViewController.h"
#import "SVProgressHUD.h"
#import <SMS_SDK/SMSSDK.h>

@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@property (weak, nonatomic) IBOutlet UITextField *checkTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;


@property (weak, nonatomic) IBOutlet UIButton *checkBtn;

@property(nonatomic,readwrite,weak) UIViewController *parentVc;

@property(nonatomic,readwrite,strong) NSUserDefaults *userDefault;
//定时器
@property(nonatomic,readwrite,weak) NSTimer *timer;

@property(nonatomic,assign) NSInteger seconds;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.seconds = 60;
}


- (IBAction)returnToLogin:(UIButton *)sender {
    
    if (self.parentVc != nil) {
        if (self.parentVc.view.tag == 1) {
            LRViewController *vc = (LRViewController *)self.parentVc;
            vc.childVcViewIndex = 0;
            [vc changeChildVcViewWithIndex:vc.childVcViewIndex];
        }
    }
    
}


//点击发送验证码
- (IBAction)sendCheckBtnClick:(UIButton *)sender {
    
    if (self.timer) return;
    
    if (self.phoneNumberTextField.text.length != 11) {
        //提示电话号码格式不正确
        [self popBoxWithString:@"电话号码格式不正确" delay:1.0];
        return;
        
    }
    
    //点击之后 立马变成60s
    if ([sender.titleLabel.text isEqualToString:@"发送验证码"]){
        
        self.checkBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        //启动计时器
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(changeSeconds) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        self.timer = timer;
        
        //template参数不能乱填，没有可以先传""或者nil

        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneNumberTextField.text zone:@"86" template:nil result:^(NSError *error) {

              if (!error)
              {
                  // 请求成功
                  [self popBoxWithString:@"验证码发送成功" delay:1.0];
              }
              else
              {
                  // error
                  [self popBoxWithString:@"验证码发送失败 请稍后重新发送" delay:1.0];
              }
          }];
        
    }
    
    
}


#pragma mark -----------------------------
#pragma mark 注册检测
//这里传递一个nil给returnToLogin方法
- (IBAction)registerBtnClick:(UIButton *)sender {
    
    
    //验证号码位数
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
    
    //密码不能少于6位
      if (self.pwdTextField.text.length < 6){
          
          [self popBoxWithString:@"密码不能少于6个字符" delay:1.0];
          return;
      }
    
    __weak typeof(self) weakSelf = self;
    
    //验证码是否正确
    [SMSSDK commitVerificationCode:self.checkTextField.text phoneNumber:self.phoneNumberTextField.text zone:@"86" result:^(NSError *error) {

        if (!error)
        {
            // 验证成功
            [self popBoxWithString:@"注册成功" delay:1.5 completion:^{
                //保存在偏好设置中
                [weakSelf.userDefault setObject:self.phoneNumberTextField.text forKey:@"phoneNumber"];
                [weakSelf.userDefault setObject:self.pwdTextField.text forKey:@"pwd"];
                [weakSelf.userDefault synchronize];

                [self quitAllKeyBoard];
                [weakSelf returnToLogin:nil];
                
            }];
        }
        else
        {
            // error
            [weakSelf popBoxWithString:@"验证码错误" delay:1.5 completion:nil];
            weakSelf.seconds = -1;
            [weakSelf changeSeconds];
        }
    }];
    

    
    
    

}

#pragma mark -----------------------------
#pragma mark 传递一个提示框字符串
- (void)popBoxWithString:(NSString *)str delay:(CGFloat)delay{
    
    [self popBoxWithString:str delay:delay completion:nil];
    
}

- (void)popBoxWithString:(NSString *)str delay:(CGFloat)delay completion:(void(^)(void))completion{

    
    if ([str containsString:@"成功"])
        [SVProgressHUD showSuccessWithStatus:str];
    else
        [SVProgressHUD showErrorWithStatus:str];
    

    __weak typeof(self) weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //退出提示框
        [SVProgressHUD dismiss];
        
        //
        if (completion)
            completion();
        
        //退出键盘
        [weakSelf.phoneNumberTextField resignFirstResponder];
        [weakSelf.pwdTextField resignFirstResponder];
    });
    
    
        

}

#pragma mark -----------------------------
#pragma mark 每隔一秒改变秒数
- (void)changeSeconds{
    
    self.seconds--;
    
    if (self.seconds < 0) {
        
        [self.timer invalidate];
        self.timer = nil;
        self.checkBtn.titleLabel.text = @"发送验证码";
        self.seconds = 60;
        return;
    }
    
        
    self.checkBtn.titleLabel.text = [NSString stringWithFormat:@"%ld",(long)self.seconds];
    
}

#pragma mark -----------------------------
#pragma mark 懒加载

- (UIViewController *)parentVc{
    if (_parentVc == nil) {
        
        _parentVc = self.parentViewController;
    }
    
    return _parentVc;
}

- (NSUserDefaults *)userDefault{
    if (_userDefault == nil) {
        _userDefault = [NSUserDefaults standardUserDefaults];
    }
    
    return _userDefault;
}

#pragma mark -----------------------------
#pragma mark 退出所有键盘
- (void)quitAllKeyBoard{
    [self.phoneNumberTextField resignFirstResponder];
    [self.checkTextField resignFirstResponder];
    [self.pwdTextField resignFirstResponder];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self quitAllKeyBoard];
}

@end
