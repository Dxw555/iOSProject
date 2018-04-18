//
//  EPUBWebView.m
//  iOSProject
//
//  Created by 360doc on 2018/4/17.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "EPUBWebView.h"

@implementation EPUBWebView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView.scrollEnabled = NO;
        self.scrollView.bounces = NO;
    }
    return self;
}

@end
