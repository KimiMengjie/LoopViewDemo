//
//  UIImage+Extension.h
//  异步绘制圆形头像
//
//  Created by Mengjie Chen on 2016/11/13.
//  Copyright © 2016年 Mengjie Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

- (void)mj_cornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *image)) completion;

@end
