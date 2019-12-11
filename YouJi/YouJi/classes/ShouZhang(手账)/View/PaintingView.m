//
//  PaintingView.m
//  YouJi
//
//  Created by dmt312 on 2019/12/9.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "PaintingView.h"
#import "MyBezierPath.h"

@interface PaintingView()

/** 当前绘制的路径 */
@property (nonatomic, strong) UIBezierPath *path;

//保存当前绘制的所有路径
@property (nonatomic, strong) NSMutableArray *allPathArray;

//当前路径的线宽
@property (nonatomic, assign) CGFloat width;

//当前路径的颜色
@property (nonatomic, strong) UIColor *color;

/**将撤销所删除的path保存起来  */
@property(nonatomic,readwrite,strong) NSMutableArray *saveDeletePathArray;

/**盛放传递过来的改变颜色和大小的按钮的tag */
@property(nonatomic,readwrite,strong) NSMutableDictionary *dict;

@end

@implementation PaintingView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        //添加手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [self addGestureRecognizer:pan];
        
        self.width = 1;
        self.color = [UIColor blackColor];
        
        //监听通知 XZQPopBoxViewWantChangeColorAndSizeOfPen
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeColorOrSize:) name:@"XZQPopBoxViewWantChangeColorAndSizeOfPen" object:nil];
        
        
    }
    
    
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    //添加手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    
    self.width = 1;
    self.color = [UIColor blackColor];
}


-(void)setImage:(UIImage *)image {
    _image = image;
    
    //添加图片添加到数组当中
    [self.allPathArray addObject:image];
    //重绘
    [self setNeedsDisplay];
}


//清屏
- (void)clear {
    //清空所有的路径
    [self.allPathArray removeAllObjects];
    //重绘
    [self setNeedsDisplay];
    
}
//撤销
- (void)undo {
    //删除最后一个路径
    [self.allPathArray removeLastObject];
    //重绘
    [self setNeedsDisplay];
}
//橡皮擦
- (void)erase {
    [self setLineColor:[UIColor whiteColor]];
}

//设置线的宽度
- (void)setLineWith:(CGFloat)lineWidth {
    self.width = lineWidth;
}

//设置线的颜色
- (void)setLineColor:(UIColor *)color {
    self.color = color;
}



- (void)pan:(UIPanGestureRecognizer *)pan {
    
    //获取的当前手指的点
    CGPoint curP = [pan locationInView:self];
    //判断手势的状态
    if(pan.state == UIGestureRecognizerStateBegan) {
        //创建路径
        //UIBezierPath *path = [UIBezierPath bezierPath];
        MyBezierPath *path = [[MyBezierPath alloc] init];
        self.path = path;
        //设置起点
        [path moveToPoint:curP];
        
        //设置线的宽度
        [path setLineWidth:self.width];
        //设置线的颜色
        //什么情况下自定义类:当发现系统原始的功能,没有办法瞒足自己需求时,这个时候,要自定义类.继承系统原来的东西.再去添加属性自己的东西.
        path.color = self.color;
        
        [self.allPathArray addObject:path];
        
    } else if(pan.state == UIGestureRecognizerStateChanged) {
        
        //绘制一根线到当前手指所在的点
        [self.path addLineToPoint:curP];
        //重绘
        [self setNeedsDisplay];
    }
    
}

-(void)drawRect:(CGRect)rect {
    
    //绘制保存的所有路径
    for (MyBezierPath *path in self.allPathArray) {
        //判断取出的路径真实类型
        if([path isKindOfClass:[UIImage class]]) {
            UIImage *image = (UIImage *)path;
            [image drawInRect:rect];
        }else {
            [path.color set];
            [path stroke];
        }
      
    }
    
}

#pragma mark -----------------------------
#pragma mark 改变画笔的颜色和大小
- (void)changeColorOrSize:(NSNotification *)notification{
    
    XFunc;
//    NSString *TagOfBtn = (NSString *)[self.dict objectForKey:@"TagOfBtn"];
    NSString *TagOfBtn = (NSString *)notification.userInfo[@"TagOfBtn"];
    
    NSInteger tag = [TagOfBtn integerValue];
    
    if (tag < 27)
        self.color = [self paintColor:tag];
    else
        self.width = [self paintSize:tag];
    
    
    
}

