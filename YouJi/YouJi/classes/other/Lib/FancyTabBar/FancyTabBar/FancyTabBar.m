//
//  FancyTabBar.m
//  FancyTabBar
//
//  Created by Jonathan on 15/05/2014.
//

#import "FancyTabBar.h"
#import "Coordinate.h"
#import "UIImage+ImageEffects.h"
#import "UIView+Screenshot.h"

#define PADDING 10
#define DegreesToRadians(x) ((x) * M_PI / 180.0)

#define btn1CenterX 99
#define btn1CenterY 501
#define btn2CenterX 315
#define btnWH 70

#define btnW 70
#define btnH 105


static const int subviewTagConstant = 1000;
static const float openAnimationDuration = 0.5;
static const float collapseAnimationDuration = 0.5;

@interface FancyTabBar(){
    
}

@property(nonatomic,assign) BOOL calculated;
@property(nonatomic,assign) BOOL open;
@property(nonatomic,assign) BOOL animating;

@property(nonatomic,strong) NSArray *choices;
@property(nonatomic,strong) NSMutableDictionary *destinationCoordinateDictionary;
@property(nonatomic,strong) NSMutableDictionary *originalCoordinateDictionary;
@property(nonatomic,strong) UIImage *mainButtonImage;
@property(nonatomic,strong) UIButton *mainButton;
@property(nonatomic,strong) UIView *backgroundView;
@property(nonatomic,strong) UIDynamicAnimator *dynamicsAnimator;
@property(nonatomic,strong) UIDynamicBehavior *dynamicBehaviour;
@property(assign, nonatomic) CGPoint mainBtnCustomOrigin;
@property(nonatomic, copy) NSArray *choiceCoordinates;

@property(nonatomic,weak) UIViewController *parentViewController;

- (void) resetViews;

@end

@implementation FancyTabBar

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    if(!_open){
        if (hitView == self){
            return nil;
        }else{
            return hitView;
        }
    }
    return hitView;
}

#pragma mark - setup

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(rotateMiddleBtn) name:@"XZQTabBarViewPostToChangeXZQTabBarControllerCurrentShowedChildControllerView_Middle" object:nil];
        
    }
    return self;
}

- (void) resetViews{
//    XZQTopImageBottomLabelButton;
    for (UIButton *button in self.subviews){
        button.hidden = NO;
        button.transform = CGAffineTransformMakeScale(1, 1);
        button.alpha  = 1.0;
    }
}

- (void) setUpChoices:(UIViewController*) parentViewController choices:(NSArray*) choices withMainButtonImage:(UIImage*)mainButtonImage andMainButtonCustomOrigin:(CGPoint)customOrigin
{
    _mainBtnCustomOrigin=customOrigin;
    [self setUpChoices:parentViewController choices:choices withMainButtonImage:mainButtonImage];
}
- (void) setUpChoices:(UIViewController *)parentViewController choices:(NSArray *)choices withMainButtonImage:(UIImage *)mainButtonImage andMainButtonCustomOrigin:(CGPoint)customOrigin choicesCoordinates:(NSArray *)choicesCoordinates {
    self.choiceCoordinates = choicesCoordinates;
    [self setUpChoices:parentViewController choices:choices withMainButtonImage:mainButtonImage andMainButtonCustomOrigin:customOrigin];
}
- (void) setUpChoices:(UIViewController*) parentViewController choices:(NSArray*) choices withMainButtonImage:(UIImage*)mainButtonImage{
    _parentViewController = parentViewController;
    _choices = choices;
    _mainButtonImage = mainButtonImage;
    _destinationCoordinateDictionary = [[NSMutableDictionary alloc]init];
    _originalCoordinateDictionary =  [[NSMutableDictionary alloc]init];

    _mainButton = [[UIButton alloc]initWithFrame:CGRectZero];

    CGRect frame = _mainButton.frame;
    frame.size = CGSizeMake(mainButtonImage.size.width, mainButtonImage.size.height);
    _mainButton.frame = frame;
  
    [_mainButton addTarget:self action:@selector(explode) forControlEvents:UIControlEventTouchUpInside];
    [_mainButton setImage:mainButtonImage forState:UIControlStateNormal];
    
    [self calculateExpandedCoordinates];
    [self addSubview:_mainButton];

}

- (void) choose:(id) sender{
    
    __weak typeof(self) weakSelf = self;
    
    UIButton *button = (UIButton*)sender;
    NSInteger tag = button.tag;
    [self collapseAnimation];
    
    if(_delegate && [_delegate respondsToSelector:@selector(optionsButton:didSelectItem:)]){
        [weakSelf.delegate optionsButton:button didSelectItem:tag/subviewTagConstant];
    }
}

