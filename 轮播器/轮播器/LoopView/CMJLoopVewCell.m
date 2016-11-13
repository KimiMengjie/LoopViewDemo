//
//  CMJLoopVewCell.m
//  轮播器
//
//  Created by Mengjie Chen on 2016/11/10.
//  Copyright © 2016年 Mengjie Chen. All rights reserved.
//

#import "CMJLoopVewCell.h"

@implementation CMJLoopVewCell
{
    UIImageView *_imageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        //添加图像视图
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        [self.contentView addSubview:_imageView];
        _imageView.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)setUrl:(NSURL *)url
{
    _url = url;
    
    //获取图片
    NSData *data = [NSData dataWithContentsOfURL:url];
    
    UIImage *image = [UIImage imageWithData:data];
    
    _imageView.image = image;
    
}
@end
