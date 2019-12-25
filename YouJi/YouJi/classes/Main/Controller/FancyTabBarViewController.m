//
//  FancyTabBarViewController.m
//  YouJi
//
//  Created by dmt312 on 2019/12/6.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "FancyTabBarViewController.h"
#import "UIView+Screenshot.h"
#import "UIImage+ImageEffects.h"
#import "FancyTabBar.h"
#import "Coordinate.h"
#import "SVProgressHUD.h"



#define rotateX 179.0f
#define rotateY 656.0f
#define rotateWH 56.0f

@interface FancyTabBarViewController ()<FancyTabBarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic,strong) FancyTabBar *fancyTabBar;
@property (nonatomic,strong) UIImageView *backgroundView;
@property(nonatomic,readwrite,strong) UIImagePickerController *imagePickerController;
@end

@implementation FancyTabBarViewController

- (UIImagePickerController *)imagePickerController{
    if (_imagePickerController == nil) {
        _imagePickerController = [[UIImagePickerController alloc] init];
    }
    
    return _imagePickerController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
    _fancyTabBar = [[FancyTabBar alloc]initWithFrame:self.view.bounds];
//    _fancyTabBar.backgroundColor = [UIColor redColor];
    Coordinate *c1 = [[Coordinate alloc] init];
//    c1.y = @([UIScreen mainScreen].bounds.size.height - 88.0f - 109.0f);
    c1.y = @518.0f;
//    c1.x = @75.0f;
    c1.x = @99.0f;
    Coordinate *c2 = [[Coordinate alloc] init];
    c2.y = c1.y;
//    c2.x = @(88.0f + 50.0f + c1.x.doubleValue);
    c2.x = @315.0f;
//    [_fancyTabBar setUpChoices:self choices:@[@"camera",@"draw"] withMainButtonImage:[UIImage imageNamed:@"main_button"] andMainButtonCustomOrigin:CGPointMake(rotateX, rotateY) choicesCoordinates:@[c1, c2]];
    
    [_fancyTabBar setUpChoices:self choices:@[@"录视频",@"写手账"] withMainButtonImage:[UIImage OriginalImageWithName:@"plus" toSize:CGSizeMake(rotateWH, rotateWH)] andMainButtonCustomOrigin:CGPointMake(rotateX, rotateY) choicesCoordinates:@[c1, c2]];
    
    
    
    
    
//    //Set Pop Items Direction
//    _fancyTabBar.currentDirectionToPopOptions=FancyTabBarItemsPop_Down;
//    //Custom Placement
//    [_fancyTabBar setUpChoices:self choices:@[@"gallery",@"dropbox",@"camera",@"draw"] withMainButtonImage:[UIImage imageNamed:@"main_button"] andMainButtonCustomOrigin:CGPointMake(100, 100)];
    _fancyTabBar.delegate = self;
    [self.view addSubview:_fancyTabBar];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FancyTabBarDelegate
- (void) didCollapse{
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        if(finished) {
            [self.backgroundView removeFromSuperview];
            self.backgroundView = nil;
        }
    }];
}


- (void) didExpand{
    
//    if(!_backgroundView){
//        _backgroundView = [[UIImageView alloc]initWithFrame:self.view.bounds];
//        _backgroundView.alpha = 0;
//        [self.view addSubview:_backgroundView];
//    }
    
//    [UIView animateWithDuration:0.3 animations:^{
//        self.backgroundView.alpha = 1;
//    } completion:^(BOOL finished) {
//    }];
    
    [self.view bringSubviewToFront:_fancyTabBar];
//    UIImage *backgroundImage = [self.view convertViewToImage];
//    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.5];
//    UIImage *image = [backgroundImage applyBlurWithRadius:10 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
//    _backgroundView.image = image;
}
// PERFORM SEGUES TO NEXT VIEWS BASED ON INDEX PATH
- (void)optionsButton:(UIButton*)optionButton didSelectItem:(int)index{
    NSLog(@"Hello index %d tapped !", index);
//GALLERY SEGUE
//  if (index == 1) {
//        [self performSegueWithIdentifier:@"YOUR NEXT VIEW" sender: self];
//}
    
    //index == 1 相机
    
    switch (index) {
        case 1:
            [self takingShooting];
            break;
            
        case 2:
            //之前的FancyTabBar回到消失状态
            [self.fancyTabBar explode];
            
            //发出通知 出现编辑手账界面效果
            [[NSNotificationCenter defaultCenter] postNotificationName:@"FancyTabBarViewControllerWantXZQTabBarControllerShowShouZhangViewController" object:nil];
            
        break;
            
        default:
            break;
    }
    
    
    //index == 2 手账
    
    
    
}

// 录制
- (void)takingShooting {
    // 获取支持的媒体格式
    NSArray * mediaTypes =[UIImagePickerController  availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    // 判断是否支持需要设置的sourceType
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.imagePickerController.delegate = self;
        self.imagePickerController.mediaTypes = @[mediaTypes[1]];
        self.imagePickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        [self presentViewController:self.imagePickerController animated:YES completion:nil];
        
        
        
        
    }else {
        NSLog(@"当前设备不支持录像");
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"温馨提示"
                                                                                  message:@"当前设备不支持录像"
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"确定"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
//                                                              _uploadButton.hidden = NO;
                                                          }]];
        [self presentViewController:alertController
                           animated:YES
                         completion:nil];
    }
}

//保存录制的视频
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {

    NSString* path = [[info objectForKey:UIImagePickerControllerMediaURL] path];

    // 保存视频
    UISaveVideoAtPathToSavedPhotosAlbum(path, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
    
    __weak typeof(self) weakSelf = self;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf dismissViewControllerAnimated:YES completion:nil];
    });
    
    
    
 }

 

// 视频保存回调

- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo: (void *)contextInfo {

    NSLog(@"%@",videoPath);

    NSLog(@"%@",error);
    
    [SVProgressHUD showSuccessWithStatus:@"视频已保存到相册 请注意查看~"];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        
    });

}

@end
