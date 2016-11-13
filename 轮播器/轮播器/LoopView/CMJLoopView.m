//
//  CMJLoopView.m
//  轮播器
//
//  Created by Mengjie Chen on 2016/11/10.
//  Copyright © 2016年 Mengjie Chen. All rights reserved.
//

#import "CMJLoopView.h"
#import "CMJLoopViewLayout.h"
#import "CMJLoopVewCell.h"

NSString *const CMJLoopViewCellId = @"CMJLoopViewCellId";
@interface CMJLoopView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@end
@implementation CMJLoopView
{
    NSArray <NSURL *> *_urls;
}

- (instancetype)initWithURLs:(NSArray <NSURL *> *)urls
{
    self = [super initWithFrame:CGRectZero collectionViewLayout:[[CMJLoopViewLayout alloc] init]];
    if (self) {
        _urls = urls;
        
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[CMJLoopVewCell class] forCellWithReuseIdentifier:CMJLoopViewCellId];
        
        //主队列异步
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:_urls.count inSection:0];
            
            //滚动的位置
            [self scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
            
        });
    }
    return self;
}
#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //防止卡顿，乘多点
    return _urls.count * 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CMJLoopVewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CMJLoopViewCellId forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256) / 255.0 green:arc4random_uniform(256) / 255.0 blue:arc4random_uniform(256) / 255.0 alpha:1.0];
    
    cell.url = _urls[indexPath.item % _urls.count];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //1.获取当前停止的页面
    NSInteger offset = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    //2.当第0页的时候跳转至第二组的第0页
    if (offset == 0 || offset == ([self numberOfItemsInSection:0] - 1)) {
        NSLog(@"%zd",offset);
        //第0页
        if (offset == 0) {
            offset = _urls.count;
        }else{
            offset = _urls.count - 1;
        }
        
        //重新调整contentOffset
        scrollView.contentOffset = CGPointMake(offset * scrollView.bounds.size.width, 0);
        
    }
}

@end
