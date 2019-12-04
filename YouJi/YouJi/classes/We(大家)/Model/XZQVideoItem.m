//
//  XZQVideoItem.m
//  YouJi
//
//  Created by dmt312 on 2019/12/4.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "XZQVideoItem.h"

@implementation XZQVideoItem


 
 

+ (instancetype)itemWithArray:(NSDictionary *)dict{
    
    XZQVideoItem *item = [[XZQVideoItem alloc] init];
    
    NSString *videoImageName = dict[@"videoImageName"];
    NSString *videoPath = dict[@"videoPath"];
    NSString *personImageName = dict[@"personImageName"];
    NSString *personName = dict[@"personName"];
    
    if (videoImageName) {
        item.videoImage = [UIImage imageNamed:videoImageName];
    }
    
    if (videoPath) {
        item.videoURL = [NSURL URLWithString:videoPath];
    }
    
    if (personImageName) {
        item.personImage = [UIImage imageNamed:personImageName];
    }
    
    if (personName) {
        item.personName = personName;
    }
    
    return item;
}

@end