- (void) calculateExpandedCoordinates{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    
    float width;
    float height;
    float parentWidth;
    float parentHeight;
    
    if(orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight){
        parentHeight = _parentViewController.view.frame.size.width;
        parentWidth = _parentViewController.view.frame.size.height;
        width = self.frame.size.height;
        height = self.frame.size.width;
    }else{
        parentHeight = _parentViewController.view.frame.size.height;
        parentWidth = _parentViewController.view.frame.size.width;
        width = self.frame.size.width;
        height = self.frame.size.height;
    }
    
    self.frame = CGRectMake(0,0, parentWidth, parentHeight);
    
    if (CGPointEqualToPoint(_mainBtnCustomOrigin, CGPointZero)) {
        _mainBtnCustomOrigin=CGPointMake((width -_mainButtonImage.size.width)/2, height - _mainButtonImage.size.height);
    }
    _mainButton.frame = CGRectMake(_mainBtnCustomOrigin.x,_mainBtnCustomOrigin.y, _mainButtonImage.size.width, _mainButtonImage.size.height);
    
    for (int i = 0;i<_choices.count;i++){
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectZero];
//        button.titleLabel.text = @"录视频";

//        [button sizeToFit];
//        button.titleLabel.tintColor = [UIColor blackColor];
//        button.imageEdgeInsets = UIEdgeInsetsMake(-30, 0, 0, 0);

//        XLog(@"button.titleLabel.frame  ---- %@",NSStringFromCGRect(button.titleLabel.frame));//0 0 0 0 11 82 48 23
//        XLog(@"button.imageView.frame ---  %@",NSStringFromCGRect(button.imageView.frame));//0 -15 0 0
//        XLog(@"button.titleLabel --%@",button.titleLabel);
//        button.backgroundColor = [UIColor redColor];
        CGRect frame = button.frame;
        
        //
//        UIImage *buttonChoiceImage;
//        switch (i) {
//            case 0:
//                buttonChoiceImage = [UIImage OriginalImageWithName:@"FancyTabBar_camera" toSize:CGSizeMake(btnWH, btnWH)];
//                break;
//
//            case 1:
//                buttonChoiceImage = [UIImage OriginalImageWithName:@"FancyTabBar_draw" toSize:CGSizeMake(btnWH, btnWH)];
//            break;
//
//            default:
//                buttonChoiceImage = [UIImage imageNamed:_choices[i]];
//                break;
//        }
        
//        UIImage *buttonChoiceImage = [UIImage imageNamed:_choices[i]];
//        frame.size = CGSizeMake(buttonChoiceImage.size.width,buttonChoiceImage.size.height);
        
        frame.size = CGSizeMake(btnW,btnH);
        button.frame = frame;
//        int x = (int)width/2;
        NSInteger x = 0;
        if (i == 0)
            x = btn1CenterX;
        else if (i == 1)
            x = btn2CenterX;
        else
            x = width/2;
        
//        int y = _mainButton.frame.origin.y + _mainButton.frame.size.height/2;
        //原来的y值应该在屏幕下面
        NSInteger y = ScreenH + ScreenH / 2;
//        button.center =  CGPointMake(x,y);
        Coordinate *originalCoordinate = [[Coordinate alloc]init];
        originalCoordinate.x = [NSNumber numberWithInteger:x];
        originalCoordinate.y = [NSNumber numberWithInteger:y];
        int tag = subviewTagConstant*(i+1);
        //原来的位置
        [_originalCoordinateDictionary setObject:originalCoordinate forKey:[NSNumber numberWithInteger:tag]];
//        [button setImage:[UIImage imageNamed:_choices[i]] forState:UIControlStateNormal];
        
        switch (i) {
            case 0:
                [button setImage:[UIImage OriginalImageWithName:@"FancyTabBar_camera" toSize:CGSizeMake(btnW, btnH)] forState:UIControlStateNormal];
                
                button.center =  CGPointMake(btn1CenterX,y);
                break;
            case 1:
                [button setImage:[UIImage OriginalImageWithName:@"FancyTabBar_draw" toSize:CGSizeMake(btnW, btnH)] forState:UIControlStateNormal];
                
                button.center =  CGPointMake(btn2CenterX,y);
            break;
                
            default:
                [button setImage:[UIImage imageNamed:_choices[i]] forState:UIControlStateNormal];
                button.center =  CGPointMake(x,y);
                break;
        }
        
        
        
        [button addTarget:self action:@selector(choose:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = tag;
        button.alpha = 0;
        [self addSubview:button];
        
        XLog(@"button.titleLabel.frame  ----2 %@",NSStringFromCGRect(button.titleLabel.frame));
    }
    
    //不进来
    if (!self.choiceCoordinates && self.choiceCoordinates.count == _choices.count) {
        float plane = (parentWidth)-2*PADDING;
        float radius = plane/3;
        float xCentre = _mainButton.center.x;
        float yCentre = _mainButton.center.y;
        
        
        float x;
        float y;
        
        float degrees = 180/(_choices.count-1);
        
        for (int i=0; i < _choices.count; i++) {
            int tag = (i+1)*subviewTagConstant;
            Coordinate *coordinate = [[Coordinate alloc] init];
            float radian = (degrees*(i)*M_PI)/180;
            if (_currentDirectionToPopOptions==FancyTabBarItemsPop_Down) {
                //Pop Option Buttons Down
                radian = (degrees*(i)*M_PI)/-180;
            }
            float cosineRadian = cosf(radian);
            float sineRadian = sinf(radian);
            
            float radiusLengthX = (radius * cosineRadian);
            float radiusLengthY = (radius * sineRadian);
            
            x = xCentre + radiusLengthX;
            y = yCentre - radiusLengthY;
            
            coordinate.x = [NSNumber numberWithInt:x];
            coordinate.y = [NSNumber numberWithInt:y];
            
            coordinate.x = [NSNumber  numberWithInt:x];
            
            coordinate.y = [NSNumber numberWithFloat:y];
            [_destinationCoordinateDictionary setObject:coordinate forKey:[NSNumber numberWithInt:tag]];
        }
    } else {
        for (int i = 0; i < self.choiceCoordinates.count; i++) {
            int tag = (i + 1) * subviewTagConstant;
            [_destinationCoordinateDictionary setObject:self.choiceCoordinates[i] forKey:@(tag)];
        }
    }
}

#pragma mark - animation

- (void) explode{
    
    //通知 关闭时XZQTabBar中选择的还是之前点击的那个
    
    
    if(!_animating){
        _animating = YES;
        //显示两个button
        [self resetViews];
        if(!_open){
            //一开始来到这个里面  A
            [self expandAnimation];
        }else{
            //关闭
            [self collapseAnimation];
        }
    }
}

//
- (void) collapse{
    for (int i=0; i < _choices.count; i++) {
        int tag = (i+1)*subviewTagConstant;
        UIButton *button = (UIButton*)[self viewWithTag:tag];
        button.alpha = 0.0;
        _backgroundView.alpha = 0.0;
        Coordinate *coordinate =  [_originalCoordinateDictionary objectForKey:[NSNumber numberWithInt:tag]];
        button.center =  CGPointMake([coordinate.x floatValue], [coordinate.y floatValue]);
    }
    double rads = DegreesToRadians(-45);
    _mainButton.layer.transform = CATransform3DMakeRotation(rads, 0, 0, 0);
}


- (void) collapseAnimation{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FancyTabBarWantXZQTabBarControllerQuitBottomView" object:nil];
    
    if(_delegate && [_delegate respondsToSelector:@selector(didCollapse)]){
        [_delegate didCollapse];
    
    }
    
    __weak typeof(self) weakSelf = self;
    
    [UIView animateWithDuration:collapseAnimationDuration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
        [self collapse];
    } completion:^(BOOL finished) {
        weakSelf.open  = NO;
        weakSelf.animating = NO;
    }];
    
}

