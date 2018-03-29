//
//  UIButton+LoadImage.h
//  iOSProject
//
//  Created by 360doc on 2018/3/29.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIButton+WebCache.h>

@interface UIButton (LoadImage)
/**
 UIButton 加载image 'url' 'state' 'placeholder' 'options' 'completed'
 
 @param url image的地址
 @param state 按钮状态
 */
- (void)dxw_loadImageWithURL:(NSURL *)url
                    forState:(UIControlState)state;

/**
 UIButton 加载image 'url' 'state' 'placeholder' 'options' 'completed'
 
 @param url image的地址
 @param state 按钮状态
 @param placeholder 占位图
 @param options 在下载图像时使用的选项
 @param completed 加载完成
 */
- (void)dxw_loadImageWithURL:(NSURL *)url
                    forState:(UIControlState)state
            placeholderImage:(UIImage *)placeholder
                     options:(SDWebImageOptions)options
                   completed:(SDExternalCompletionBlock)completed;

/**
 UIButton 加载BackgroundImage 'url' 'state'
 
 @param url image的地址
 @param state 按钮状态
 */
- (void)dxw_loadBackgroundImageWithURL:(NSURL *)url
                              forState:(UIControlState)state;

/**
 UIButton 加载BackgroundImage 'url' 'state' 'placeholder' 'options' 'completed'

 @param url image的地址
 @param state 按钮状态
 @param placeholder 占位图
 @param options 在下载图像时使用的选项
 @param completed 加载完成
 */
- (void)dxw_loadBackgroundImageWithURL:(NSURL *)url
                              forState:(UIControlState)state
                      placeholderImage:(UIImage *)placeholder
                               options:(SDWebImageOptions)options
                             completed:(SDExternalCompletionBlock)completed;

@end
