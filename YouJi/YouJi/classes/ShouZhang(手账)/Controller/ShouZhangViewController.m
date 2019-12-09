//
//  ShouZhangViewController.m
//  YouJi
//
//  Created by dmt312 on 2019/12/7.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "ShouZhangViewController.h"

#import "WallPaperView.h"

#import "XZQTextView.h"

#import "XZQPaintingTabBar.h"

#define wallPaperViewH 658

#define tabBarOrigionalH 78
#define tabBarPaintingTabBarH 60

#define middleViewH 609

@interface ShouZhangViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIGestureRecognizerDelegate,UITextFieldDelegate>

/** 壁纸view*/
@property(nonatomic,readwrite,weak) WallPaperView *wallPaperView;

/** 相册管理Vc*/
@property(nonatomic,readwrite,strong) UIImagePickerController *picker;

/** 展示从相册中选取的图片*/
@property(nonatomic,readwrite,weak) UIImageView *showSelectedImageFromAlbum;

/** 手账记录textField*/
@property(nonatomic,readwrite,weak) UITextField *szTextField;

/** 编辑手账textView*/
@property(nonatomic,readwrite,weak) XZQTextView *textView;


@property (weak, nonatomic) IBOutlet UIView *tabBarView;

//@property (weak, nonatomic) IBUIView *middleView;//0 49 414 609

/** 中间的view*/
@property(nonatomic,readwrite,weak) UIView *middleView;


@end

@implementation ShouZhangViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
    
    //创建middleView
    [self setupMiddleView];
    
}

#pragma mark -----------------------------
#pragma mark 创建middleView
- (void)setupMiddleView{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor grayColor];
    [self.view addSubview:view];
    _middleView = view;
}


#pragma mark -----------------------------
#pragma mark lazy load
- (WallPaperView *)wallPaperView{
    
    if (_wallPaperView == nil) {
        WallPaperView *paperView = [[WallPaperView alloc] init];
        [self.view addSubview:paperView];
        _wallPaperView = paperView;
    }
    
    return _wallPaperView;
}

- (UIImagePickerController *)picker{
    
    if (_picker == nil) {
        _picker = [[UIImagePickerController alloc] init];
        _picker.delegate = self;
        _picker.allowsEditing = true;
        _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    return _picker;
}

- (UIImageView *)showSelectedImageFromAlbum{
    
    if (_showSelectedImageFromAlbum == nil) {
        
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.userInteractionEnabled = true;
        imageV.contentMode = UIViewContentModeScaleAspectFit;
        imageV.backgroundColor = [UIColor redColor];
        imageV.hidden = true;
        [self.view addSubview:imageV];
//        [self.view insertSubview:imageV belowSubview:self.wallPaperView];
//        [self.view insertSubview:imageV atIndex:5];
        
        //添加手势
        
        //pan
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [imageV addGestureRecognizer:pan];
        
        //rotate
        UIRotationGestureRecognizer *rotate = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
        [imageV addGestureRecognizer:rotate];
        
        //
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        [imageV addGestureRecognizer:pinch];
        
        
        _showSelectedImageFromAlbum = imageV;
    }
    
    return _showSelectedImageFromAlbum;
}

- (UITextField *)szTextField{
    if (_szTextField == nil) {
        UITextField *textField = [[UITextField alloc] init];
        textField.hidden = true;
        textField.backgroundColor = [UIColor blueColor];
        textField.delegate = self;
        [self.view addSubview:textField];
        
//        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(textFieldPan:)];
//        [textField addGestureRecognizer:pan];
        
        
        
        _szTextField = textField;
    }
    
    return _szTextField;
}

- (XZQTextView *)textView{
    
    if (_textView == nil) {
        
        XZQTextView *textView = [[XZQTextView alloc] initWithFrame:CGRectMake(20, 70, ScreenW-50, 34)];
        textView.hidden = true;
        textView.backgroundColor = [UIColor redColor];
        
        textView.font = [UIFont systemFontOfSize:20];
        textView.placeholder = @"手账编辑~";
//        textView.frame = CGRectMake(20, 70, ScreenW-50, 34);
        
        [self.view addSubview:textView];
//        [self.view insertSubview:textView belowSubview:self.showSelectedImageFromAlbum];
//        [self.view insertSubview:textView atIndex:4];
        
        
        _textView = textView;
    }
    
    return _textView;
}

//界面所有的按钮都会来到这里
- (IBAction)editSZViewAction:(UIButton *)sender {
    XFunc;
    XLog(@"%ld",(long)sender.tag);
    
    switch (sender.tag) {
        case 1:
            [self returnToFancy];
            break;
        case 2:
        
        break;
            
        case 3:
        
        break;
            
        case 4:
            
            break;
        case 5:
            
            //壁纸 点击壁纸按钮 再去加载这个view 懒加载
            self.wallPaperView.hidden = false;
            
            
        break;
            
        case 6:
        
        break;
            
        case 7:
            
            //图片 - 点击图片按钮 弹出图片选择器 选择完成后 将图片以一定尺寸固定在界面上 可以旋转、移动、缩放
            [self popSystemAlbum];
            break;
        case 8:
        
            //文字 点击文字按钮 界面中显示出隐藏的textField按钮 弹出键盘输入文字
//            [self editSZText];
            //editTextView
            [self editTextView];
        break;
            
        case 9:
            //画笔 点击画笔按钮 界面可以进行手绘 弹出一个框 改变大小和颜色
            
            //发出通知 让tabbarController把底部tabbar隐藏掉 变成画笔的弹框 画笔的弹框就写在画笔控制器中
            XLog(@"点击了画笔按钮");
            
            
            //隐藏tabbar
            [self hideTabBar];
            
            //增高中间view的高度
            [self riseMiddleViewHeight];
            
            //显示画笔弹框
            [self showPaintingPopBox];
            
        break;
            
        default:
            break;
    }
}

#pragma mark -----------------------------
#pragma mark 布局子控件
- (void)viewWillLayoutSubviews{
    
    //wallPaperView
    self.wallPaperView.frame = CGRectMake(0, 0, ScreenW, wallPaperViewH);
    
    //showSelectedImageFromAlbum
    self.showSelectedImageFromAlbum.bounds = CGRectMake(0, 0, 200, 200);
    self.showSelectedImageFromAlbum.center = CGPointMake(ScreenW *0.5, self.view.bounds.size.height*0.5);
    
    //middleView
    self.middleView.frame = CGRectMake(0, XZQNavigationViewH, ScreenW, middleViewH);
    
    //sztextField
//    self.szTextField.center = CGPointMake(ScreenW*0.5, 100);
//    self.szTextField.bounds = CGRectMake(0, 0, 97, 34);
    
    //textView
//    self.textView.center = CGPointMake(self.view.center.x, ScreenH*0.3);
//    self.textView.bounds = CGRectMake(0, 0, ScreenW-50, 34);

    XLog(@"ShouZhang  - -  viewWillLayoutSubviews");
    
}


#pragma mark -----------------------------
#pragma mark 返回到Fancy界面
- (void)returnToFancy{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ShouZhangViewControllerWantXZQTabBarControllerShowFancyView" object:nil];
}

#pragma mark -----------------------------
#pragma mark 弹出系统相册
- (void)popSystemAlbum{
    
    [self presentViewController:self.picker animated:YES completion:nil];
    
}

#pragma mark -----------------------------
#pragma mark 监听文字按钮点击
- (void)editSZText{
    self.szTextField.hidden = false;
    XLog(@"szTextField -- %@",NSStringFromCGRect(self.szTextField.frame));
    
}

- (void)editTextView{
    self.textView.hidden = false;
    
}


#pragma mark -----------------------------
#pragma mark UIImagePickerControllerDelegate || UINavigationControllerDelegate代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
//    获取图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
//    self.image.image = image;
    XLog(@"imagePickerController - %@",image);
    
    self.showSelectedImageFromAlbum.hidden = false;
    self.showSelectedImageFromAlbum.image = image;
    
//    获取图片后返回
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//按取消按钮时候的功能
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
//    返回
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    XLog(@"imagePickerControllerDidCancel --- ");
}


