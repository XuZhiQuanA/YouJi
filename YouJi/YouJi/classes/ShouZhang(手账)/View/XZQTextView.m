//
//  XZQTextView.m
//  YouJi
//
//  Created by dmt312 on 2019/12/8.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "XZQTextView.h"
#import "KBTextView.h"

@interface XZQTextView(){
//  记录初始化的height
    CGFloat _initHeight;
}

@property(nonatomic,readwrite,strong) KBTextView *textView;

/** placeholder的label */
@property (nonatomic,strong) UILabel *placeholderLabel;

@property(nonatomic,readwrite,weak) UIPanGestureRecognizer *panGesture;

@end

@implementation XZQTextView

/** 重写初始化方法 */
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 记录初始高度
        _initHeight = frame.size.height;
        self.clipsToBounds = NO;
 
        // 添加textView
        self.textView = [[KBTextView alloc]initWithFrame:self.bounds];
        [self addSubview:self.textView];
        self.textView.delegate = (id)self;
        self.textView.backgroundColor = [UIColor blueColor];
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(textViewPan:)];
        self.panGesture = pan;
        [self addGestureRecognizer:pan];
 
        // 添加placeholderLabel
        self.placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(3, 0, frame.size.width - 3, frame.size.height)];
        [self addSubview:self.placeholderLabel];
        self.placeholderLabel.backgroundColor = [UIColor clearColor];
        self.placeholderLabel.textColor = [UIColor lightGrayColor];
    }
    return self;
}
 
// 赋值placeholder
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = placeholder;
    self.placeholderLabel.text = placeholder;
    [self.placeholderLabel sizeToFit];
    self.placeholderLabel.center = self.textView.center;
    
    XLog(@"setPlaceholder%@",NSStringFromCGRect(self.placeholderLabel.frame));
    
}
 
// 赋值font
- (void)setFont:(UIFont *)font{
    self.textView.font = self.placeholderLabel.font = font;
    // 重新调整placeholderLabel的大小
    [self.placeholderLabel sizeToFit];
    self.placeholderLabel.center = self.textView.center;
    
    XLog(@"setFont%@",NSStringFromCGRect(self.placeholderLabel.frame));
}
 
/** textView文本内容改变时回调 */
- (void)textViewDidChange:(UITextView *)textView{
    
    self.panGesture.enabled = false;
    textView.scrollEnabled = true;
    
    // 计算高度
    CGSize size = CGSizeMake(self.textView.frame.size.width, CGFLOAT_MAX);
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.textView.font,NSFontAttributeName, nil];
    CGFloat curheight = [textView.text boundingRectWithSize:size
                                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                 attributes:dic
                                                    context:nil].size.height;
    // 如果高度小于初始化时的高度，则不赋值(仍采用最初的高度)
    if (curheight < _initHeight) {
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, _initHeight);
        self.textView.frame = CGRectMake(self.textView.frame.origin.x, self.textView.frame.origin.y, self.textView.frame.size.width, _initHeight);
    }else{
        // 重新给frame赋值(改变高度)
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, curheight+20);
        self.textView.frame = CGRectMake(self.textView.frame.origin.x, self.textView.frame.origin.y, self.textView.frame.size.width, curheight+20);
    }
 
    // 如果文本为空，显示placeholder
    if (textView.text.length == 0) {
        self.placeholderLabel.hidden = NO;
        self.placeholderLabel.center = self.textView.center;
    }else{
        self.placeholderLabel.hidden = YES;
    }
}

- (void)quitKeyBoard{
    
    [self.textView resignFirstResponder];
    
     
}

//文字
- (void)textViewPan:(UIPanGestureRecognizer *)pan{
    CGPoint curPoint = [pan translationInView:pan.view];

//    if (curPoint.y >= (ScreenH - 78)) {
//        curPoint.y = (ScreenH - 78);
//    }
//
//    if (curPoint.y <= 49) {
//        curPoint.y = 49;
//    }
    
    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, curPoint.x, curPoint.y);

    [pan setTranslation:CGPointZero inView:pan.view];
    
//    CGPoint translation = [pan translationInView:pan.view];
//    CGPoint newCenter = CGPointMake(pan.view.center.x+ translation.x,
//                                    pan.view.center.y + translation.y);//    限制屏幕范围：
//    newCenter.y = MAX((ScreenH-78-self.frame.size.height/2), newCenter.y);
//    newCenter.y = MIN(49+self.frame.size.height/2,  newCenter.y);
//    newCenter.x = MAX(ScreenW - self.frame.size.width/2, newCenter.x);
//    newCenter.x = MIN(self.frame.size.width/2,newCenter.x);
//    pan.view.center = newCenter;
//    [pan setTranslation:CGPointZero inView:pan.view];
    
    
    if (self.frame.origin.y >= (ScreenH - 78-self.frame.size.height)) {
         CGRect frame = self.frame;
         frame.origin.y = (ScreenH - 78-self.frame.size.height);
         self.frame = frame;
     }
     
     if (self.frame.origin.y <= 49) {
         CGRect frame = self.frame;
         frame.origin.y = 49;
         self.frame = frame;
     }
     
     if (self.frame.origin.x >= (ScreenW-self.frame.size.width)) {
         CGRect frame = self.frame;
         frame.origin.x = (ScreenW-self.frame.size.width);
         self.frame = frame;
     }
     
     if (self.frame.origin.x <= 0) {
         CGRect frame = self.frame;
         frame.origin.x = 0;
         self.frame = frame;
     }
    
    
    
    
    
    XFunc;
    
}

//textView结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView{
    
    //pan手势开启
    self.panGesture.enabled = true;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    XLog(@"XZQTextView - touchesBegan");
    
}

@end
