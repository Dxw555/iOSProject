//
//  UIImage+Color.h
//  iOSProject
//
//  Created by 360doc on 2018/4/8.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)



/**
 根据颜色创建image
 
 @param color image颜色
 @param size image大小
 @return 创建的image
 */
+ (UIImage *)initWithColor:(UIColor *)color imageSize:(CGSize)size ;

/**
 根据颜色创建image
 
 @param color image颜色
 @return 创建的image
 */
+ (UIImage *)initWithColor:(UIColor *)color ;
@end
