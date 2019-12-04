//
//  XZQTopImageBottomLabelButton.m
//  YouJi
//
//  Created by dmt312 on 2019/12/4.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "XZQTopImageBottomLabelButton.h"

@implementation XZQTopImageBottomLabelButton

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)text NormalImage:(UIImage *)normalImage SelectedImage:(UIImage *)selectedImage{
    
    XZQTopImageBottomLabelButton *btn = [XZQTopImageBottomLabelButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = frame;
    
    [btn setImage:normalImage forState:UIControlStateNormal];
    [btn setImage:selectedImage forState:UIControlStateSelected];
    
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 17, 0);
    
    [btn setTitle:text forState:UIControlStateNormal];
    btn.titleLabel.text = text;
    btn.titleLabel.font = [UIFont boldSystemFontOfSize:14];
    
    
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;//设置居中
    
    [btn setTitleColor:XColor(92, 94, 94) forState:UIControlStateNormal];
    [btn setTitleColor:XColor(134, 206, 201) forState:UIControlStateSelected];
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(0,-31,-40, 0);
    
//    CGPoint center = btn.center;
    
    
    
    
    XLog(@"%@",NSStringFromCGRect(btn.titleLabel.frame));
    XLog(@"%@",btn.titleLabel.text);
    
    return btn;
    
}

@end