#pragma mark -----------------------------
#pragma mark 改变画笔状态
- (UIColor *)paintColor:(NSInteger)tag{
    
    UIColor *color;
    
    switch (tag) {
        case 2:
            color = XColor(0, 0, 0);
            break;
            
        case 3:
            color = XColor(255, 255, 255);
            break;
            
        case 4:
            color = XColor(159, 140, 122);
            break;
            
        case 5:
            color = XColor(114, 113, 113);
            break;
            
        case 6:
            color = XColor(69, 159, 227);
            break;
        
        case 7:
            color = XColor(109, 191, 235);
            break;
            
        case 8:
            color = XColor(147, 182, 221);
            break;
            
        case 9:
            color = XColor(96, 114, 177);
            break;
            
        case 10:
            color = XColor(211, 45, 38);
            break;
            
        case 11:
            color = XColor(221, 119, 135);
            break;
            
        case 12:
            color = XColor(220, 119, 165);
            break;
            
        case 13:
            color = XColor(235, 183, 179);
            break;
            
        case 14:
            color = XColor(183, 213, 170);
            break;
            
        case 15:
            color = XColor(153, 192, 67);
            break;
        
        case 16:
            color = XColor(64, 142, 69);
            break;
            
        case 17:
            color = XColor(144, 192, 114);
            break;
        
        case 18:
            color = XColor(246, 237, 82);
            break;
            
        case 19:
            color = XColor(242, 242, 178);
            break;
            
        case 20:
            color = XColor(238, 183, 76);
            break;
            
        case 21:
            color = XColor(229, 148, 90);
            break;
            
        case 22:
            color = XColor(169, 148, 192);
            break;
            
        case 23:
            color = XColor(167, 175, 213);
            break;
            
        case 24:
            color = XColor(172, 213, 215);
            break;
            
        case 25:
            color = XColor(95, 154, 149);
            break;
            
        default:
            color = XColor(0, 0, 0);
            break;
    }
    
    return color;
    
}

- (CGFloat)paintSize:(NSInteger)tag{
    
    switch (tag) {
        case 28:
            return 2.0;
            break;
            
        case 29:
            return 4.0;
            break;
            
        case 30:
            return 8.0;
            break;
            
        case 31:
            return 16.0;
            break;
            
        case 32:
            return 32.0;
            break;
            
        case 33:
            return 64.0;
            break;
            
        case 34:
            return 128.0;
            break;
            
        default:
            break;
    }
    
    return 2.0;
}





//返回上一步
/**
 
 */
- (void)returnLastStep{
    NSLog(@"//返回上一步");
    
    if (self.allPathArray.count != 0) {
        //将数组中最后一个path删除
        NSInteger count = self.allPathArray.count;
        
        [self.saveDeletePathArray addObject:self.allPathArray[count - 1]];
        
        [self.allPathArray removeObject:self.allPathArray[count - 1]];
        
        //重绘
        [self setNeedsDisplay];
    }
    
    
    NSLog(@"self.allPathArray %@",self.allPathArray);
    
}

//返回下一步
- (void)returnNextStep{
    NSLog(@"//返回下一步");
    
    //如果saveDeletePathArray里面有值的话
    if (self.saveDeletePathArray.count != 0) {
        
        [self.allPathArray addObject:self.saveDeletePathArray[self.saveDeletePathArray.count - 1]];
            
            //重绘
        [self setNeedsDisplay];
        
            //把saveDeletePathArray数组中的第0个元素删除掉
        [self.saveDeletePathArray removeObject:self.saveDeletePathArray[self.saveDeletePathArray.count - 1]];
    }
    
    NSLog(@"self.saveDelegatePathArray %@",self.saveDeletePathArray);
    
}



#pragma mark -----------------------------
#pragma mark lazy load

- (NSMutableArray *)allPathArray {
    
    if (_allPathArray == nil) {
        _allPathArray = [NSMutableArray array];
    }
    return _allPathArray;
}

- (NSMutableArray *)saveDeletePathArray{
    if (_saveDeletePathArray == nil) {
        _saveDeletePathArray = [NSMutableArray array];
    }
    
    return _saveDeletePathArray;
}

- (NSMutableDictionary *)dict{

    if (_dict == nil) {
        _dict = [NSMutableDictionary dictionary];
    }

    return _dict;
}


@end
