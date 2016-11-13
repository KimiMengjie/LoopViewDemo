//
//  CMJLoopViewLayout.m
//  轮播器
//
//  Created by Mengjie Chen on 2016/11/10.
//  Copyright © 2016年 Mengjie Chen. All rights reserved.
//

#import "CMJLoopViewLayout.h"

@implementation CMJLoopViewLayout

-(void)prepareLayout
{
    [super prepareLayout];
    
    // 直接利用 collectionView 的属性设置布局
    self.itemSize = self.collectionView.bounds.size;
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView.bounces = NO;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
}

@end
