//
//  MJHeaderViewController.m
//  UI-顶部放大效果Demo
//
//  Created by Mengjie Chen on 2016/11/14.
//  Copyright © 2016年 Mengjie Chen. All rights reserved.
//

#import "MJHeaderViewController.h"

NSString *const cellID = @"cellID";

@interface MJHeaderViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MJHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self prepareTableView];
}


- (void)prepareTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    tableView.dataSource = self;
    tableView.delegate = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    
    [self.view addSubview:tableView];
    
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