//展示两个按钮
- (void) expandAnimation{
    
    __weak typeof(self) weakSelf = self;
    
    if(_delegate && [_delegate respondsToSelector:@selector(didExpand)]){
        [_delegate didExpand];
    }
    [UIView animateWithDuration:openAnimationDuration delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:0 animations:^{
        for (int i=0; i < weakSelf.choices.count; i++) {
            int tag = (i+1)*subviewTagConstant;
            UIButton *button = (UIButton*)[self viewWithTag:tag];
            button.alpha = 1.0;
            Coordinate *coordinate =  [weakSelf.destinationCoordinateDictionary objectForKey:[NSNumber numberWithInt:tag]];
            button.center =  CGPointMake([coordinate.x floatValue], [coordinate.y floatValue]);
        }
        double rads = DegreesToRadians(-45*5);
        weakSelf.mainButton.layer.transform = CATransform3DMakeRotation(rads, 0, 0, 1);
    } completion:^(BOOL finished) {
        weakSelf.open  = YES;
        weakSelf.animating = NO;
    }];
}

#pragma mark -----------------------------
#pragma mark 监听XZQTabBarController发出的通知
- (void)rotateMiddleBtn{
    XFunc;
//    [self collapseAnimation];
    
    [self explode];
    
    //按钮没有旋转
    double rads = DegreesToRadians(-45);
//    _mainButton.layer.transform = CATransform3DMakeRotation(rads, 0, 0, 0);
    
    self.mainButton.layer.transform = CATransform3DRotate(_mainButton.layer.transform, rads, 0, 0, 0);
    
    
}


@end
