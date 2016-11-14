//
//  MJHeaderViewController.m
//  UI-顶部放大效果Demo
//
//  Created by Mengjie Chen on 2016/11/14.
//  Copyright © 2016年 Mengjie Chen. All rights reserved.
//

#import "MJHeaderViewController.h"
#import "HMObjcSugar.h"

NSString *const cellID = @"cellID";
#define kHeaderHigh 200 //固定高度

@interface MJHeaderViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MJHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self prepareTableView];
    [self prepareHeaderView];
    
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
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.hm_width, kHeaderHigh)];
    
    headView.backgroundColor = [UIColor hm_colorWithHex:0x330000];
    
    [self.view addSubview:headView];
}

/**
 设置状态栏

 @return <#return value description#>
 */
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
