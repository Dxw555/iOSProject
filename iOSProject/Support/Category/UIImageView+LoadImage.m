//
//  UIImageView+LoadImage.m
//  iOSProject
//
//  Created by 360doc on 2018/3/29.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "UIImageView+LoadImage.h"


@implementation UIImageView (LoadImage)


- (void)dxw_loadImageWithURL:(NSURL *)url {
    [self dxw_loadImageWithURL:url
              placeholderImage:nil
                       options:0
                      progress:nil
                     completed:nil];
}

- (void)dxw_loadImageWithURL:(NSURL *)url
            placeholderImage:(UIImage *)placeholder {
    [self dxw_loadImageWithURL:url
              placeholderImage:placeholder
                       options:0
                      progress:nil
                     completed:nil];
}

- (void)dxw_loadImageWithURL:(NSURL *)url
            placeholderImage:(UIImage *)placeholder
                   completed:(SDExternalCompletionBlock)completed {
    [self dxw_loadImageWithURL:url
              placeholderImage:placeholder
                       options:0
                      progress:nil
                     completed:completed];
}


- (void)dxw_loadImageWithURL:(NSURL *)url
            placeholderImage:(UIImage *)placeholder
                    progress:(SDWebImageDownloaderProgressBlock)progress
                   completed:(SDExternalCompletionBlock)completed {
    [self dxw_loadImageWithURL:url
              placeholderImage:placeholder
                       options:0
                      progress:progress
                     completed:completed];
}

/**
 UIImageView image 'url' 'placeholder' 'options' 'progress' 'completed'
 
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
                   completed:(SDExternalCompletionBlock)completed {
    [self sd_setImageWithURL:url
            placeholderImage:placeholder
                     options:options
                    progress:progress
                   completed:completed];
}


@end
