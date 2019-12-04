//
//  XZQVideoTableViewCell.h
//  YouJi
//
//  Created by dmt312 on 2019/12/4.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>

NS_ASSUME_NONNULL_BEGIN

@class XZQVideoItem;
@interface XZQVideoTableViewCell : UITableViewCell

/**模型 */
@property(nonatomic,readwrite,strong) XZQVideoItem *item;

/** 视频占位图*/
@property(nonatomic,readwrite,weak) UIImageView *placeHolderImageView;

/**视频播放器 */
@property(nonatomic,readwrite,strong) AVPlayerViewController *videoPlayer;

@end

NS_ASSUME_NONNULL_END
