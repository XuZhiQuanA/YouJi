//
//  UIImage+Category.m
//  YouJi
//
//  Created by dmt312 on 2019/12/3.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "UIImage+Category.h"


@implementation UIImage (Category)


+ (UIImage *)OriginalImageWithName:(NSString *)imageName{
    
    UIImage *image = [UIImage imageNamed:imageName];
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    return image;
}

+ (UIImage *)OriginalImageWithName:(NSString *)imageName toSize:(CGSize)size{
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 创建一个bitmap的context
    //并把它设置成为当前正在使用的context
//　　UIGraphicsBeginImageContext(size);
    
    UIGraphicsBeginImageContext(size);
    

    //绘制改变大小的图片

    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];

    //从当前context中创建一个改变大小后的图片

    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();

    //使用当前的congtext出堆栈

    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    
    return scaledImage;
}

+(NSData*)getDataFromImage:(UIImage*)image{
    
    NSData *data;

    /*判断图片是不是png格式的文件*/

    if(UIImagePNGRepresentation(image))

        data = UIImagePNGRepresentation(image);

    /*判断图片是不是jpeg格式的文件*/

    else

        data = UIImageJPEGRepresentation(image,1.0);

    return data;
}

@end
