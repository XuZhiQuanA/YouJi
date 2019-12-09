//
//  XZQTextView.h
//  YouJi
//
//  Created by dmt312 on 2019/12/8.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZQTextView : UIView

@property(nonatomic,readwrite,strong) NSString *placeholder;

@property(nonatomic,readwrite,strong) UIFont *font;

- (void)quitKeyBoard;

@end

NS_ASSUME_NONNULL_END
