//
//  TagsView.m
//  YouJi
//
//  Created by dmt312 on 2019/12/24.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "TagsView.h"
#import "TagsItem.h"

#define showPopImageViewY 292 //327-35
#define showPopImageViewH 366 //554 - 519     405

#define scrollViewY 345 //380-35
#define scrollViewH 314 //499

#define tagsBtnBaseX 38
#define tagsBtnBaseY 22

#define hiddenSelfBtnX 190
#define hiddenSelfBtnY 305 //340-35
#define hiddenSelfBtnWH 35

#define colomn 4

@interface TagsView()
/** 展示弹框图的UIImageView*/
@property(nonatomic,readwrite,weak) UIImageView *showPopImageView;

/** 隐藏自己的按钮*/
@property(nonatomic,readwrite,weak) UIButton *hiddenSelfBtn;

/** 展示用scrollview*/
@property(nonatomic,readwrite,weak) UIScrollView *scrollView;

/** 壁纸按钮数组*/
@property(nonatomic,readwrite,strong) NSMutableArray *tagsArray;

/**tags模型数组 存放每一个tags的位置尺寸 */
@property(nonatomic,readwrite,strong) NSMutableArray<TagsItem *> *tagsItemArray;

@end

@implementation TagsView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
    
        //初始化
        [self initialize];
    }
    
    return self;
    
}

//初始化
- (void)initialize{
    
    //自身view初始化
    [self initializeSelfView];
    
    //添加显示弹框图的UIImageView
    [self setupShowPopImageView];
    
    //隐藏自己的btn
    [self setupHiddenSelfBtn];
    
    //添加scrollview
    [self setupScrollView];
    
    //创建scrollview内部的按钮
    [self setupWallPaperBtn];
    
}

//自身view初始化
- (void)initializeSelfView{
    
    //本身view alpha whiteColor
//    self.alpha = 0.5;
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
    self.hidden = true;
}

#pragma mark -----------------------------
#pragma mark 布局子控件

- (void)layoutSubviews{
    
//    布局本身子控件
    
    //showPopImageView
    self.showPopImageView.frame = CGRectMake(0, showPopImageViewY, ScreenW, showPopImageViewH);
    self.showPopImageView.image = [UIImage OriginalImageWithName:@"EditShouZhang_tags_background" toSize:self.showPopImageView.frame.size];
    
    //hiddenSelfBtn
    self.hiddenSelfBtn.frame = CGRectMake(hiddenSelfBtnX, hiddenSelfBtnY, hiddenSelfBtnWH, hiddenSelfBtnWH);
    [self.hiddenSelfBtn setImage:[UIImage OriginalImageWithName:@"EditShouZhang_wallPaperPopBox_towardBottomArrow" toSize:self.hiddenSelfBtn.frame.size] forState:UIControlStateNormal];
    
    //scrollView
    self.scrollView.frame = CGRectMake(0, scrollViewY, ScreenW, scrollViewH);
    self.scrollView.contentSize = CGSizeMake(0, scrollViewH+20);
    
    //壁纸按钮
    [self layoutWallPaperBtns];
    
}

- (void)layoutWallPaperBtns{
    
    NSInteger i = 0;
    for (UIButton *btn in self.tagsArray) {
        
        TagsItem *tagsItem = self.tagsItemArray[i];
        btn.frame = CGRectMake(tagsItem.x, tagsItem.y, tagsItem.width, tagsItem.height);
        btn.tag = (i+1);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage OriginalImageWithName:[NSString stringWithFormat:@"EditShouZhang_tags_%ld",(long)i] toSize:btn.frame.size] forState:UIControlStateNormal];
        i++;
    }
    
}

#pragma mark -----------------------------
#pragma mark btnClick

- (void)btnClick:(UIButton *)btn{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:btn.currentImage forKey:@"tagsImage"];
    [dict setObject:self.tagsItemArray[btn.tag-1] forKey:@"tagsItem"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"addTags" object:nil userInfo:dict];

}

#pragma mark -----------------------------
#pragma mark touchBegan

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = touches.allObjects[0];
//    隐藏本身
    if (CGRectContainsPoint(self.showPopImageView.frame, [touch locationInView:self]) == false) {//如果点击的点不在在showPopImageView的frame里面
        self.hidden = true;
    }
    
}

#pragma mark -----------------------------
#pragma mark 添加显示弹框图的UIImageView
- (void)setupShowPopImageView{
    
    UIImageView *showPopImageView = [[UIImageView alloc] init];
    showPopImageView.userInteractionEnabled = true;
    [self addSubview:showPopImageView];
    self.showPopImageView = showPopImageView;
}

#pragma mark -----------------------------
#pragma mark 隐藏自己的按钮
- (void)setupHiddenSelfBtn{
    UIButton *btn = [[UIButton alloc] init];
    [btn addTarget:self action:@selector(hiddenSelf:) forControlEvents:UIControlEventTouchUpInside];
    self.hiddenSelfBtn = btn;
    [self addSubview:btn];
}

- (void)hiddenSelf:(UIButton *)btn{
    self.hidden = true;
}


#pragma mark -----------------------------
#pragma mark 添加scrollview
- (void)setupScrollView{
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self addSubview:scrollView];
    self.scrollView = scrollView;
    
}


#pragma mark -----------------------------
#pragma mark 创建scrollview内部的按钮
- (void)setupWallPaperBtn{
    
    NSInteger count = 12;
    
    for (NSInteger i = 0; i < count; i++) {
        UIButton *btn = [[UIButton alloc]init];
        btn.tag = i;
        [self.tagsArray addObject:btn];
        [self.scrollView addSubview:btn];
    }
    
}

#pragma mark -----------------------------
#pragma mark 懒加载
- (NSMutableArray *)tagsArray{
    if (_tagsArray == nil) {
        _tagsArray = [NSMutableArray array];
    }
    
    return _tagsArray;
}

- (NSMutableArray *)tagsItemArray{
    
    if (_tagsItemArray == nil) {
        
        _tagsItemArray = [NSMutableArray array];
        
        for (NSInteger i = 0; i<12; i++) {
            TagsItem *item;
            
            switch (i) {
                    
                case 0:
                    item = [TagsItem itemWithX:38 y:22 width:36 height:56];
                    break;
                    
                case 1:
                    item = [TagsItem itemWithX:134 y:22 width:36 height:56];
                    break;
                
                case 2:
                    item = [TagsItem itemWithX:230 y:22 width:36 height:56];
                    break;
                    
                case 3:
                    item = [TagsItem itemWithX:326 y:22 width:36 height:56];
                    break;
                    
                case 4:
                    item = [TagsItem itemWithX:38 y:121 width:36 height:56];
                    break;
                    
                case 5:
                    item = [TagsItem itemWithX:122 y:128 width:56 height:56];
                    break;
                    
                case 6:
                    item = [TagsItem itemWithX:226 y:133 width:52 height:36];
                    break;
                    
                case 7:
                    item = [TagsItem itemWithX:316 y:119 width:56 height:56];
                    break;
                    
                case 8:
                    item = [TagsItem itemWithX:31 y:220 width:50 height:50];
                    break;
                    
                case 9:
                    item = [TagsItem itemWithX:124 y:218 width:55 height:52];
                    break;
                    
                case 10:
                    item = [TagsItem itemWithX:232 y:212 width:40 height:52];
                    break;
                    
                case 11:
                    item = [TagsItem itemWithX:315 y:223 width:52 height:37];
                    break;
                    
                default:
                    break;
            }
            
            [_tagsItemArray addObject:item];
        }
        
    }
    
    return _tagsItemArray;
}

@end
