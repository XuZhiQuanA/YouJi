//
//  XZQTableViewCellOne.m
//  YouJi
//
//  Created by dmt312 on 2019/12/5.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "XZQTableViewCellOne.h"

@interface XZQTableViewCellOne()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;



@end

@implementation XZQTableViewCellOne

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self receiceNotification];
}

#pragma mark -----------------------------
#pragma mark 接收通知
- (void)receiceNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTouXiang:) name:@"XZQTabBarControllerWantChangeTouXiang" object:nil];
}

#pragma mark -----------------------------
#pragma mark 改变头像
- (void)changeTouXiang:(NSNotification *)notification{
    
    UIImage *image = notification.userInfo[@"touxiang"];
    self.imageV.image = image;
    
    
}

@end
