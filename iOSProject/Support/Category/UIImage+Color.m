//
//  UIImage+Color.m
//  iOSProject
//
//  Created by 360doc on 2018/4/8.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)


/**
 根据颜色创建image

 @param color image颜色
 @param size image大小
 @return 创建的image
 */
+ (UIImage *)initWithColor:(UIColor *)color imageSize:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    
    [color setFill];
    
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return image;
    
    return nil;
}

/**
 根据颜色创建image
 
 @param color image颜色
 @return 创建的image
 */
+ (UIImage *)initWithColor:(UIColor *)color {
    
    return [self initWithColor:color imageSize:CGSizeMake(1, 1)];
}

@end
