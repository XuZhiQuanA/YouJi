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

@property(nonatomic,readwrite,strong) NSUserDefaults *userDefault;

@end

@implementation XZQTableViewCellOne

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self receiceNotification];
    
    //3.之前有没有设置头像
    [self checkPersonalImage];
}

#pragma mark -----------------------------
#pragma mark 检测之前有没有设置过头像
- (void)checkPersonalImage{
    //personalImage
    if ([self.userDefault dataForKey:@"UserHeadImageData"] != nil) {
        NSData *userHeadImageData = [self.userDefault dataForKey:@"UserHeadImageData"];
        UIImage *userHeadImage = [UIImage imageWithData:userHeadImageData];
        self.imageV.contentMode = UIViewContentModeScaleAspectFit;
        self.imageV.image = userHeadImage;
    }
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

#pragma mark -----------------------------
#pragma mark 懒加载
- (NSUserDefaults *)userDefault{
    if (_userDefault == nil) {
        _userDefault = [NSUserDefaults standardUserDefaults];
    }
    
    return _userDefault;
}

@end
