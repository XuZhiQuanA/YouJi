//
//  XZQPopBoxView.h
//  YouJi
//
//  Created by dmt312 on 2019/12/10.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,showPopBox){
    showPopBoxNone = 0,
    showPopBoxColor,
    showPopBoxSize
};

@interface XZQPopBoxView : UIView

/**展示的状态*/
@property(nonatomic,assign) showPopBox showState;

/// 自动判断 如果颜色框正在显示/隐藏 再次点击了颜色按钮 自动隐藏/显示
- (void)showPopBoxColor;

/// 自动判断 如果大小框正在显示/隐藏 再次点击了大小按钮 自动隐藏/显示
- (void)showPopBoxSize;

- (void)showPopBoxColor:(showPopBox)state;

- (void)showPopBoxSize:(showPopBox)state;

@end

NS_ASSUME_NONNULL_END
