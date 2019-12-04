//
//  XZQTopImageBottomLabelButton.h
//  YouJi
//
//  Created by dmt312 on 2019/12/4.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZQTopImageBottomLabelButton : UIButton


- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)text NormalImage:(UIImage *)normalImage SelectedImage:(UIImage *)selectedImage;

@end

NS_ASSUME_NONNULL_END
