//
//  ViewController.m
//  轮播器
//
//  Created by Mengjie Chen on 2016/11/10.
//  Copyright © 2016年 Mengjie Chen. All rights reserved.
//

#import "ViewController.h"
#import "CMJLoopView.h"

@interface ViewController ()

@end

@implementation ViewController
{
    NSArray <NSURL *> *_urls;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadData];
    
    //创建界面
    CMJLoopView *loopView = [[CMJLoopView alloc] initWithURLs:_urls];
    loopView.frame = CGRectMake(20, 20, self.view.bounds.size.width - 40 , 200);
    
    [self.view addSubview:loopView];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//加载数据
- (void)loadData
{
    NSMutableArray *arrayM = [NSMutableArray array];
    
    for (int i = 0 ; i < 3; i++) {
        NSString *fileName = [NSString stringWithFormat:@"%02zd.jpg", (i + 1)];
        
        //如果fileName不存在url返回nil
        NSURL *url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
        
        [arrayM addObject:url];
    }
    _urls = arrayM.copy;
}

@end
