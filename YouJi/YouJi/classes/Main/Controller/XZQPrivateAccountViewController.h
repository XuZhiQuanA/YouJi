//
//  XZQPrivateAccountViewController.h
//  YouJi
//
//  Created by dmt312 on 2019/12/23.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZQPrivateAccountViewController : UIViewController
/**标题 公有还是私有 */
@property(nonatomic,readwrite,copy) NSString *title;

/**是否是私有账本 切换图片实现*/
@property(nonatomic,assign) BOOL isPrivate;

/**第一张Year图的名称 */
@property(nonatomic,readwrite,strong) NSString *firstImageName;

/**第二张Year图的名称 */
@property(nonatomic,readwrite,strong) NSString *secondImageName;

@end

NS_ASSUME_NONNULL_END
