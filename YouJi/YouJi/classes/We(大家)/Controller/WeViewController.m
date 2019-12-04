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

@interface WeViewController ()<UITableViewDataSource,UITableViewDelegate>
/** tableView*/
@property(nonatomic,readwrite,weak) UITableView *tableView;

/**模型数组 */
@property(nonatomic,readwrite,strong) NSMutableArray *itemArray;

@end

@implementation WeViewController

static NSString *ID = @"cell";

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    
    //添加子控件
    [self setupChild];
    
    //注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([XZQVideoTableViewCell class]) bundle:nil] forCellReuseIdentifier:ID];
    
    //加载plist文件
    [self loadPlist];
        
}

#pragma mark -----------------------------
#pragma mark 添加子控件
- (void)setupChild{
    
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//
//    [self.view addSubview:scrollView];
    
    //tableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];

    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 289;
    tableView.separatorStyle = UITableViewCellAccessoryNone;
    
    [self.view addSubview:tableView];
    
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





//隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
