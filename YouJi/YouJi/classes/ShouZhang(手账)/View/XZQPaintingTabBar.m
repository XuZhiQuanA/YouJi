//
//  XZQPaintingTabBar.m
//  YouJi
//
//  Created by dmt312 on 2019/12/9.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "XZQPaintingTabBar.h"

@implementation XZQPaintingTabBar

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        //初始化
        [self initialize];
        
    }
    
    return self;
}

//添加按钮
- (void)initialize{
    self.backgroundColor = [UIColor redColor];
}

//布局子控件
- (void)layoutSubviews{
    
}

@end
