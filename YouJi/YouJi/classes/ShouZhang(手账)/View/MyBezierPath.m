//
//  MyBezierPath.m
//  10-画板
//
//  Created by xiaomage on 16/1/23.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "MyBezierPath.h"

@implementation MyBezierPath

- (instancetype)init{
    self = [super init];
    
    if (self) {
        
        self.lineJoinStyle = kCGLineCapRound;
        self.lineCapStyle = kCGLineCapRound;
        
    }
    
    return self;
}

@end
