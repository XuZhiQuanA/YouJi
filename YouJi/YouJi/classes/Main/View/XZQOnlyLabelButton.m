//
//  XZQOnlyLabelButton.m
//  YouJi
//
//  Created by dmt312 on 2019/12/4.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "XZQOnlyLabelButton.h"

@implementation XZQOnlyLabelButton

- (instancetype)initWithFrame:(CGRect)frame Title:(NSString *)text{
    
    XZQOnlyLabelButton *btn = [XZQOnlyLabelButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    
    //将图片移动移动出去了
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 50, 17, 0);
    
    
    [btn setTitle:text forState:UIControlStateNormal];
    btn.titleLabel.text = text;
    btn.titleLabel.font = [UIFont systemFontOfSize:24];
    
    
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;//设置居中
    
    [btn setTitleColor:XColor(92, 94, 94) forState:UIControlStateNormal];
    [btn setTitleColor:XColor(134, 206, 201) forState:UIControlStateSelected];
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(0,0,0, 0);
    
    return btn;
    
}

@end
