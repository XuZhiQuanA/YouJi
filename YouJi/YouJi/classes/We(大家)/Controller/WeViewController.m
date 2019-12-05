//
//  WeViewController.m
//  YouJi
//
//  Created by dmt312 on 2019/12/3.
//  Copyright © 2019 XZQ. All rights reserved.
//

#import "WeViewController.h"
#import "XZQVideoTableViewCell.h"
#import "XZQVideoItem.h"
#import "XZQNavigationView.h"
#import "XZQShowZhangScrollView.h"
#import "XZQShowNewContentViewController.h"

@interface WeViewController ()<UITableViewDataSource,UITableViewDelegate>
/** tableView*/
@property(nonatomic,readwrite,weak) UITableView *tableView;

/**模型数组 */
@property(nonatomic,readwrite,strong) NSMutableArray *itemArray;

/** 导航view*/
@property(nonatomic,readwrite,weak) XZQNavigationView *navigationView;

/** scrollview*/
@property(nonatomic,readwrite,weak) UIScrollView *scrollView;

/** 右边的scrollView*/
@property(nonatomic,readwrite,weak) XZQShowZhangScrollView *szScrollView;

/**展示长图控制器 */
@property(nonatomic,readwrite,strong) XZQShowNewContentViewController *contentVc;

@end

@implementation WeViewController

static NSString *ID = @"cell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    //设置上面的view
    [self setupNavigationView];
    
    //添加子控件
    [self setupChild];
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XZQVideoTableViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    //加载plist文件
    [self loadPlist];
    
    
    
    //通知监听
    [self addNotification];

}

- (void)setupNavigationView{
    
    XZQNavigationView *navigationView = [[XZQNavigationView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, XZQNavigationViewH)];
    navigationView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navigationView];
    self.navigationView = navigationView;
    
}

#pragma mark -----------------------------
#pragma mark 添加子控件
- (void)setupChild{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize = CGSizeMake(2*ScreenW, 0);
    scrollView.pagingEnabled = YES;
    scrollView.delegate = self;
    scrollView.backgroundColor = XColor(243, 251, 252);

    [self.view addSubview:scrollView];
    [self.view insertSubview:scrollView belowSubview:self.navigationView];
    
    self.scrollView = scrollView;
    
    //tableView - 占据scrollview的左边半部分
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];

    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 289;
    tableView.separatorStyle = UITableViewCellAccessoryNone;
    
    [scrollView addSubview:tableView];
    
    self.tableView = tableView;
    
    self.tableView.contentInset = UIEdgeInsetsMake(XZQNavigationViewH, 0, XZQTabBarViewH-52, 0);
    
    self.tableView.backgroundColor = XColor(243, 251, 252);
    
    //设置headerview - view用来达到第一个cell和headerview之间有间距的功能
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 203)];
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 170)];
    imageV.image = [UIImage OriginalImageWithName:@"HeaderViewImage" toSize:CGSizeMake(imageV.bounds.size.width, imageV.bounds.size.height)];
    [view addSubview:imageV];
    view.backgroundColor = [UIColor clearColor];
    
    self.tableView.tableHeaderView = view;
    
    
    
    //scrollView的右边半部分 - 放一个小的scrollview 固定contentSize 滚动范围 垂直滚动
    XZQShowZhangScrollView *szScrollView = [[XZQShowZhangScrollView alloc] initWithFrame:CGRectMake(ScreenW, 0, ScreenW, ScreenH-XZQNavigationViewH)];
    szScrollView.contentSize = CGSizeMake(0, 1180);
    [scrollView addSubview:szScrollView];
    
    self.szScrollView = szScrollView;
}

#pragma mark -----------------------------
#pragma mark 数据源方法

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XZQVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    cell.backgroundColor = [UIColor clearColor];
    
    
    
    XZQVideoItem *item = self.itemArray[indexPath.row];
    
    cell.item = item;
    
    return cell;
    
    
}

#pragma mark -----------------------------
#pragma mark UITableView代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    XZQVideoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    
    cell.placeHolderImageView.hidden = YES;
    
    
    XLog(@"%@",cell.placeHolderImageView);
    XLog(@"%ld",indexPath.row);
    
//    [cell.videoPlayer.player play];
    
    
}



#pragma mark -----------------------------
#pragma mark 懒加载
- (NSMutableArray *)itemArray{
    
    if (_itemArray == nil) {
        _itemArray = [NSMutableArray array];
    }
    
    return _itemArray;
}

- (XZQShowNewContentViewController *)contentVc{
    if (_contentVc == nil) {
        _contentVc = [[XZQShowNewContentViewController alloc] init];
//        _contentVc.modalPresentationStyle = UIModalPresentationFullScreen;
        
    }
    
    return _contentVc;
}



#pragma mark -----------------------------
#pragma mark 加载plist文件
- (void)loadPlist{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"YouJi" ofType:@"plist"] ;
    
    NSArray *dictArray = [NSArray arrayWithContentsOfFile:filePath];
    
    //字典转模型
    for (NSDictionary *dict in dictArray) {
        
        XZQVideoItem *item = [XZQVideoItem itemWithArray:dict];
        [self.itemArray addObject:item];
    }

    
}



#pragma mark -----------------------------
#pragma mark tableHeaderView
//这里设置的tableheaderview不能随着内容滚动
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, 170)];
//    imageV.image = [UIImage OriginalImageWithName:@"HeaderViewImage" toSize:CGSizeMake(imageV.bounds.size.width, imageV.bounds.size.height)];
//
//    return imageV;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 170;
//}

#pragma mark -----------------------------
#pragma mark UIScrollViewDeleagate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger index = scrollView.contentOffset.x / ScreenW;
    self.navigationView.index = index;
    
    
}


#pragma mark -----------------------------
#pragma mark 监听通知
- (void)addNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollViewToLeft) name:@"shipin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeScrollViewToRight) name:@"shouzhang" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popNewContent) name:@"popNewContent_0" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popNewContent) name:@"popNewContent_1" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popNewContent) name:@"popNewContent_2" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popNewContent) name:@"popNewContent_3" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popNewContent) name:@"popNewContent_4" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popNewContent) name:@"popNewContent_5" object:nil];
}

- (void)changeScrollViewToLeft{
    
    CGFloat offsetX = self.scrollView.contentOffset.x;
    
    offsetX -= ScreenW;
    
    if (offsetX < 0) {
        offsetX = 0;
    }
    
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    XFunc;
    XLog(@"%@",NSStringFromCGRect(self.scrollView.frame));
}

- (void)changeScrollViewToRight{
    
    CGFloat offsetX = self.scrollView.contentOffset.x;
    
    offsetX += ScreenW;
    
    if (offsetX > ScreenW) {
        offsetX = ScreenW;
    }
    
    [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    
    XFunc;
    XLog(@"%@",NSStringFromCGRect(self.scrollView.frame));
    
}

- (void)popNewContent{
    XFunc;
    XLog(@"%ld",self.szScrollView.index);
    
//    更改modal效果: vc.modalPresentationStyle = UIModalPresentationFullScreen; 全屏
    
    
    //默认为卡片式
    [self presentViewController:self.contentVc animated:YES completion:^{
        XLog(@"%f",ScreenW);
        
    }];
}

//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
