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

#define rotateX 179.0f
#define rotateY 656.0f
#define rotateWH 56.0f

@interface FancyTabBarViewController ()<FancyTabBarDelegate>
@property(nonatomic,strong) FancyTabBar *fancyTabBar;
@property (nonatomic,strong) UIImageView *backgroundView;
@end

@implementation FancyTabBarViewController

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
  if (index == 1) {
        [self performSegueWithIdentifier:@"YOUR NEXT VIEW" sender: self];
}
}

@end
