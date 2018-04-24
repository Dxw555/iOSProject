//
//  WKWebView+SearchWebView.h
//  iOSProject
//
//  Created by 360doc on 2018/4/24.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WKWebView (SearchWebView)

- (void)highlightAllOccurencesOfString:(NSString*)str result:(void(^)(NSInteger count))result;
- (void)removeAllHighlights;
- (void)underlineAllOccurencesOfString:(NSString*)str result:(void(^)(NSInteger count))result;

@end
