//
//  UIButton+LoadImage.m
//  iOSProject
//
//  Created by 360doc on 2018/3/29.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "UIButton+LoadImage.h"

@implementation UIButton (LoadImage)

#pragma mark - ImageWithURL
- (void)dxw_loadImageWithURL:(NSURL *)url
                    forState:(UIControlState)state {
    [self dxw_loadImageWithURL:url
                      forState:state
              placeholderImage:nil
                       options:0
                     completed:nil];
}

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
                   completed:(SDExternalCompletionBlock)completed {
    
    [self sd_setImageWithURL:url
                    forState:state
            placeholderImage:placeholder
                     options:options
                   completed:completed];
}

#pragma mark - BackgroundImageWithURL
- (void)dxw_loadBackgroundImageWithURL:(NSURL *)url
                    forState:(UIControlState)state {
    [self dxw_loadBackgroundImageWithURL:url
                                forState:state
                        placeholderImage:nil
                                 options:0
                               completed:nil];
}

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
                   completed:(SDExternalCompletionBlock)completed {
    [self sd_setBackgroundImageWithURL:url
                              forState:state
                      placeholderImage:placeholder
                               options:options
                             completed:completed];
}

@end
