//
//  ViewController.m
//  异步绘制圆形头像
//
//  Created by Mengjie Chen on 2016/11/13.
//  Copyright © 2016年 Mengjie Chen. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Extension.h"
#import <Masonry.h>

static NSString *imgCell = @"imgCell";

@interface ViewController ()<UITableViewDataSource>
@property (nonatomic,strong) UIImage *img;
@property (nonatomic,weak)UITableView *tableView;
@property (nonatomic,assign)BOOL flag;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView = tableView;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:imgCell];
    

    //自动布局
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.top.equalTo(self.mas_topLayoutGuideBottom);
        make.bottom.equalTo(self.mas_bottomLayoutGuideTop);
    }];
    
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:imgCell forIndexPath:indexPath];
    if (self.flag == YES) {
        cell.imageView.image = self.img;
    }
    //模拟数据获取
    UIImage *image = [UIImage imageNamed:@"avatar.jpg"];
    
    CGSize imgSize = CGSizeMake(80, 80);
    if (self.flag == NO) {
        [image mj_cornerImageWithSize:imgSize fillColor:[UIColor whiteColor] completion:^(UIImage *image) {
            //缓存图片
            self.img = image;
            self.flag = YES;
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
        }];
    }
    self.flag = NO;
    return cell;
}
@end
