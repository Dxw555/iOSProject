//
//  EPUBViewController.m
//  iOSProject
//
//  Created by 360doc on 2018/4/17.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "EPUBViewController.h"
#import "EPUBWebView.h"

@interface EPUBViewController ()

/** webView */
@property (nonatomic , strong) EPUBWebView *webView;

@end

@implementation EPUBViewController

- (void)dealloc {
    DLog(@"dealloc %ld",self.index);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.webView];
    [self.webView loadHTMLString:[NSString stringWithFormat:@"%ld",_index] baseURL:nil];
}


- (EPUBWebView *)webView  {
    if (!_webView) {
        _webView = [[EPUBWebView alloc] initWithFrame:self.view.bounds];
    }
    return _webView;
}

@end
