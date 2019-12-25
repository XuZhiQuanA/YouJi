//
//  TagsItem.m
//  YouJi
//
//  Created by dmt312 on 2019/12/24.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "TagsItem.h"

@implementation TagsItem

+ (instancetype)itemWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height{
    TagsItem *item = [[TagsItem alloc] init];
    item.x = x;
    item.y = y;
    item.width = width;
    item.height = height;
    
    return item;
}

@end
