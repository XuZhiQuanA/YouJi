//
//  TagsItem.h
//  YouJi
//
//  Created by dmt312 on 2019/12/24.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TagsItem : NSObject

@property(nonatomic,assign) CGFloat x;
@property(nonatomic,assign) CGFloat y;
@property(nonatomic,assign) CGFloat width;
@property(nonatomic,assign) CGFloat height;

+ (instancetype)itemWithX:(CGFloat)x y:(CGFloat)y width:(CGFloat)width height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
