//
//  MJHeaderViewController.m
//  UI-顶部放大效果Demo
//
//  Created by Mengjie Chen on 2016/11/14.
//  Copyright © 2016年 Mengjie Chen. All rights reserved.
//
/**
 侧拉运行时解决，UINavigationController+HMObjcSugar
 */
#import "MJHeaderViewController.h"
#import "HMObjcSugar.h"
#import <AFNetworking/AFNetworking.h>
#import <YYWebImage/YYWebImage.h>

NSString *const cellID = @"cellID";
#define kHeaderHigh 200 //固定高度

@interface MJHeaderViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MJHeaderViewController
{
    UIView *_headView;
    UIImageView *_headImgView;
    UIView *_lineView;
    UIStatusBarStyle _statusBarStyle;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self prepareTableView];
    [self prepareHeaderView];
    
    _statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //取消自动调整滚动视图间距- ViewController+Nav会自动调整tableView的contentInset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //隐藏导航栏
    [self.navigationController setNavigationBarHidden:YES];

}

/**
 准备顶部视图
 */
- (void)prepareHeaderView
{
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.hm_width, kHeaderHigh)];
    
    _headView.backgroundColor = [UIColor hm_colorWithHex:0xf8f8f8];
    
    [self.view addSubview:_headView];
    
    _headImgView = [[UIImageView alloc] initWithFrame:_headView.bounds];
    //设置等比例填充contentMode
    _headImgView.contentMode = UIViewContentModeScaleAspectFill;
    //设置图像裁切
    _headImgView.clipsToBounds = YES;
    
    _headImgView.backgroundColor = [UIColor hm_colorWithHex:0x00033];
    
    [_headView addSubview:_headImgView];
    
    //添加分割线1像素线
    CGFloat lineHeight = 1 / [UIScreen mainScreen].scale;
    _lineView = [[UIView alloc] initWithFrame:CGRectMake(0,kHeaderHigh - lineHeight, _headView.hm_width, lineHeight)];
    _lineView.backgroundColor = [UIColor lightGrayColor];
    
    [_headView addSubview:_lineView];
    // 设置图像
    NSURL *url = [NSURL URLWithString:@"http://www.who.int/entity/campaigns/immunization-week/2015/large-web-banner.jpg?ua=1"];
    
    [_headImgView yy_setImageWithURL:url options:YYWebImageOptionShowNetworkActivity];
}

/**
 设置状态栏

 @return <#return value description#>
 */
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return _statusBarStyle;
}

- (void)prepareTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    [self.view addSubview:tableView];
    
    //设置表格的间距
    tableView.contentInset = UIEdgeInsetsMake(kHeaderHigh, 0, 0, 0);
    //设置滚动指示器的间距
    tableView.scrollIndicatorInsets = tableView.contentInset;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y + scrollView.contentInset.top;

    if (offset <= 0) {

        //调整headView和headImageView
        _headView.hm_y = 0;
        //保持高度一致
        _headView.hm_height = kHeaderHigh - offset;
        _headImgView.alpha = 1;
    }else{

        _headView.hm_height = kHeaderHigh;

        //headerView最小的y值
        CGFloat min = kHeaderHigh - 64;
        _headView.hm_y = -MIN(min, offset);
        //设置透明度,当offset /min == 1的不可见
        CGFloat progress = 1 - (offset / min);
        _headImgView.alpha = progress;
        //根据透明的修改状态栏颜色
        _statusBarStyle = (progress < 0.5) ? UIStatusBarStyleDefault : UIStatusBarStyleLightContent;
        //主动更新状态
        [self.navigationController setNeedsStatusBarAppearanceUpdate];
    }
    //设置图像高度
    _headImgView.hm_height = _headView.hm_height;
    //设置分割线的位置
    _lineView.hm_y = _headView.hm_height - _lineView.hm_height;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    
    cell.textLabel.text = @(indexPath.row).stringValue;
    
    return cell;
}

@end
