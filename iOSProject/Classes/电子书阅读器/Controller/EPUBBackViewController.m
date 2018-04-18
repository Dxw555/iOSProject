//
//  EPUBBackViewController.m
//  iOSProject
//
//  Created by 360doc on 2018/4/17.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "EPUBBackViewController.h"

@interface EPUBBackViewController ()
@property (nonatomic, strong) UIImage *backgroundImage;
@end

@implementation EPUBBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [imageView setAutoresizingMask:UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth];
    [imageView setImage:_backgroundImage];
    [imageView setAlpha:0.9];
    [self.view addSubview:imageView];
}

- (void)updateWithViewController:(EPUBViewController *)viewController {
    self.backgroundImage = [self captureView:viewController.view];
    self.currentViewController = viewController;
}

- (UIImage *)captureView:(UIView *)view {
    CGSize size = view.bounds.size;
    CGAffineTransform transform = CGAffineTransformMake(-1,0,0,1,size.width,0);
    UIGraphicsBeginImageContextWithOptions(size, view.opaque, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(context, transform);
    [view.layer renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
