//
//  UIImageView+LoadImage.h
//  iOSProject
//
//  Created by 360doc on 2018/3/29.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface UIImageView (LoadImage)

/**
  UIImageView 加载image 'url'

 @param url image地址
 */
- (void)dxw_loadImageWithURL:(NSURL *)url;

/**
 UIImageView 加载image 'url' 'placeholder'

 @param url image地址
 @param placeholder UIImageView 占位图片
 */
- (void)dxw_loadImageWithURL:(NSURL *)url
            placeholderImage:(UIImage *)placeholder;

/**
 UIImageView 加载image 'url' 'placeholder' 'completed'

 @param url image地址
 @param placeholder UIImageView 占位图片
 @param completed 图片加载完成
 */
- (void)dxw_loadImageWithURL:(NSURL *)url
            placeholderImage:(UIImage *)placeholder
                   completed:(SDExternalCompletionBlock)completed;

/**
 UIImageView 加载image 'url' 'placeholder' 'progress' 'completed'

 @param url image地址
 @param placeholder UIImageView 占位图片
 @param progress 图片下载进度
 @param completed 图片加载完成
 */
- (void)dxw_loadImageWithURL:(NSURL *)url
            placeholderImage:(UIImage *)placeholder
                    progress:(SDWebImageDownloaderProgressBlock)progress
                   completed:(SDExternalCompletionBlock)completed;

/**
 UIImageView 加载image 'url' 'placeholder' 'options' 'progress' 'completed'
 
 @param url image地址
 @param placeholder UIImageView 占位图片
 @param options 在下载图像时使用的选项
 @param progress 图片下载进度
 @param completed 图片加载完成
 */
- (void)dxw_loadImageWithURL:(NSURL *)url
            placeholderImage:(UIImage *)placeholder
                     options:(SDWebImageOptions)options
                    progress:(SDWebImageDownloaderProgressBlock)progress
                   completed:(SDExternalCompletionBlock)completed ;

@end
