//
//  XZQVideoItem.h
//  YouJi
//
//  Created by dmt312 on 2019/12/4.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XZQVideoItem : NSObject

/**视频预览图 */
@property(nonatomic,readwrite,strong) UIImage *videoImage;

/**视频URL */
@property(nonatomic,readwrite,strong) NSURL *videoURL;

/**用户头像 */
@property(nonatomic,readwrite,strong) UIImage *personImage;

/**用户昵称 */
@property(nonatomic,readwrite,strong) NSString *personName;

+ (instancetype)itemWithArray:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