#pragma mark -----------------------------
#pragma mark 手势调用方法

//图片
- (void)pan:(UIPanGestureRecognizer *)pan{
    
    CGPoint curPoint = [pan translationInView:pan.view];
    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, curPoint.x, curPoint.y);
    
    [pan setTranslation:CGPointZero inView:pan.view];
    
    if (pan.view.frame.origin.y >= (ScreenH - 78-pan.view.frame.size.height)) {
        CGRect frame = pan.view.frame;
        frame.origin.y = (ScreenH - 78-pan.view.frame.size.height);
        pan.view.frame = frame;
    }
    
    if (pan.view.frame.origin.y <= 49) {
        CGRect frame = pan.view.frame;
        frame.origin.y = 49;
        pan.view.frame = frame;
    }
    
    if (pan.view.frame.origin.x >= (ScreenW-pan.view.frame.size.width)) {
        CGRect frame = pan.view.frame;
        frame.origin.x = (ScreenW-pan.view.frame.size.width);
        pan.view.frame = frame;
    }
    
    if (pan.view.frame.origin.x <= 0) {
        CGRect frame = pan.view.frame;
        frame.origin.x = 0;
        pan.view.frame = frame;
    }
    
    XFunc;
}

- (void)rotate:(UIRotationGestureRecognizer *)rotate{
    rotate.view.transform = CGAffineTransformRotate(rotate.view.transform, rotate.rotation);
    //复位
    rotate.rotation = 0.0;
    XFunc;
}

- (void)pinch:(UIPinchGestureRecognizer *)pinch{
    CGFloat scale = pinch.scale;
    pinch.view.transform = CGAffineTransformScale(pinch.view.transform, scale, scale);
    pinch.scale = 1.0;
    XFunc;
}

#pragma mark -----------------------------
#pragma mark 允许多个手势

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return true;
}

#pragma mark -----------------------------
#pragma mark UITextFieldDelegate

//点击return 退出键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];

    return true;
}

#pragma mark -----------------------------
#pragma mark touchBegin

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.szTextField resignFirstResponder];
    XLog(@"ShouZhangViewController - touchesBegan");
    [self.textView quitKeyBoard];
}



#pragma mark -----------------------------
#pragma mark 隐藏tabBar
- (void)hideTabBar{
    
    self.tabBarView.hidden = true;
    
}

#pragma mark -----------------------------
#pragma mark 增高中间view的高度
- (void)riseMiddleViewHeight{
    
    self.middleView.bounds = CGRectMake(0, 0, self.middleView.bounds.size.width, (self.middleView.bounds.size.height + tabBarOrigionalH - tabBarPaintingTabBarH));
    
    self.middleView.backgroundColor = [UIColor blueColor];
    
}

#pragma mark -----------------------------
#pragma mark 显示画笔弹框
- (void)showPaintingPopBox{
    
    XZQPaintingTabBar *tabBar = [[XZQPaintingTabBar alloc] initWithFrame:CGRectMake(0, ScreenH-tabBarPaintingTabBarH, ScreenW, tabBarPaintingTabBarH)];
    [self.view addSubview:tabBar];
    
    XFunc;
    
    
}


@end
