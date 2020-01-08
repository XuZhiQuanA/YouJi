//
//  SelectionView.m
//  YouJi
//
//  Created by dmt312 on 2020/1/8.
//  Copyright © 2020 XZQ. All rights reserved.
//

#import "SelectionView.h"
#import "XZQNoHighlightedButton.h"

#define selectionLightViewH 314

@interface SelectionView()

/** 私密*/
@property(nonatomic,readwrite,weak) XZQNoHighlightedButton *privateBtn;

/** 公开*/
@property(nonatomic,readwrite,weak) XZQNoHighlightedButton *publicBtn;

/**选中的按钮 */
@property(nonatomic,readwrite,strong) XZQNoHighlightedButton *selectedBtn;

@end

@implementation SelectionView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    for (UIView *view in self.subviews) {
        if (view.tag == 1) {
            self.privateBtn = (XZQNoHighlightedButton *)view;
        }else if (view.tag == 2){
            self.publicBtn = (XZQNoHighlightedButton *)view;
        }
    }
    
    self.selectedBtn = self.privateBtn;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    UIView *view = touch.view;
    
    //
    if (view.frame.origin.y < (ScreenH - selectionLightViewH)) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectionViewRemovedNotification" object:nil];
    }
    
    
}


- (IBAction)btnClick:(XZQNoHighlightedButton *)sender {
    
    self.selectedBtn.selected = false;
    sender.selected = true;
    self.selectedBtn = sender;
    
    self.selectedBtn.bounds = CGRectMake(0, 0, self.selectedBtn.bounds.size.width*1.4, self.selectedBtn.bounds.size.height*1.4);
    
}

//确定
- (IBAction)sureBtn:(UIButton *)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SaveShouZhangSelfEditNotification" object:nil];
}


@end
