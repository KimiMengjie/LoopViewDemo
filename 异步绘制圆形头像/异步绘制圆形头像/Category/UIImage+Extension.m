//
//  UIImage+Extension.m
//  异步绘制圆形头像
//
//  Created by Mengjie Chen on 2016/11/13.
//  Copyright © 2016年 Mengjie Chen. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

- (void)mj_cornerImageWithSize:(CGSize)size fillColor:(UIColor *)fillColor completion:(void (^)(UIImage *image)) completion
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //1.利用绘图、建立图形上下文
        UIGraphicsBeginImageContextWithOptions(size, true, 0);
       
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        //2.设置填充颜色
        [fillColor setFill];
        UIRectFill(rect);
        
        //3.利用贝塞尔路径 ‘裁剪’
        UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
        [path addClip];
        
        //4.绘制图像
        [self drawInRect:rect];
        
        //5.取得结果
        UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
        
        //6.关闭上下文
        UIGraphicsEndImageContext();
        
        //7.回调结果
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion != nil) {
                completion(result);
            }
        });
    });
}

@end
