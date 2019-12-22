//
//  LRViewController.h
//  YouJi
//
//  Created by dmt312 on 2019/12/21.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LRViewController : UIViewController

/**子控件view的顺序*/
@property(nonatomic,assign) NSInteger childVcViewIndex;

- (void)changeChildVcViewWithIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
