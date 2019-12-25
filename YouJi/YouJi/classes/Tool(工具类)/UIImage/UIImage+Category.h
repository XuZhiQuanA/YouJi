//
//  UIImage+Category.h
//  YouJi
//
//  Created by dmt312 on 2019/12/3.
//  Copyright © 2019 XZQ. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (Category)


/// 返回无渲染的图
/// @param imageName 图片的名称
+ (UIImage *)OriginalImageWithName:(NSString *)imageName;

+ (UIImage *)OriginalImageWithName:(NSString *)imageName toSize:(CGSize)size;

- (UIImage *)imageWithSize:(CGSize)size;

+(NSData*)getDataFromImage:(UIImage*)image;
@end

NS_ASSUME_NONNULL_END
