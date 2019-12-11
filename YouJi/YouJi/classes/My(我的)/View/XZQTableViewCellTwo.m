//
//  XZQTableViewCellTwo.m
//  YouJi
//
//  Created by dmt312 on 2019/12/5.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "XZQTableViewCellTwo.h"


@interface XZQTableViewCellTwo()<UITextFieldDelegate>



@end

@implementation XZQTableViewCellTwo

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //监听通知
    [self receiveNotification];
    
    //设置nameTextField的代理为自身
    self.nameTextField.delegate = self;
}

#pragma mark -----------------------------
#pragma mark 监听通知
- (void)receiveNotification{
    
    //XZQMySettingViewWangToChangeUserName
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startEditing) name:@"XZQMySettingViewWangToChangeUserName" object:nil];
    
//    XZQMySettingViewWantHideKeyBoard
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyBoard) name:@"XZQMySettingViewWantHideKeyBoard" object:nil];
}


//停止编辑
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:textField.text forKey:@"userName"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"saveUserName" object:nil userInfo:dict];
    
}


#pragma mark -----------------------------
#pragma mark 开始编辑
- (void)hideKeyBoard{
    
    XFunc;
    
    [self.nameTextField resignFirstResponder];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
