//
//  XZQVideoTableViewCell.m
//  YouJi
//
//  Created by dmt312 on 2019/12/4.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "XZQVideoTableViewCell.h"
#import "XZQVideoItem.h"



@interface XZQVideoTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *videoImageView;


@property (weak, nonatomic) IBOutlet UIImageView *showPersonImageView;
@property (weak, nonatomic) IBOutlet UILabel *showPersonNameLabel;



@end

@implementation XZQVideoTableViewCell

#pragma mark -----------------------------
#pragma mark item

//每次翻动都会来这个方法
- (void)setItem:(XZQVideoItem *)item{
    
    self.showPersonImageView.image = item.personImage;
    self.showPersonNameLabel.text = item.personName;
    [self.showPersonNameLabel sizeToFit];
    
    
    //视频URL
    self.videoPlayer.player = [AVPlayer playerWithURL:item.videoURL];
    
    
//    self.placeHolderImageView.image = item.videoImage;
    
    self.placeHolderImageView.contentMode = UIViewContentModeScaleToFill;

    if (item.videoURL == nil) {
        self.videoPlayer.view.alpha = 0;
        
        
        
    }else{
        
        
        
        //一般走这个方法
        self.videoPlayer.view.alpha = 1;

    }
    
}

#pragma mark -----------------------------
#pragma mark 懒加载
- (AVPlayerViewController *)videoPlayer{
    if (_videoPlayer == nil) {
        _videoPlayer = [[AVPlayerViewController alloc] init];
        
        _videoPlayer.view.frame = self.videoImageView.frame;
        

        [self addSubview:_videoPlayer.view];
    }
    
    return _videoPlayer;
    
}

- (UIImageView *)placeHolderImageView{
    if (_placeHolderImageView == nil) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.frame = self.videoImageView.frame;
        _placeHolderImageView = imageV;
        [self addSubview:imageV];
        
        
    }
    
    return _placeHolderImageView;
}

- (void)setFrame:(CGRect)frame{
    
    frame.size.height -= 33;
    
    [super setFrame:frame];
}


@end
