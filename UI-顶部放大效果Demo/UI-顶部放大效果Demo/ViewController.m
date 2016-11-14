//
//  ViewController.m
//  UI-顶部放大效果Demo
//
//  Created by Mengjie Chen on 2016/11/14.
//  Copyright © 2016年 Mengjie Chen. All rights reserved.
//

#import "ViewController.h"
#import "MJHeaderViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //显示导航栏
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (IBAction)clickbTN:(UIBarButtonItem *)sender {
    MJHeaderViewController *headerVC = [[MJHeaderViewController alloc] init];
    
    [self.navigationController pushViewController:headerVC animated:YES];
    
}

@end
