//
//  XZQTableViewCellTwo.m
//  YouJi
//
//  Created by dmt312 on 2019/12/5.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "XZQTableViewCellTwo.h"


@interface XZQTableViewCellTwo()



@end

@implementation XZQTableViewCellTwo

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //监听通知
    [self receiveNotification];
}

#pragma mark -----------------------------
#pragma mark 监听通知
- (void)receiveNotification{
    
    //XZQMySettingViewWangToChangeUserName
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startEditing) name:@"XZQMySettingViewWangToChangeUserName" object:nil];
    
}

#pragma mark -----------------------------
#pragma mark 开始编辑
- (void)startEditing{
    
    XFunc;
    
    [self.nameLabel becomeFirstResponder];
    
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
