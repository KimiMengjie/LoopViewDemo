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


@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    [self.view addSubview:imgView];
    
    UIImage *img = [UIImage imageNamed:@"avatar.jpg"];
    
    [img mj_cornerImageWithSize:imgView.bounds.size fillColor:[UIColor whiteColor] completion:^(UIImage *image) {
        imgView.image = img;
    }];
    
    //自动布局
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(200);
        make.center.offset(0);
    }];
    
}

@end
