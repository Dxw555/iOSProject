//
//  WKWebView+SearchWebView.m
//  iOSProject
//
//  Created by 360doc on 2018/4/24.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "WKWebView+SearchWebView.h"

@implementation WKWebView (SearchWebView)

- (void)highlightAllOccurencesOfString:(NSString*)str result:(void(^)(NSInteger count))result{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"SearchWebView" ofType:@"js"];
    NSString *jsCode = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    [self evaluateJavaScript:jsCode completionHandler:nil];
    
    NSString *startSearch = [NSString stringWithFormat:@"MyApp_HighlightAllOccurencesOfString('%@');",str];
    
    
    [self evaluateJavaScript:startSearch completionHandler:nil];
    
    [self evaluateJavaScript:@"MyApp_SearchResultCount;" completionHandler:^(id _Nullable count, NSError * _Nullable error) {
        if (result) {
            result((NSInteger)count);
        }
    }];
}

- (void)removeAllHighlights {
    [self evaluateJavaScript:@"MyApp_RemoveAllHighlights()" completionHandler:nil];
}

/////////////////////////////////////

- (void)underlineAllOccurencesOfString:(NSString*)str result:(void(^)(NSInteger count))result{

    NSString *path = [[NSBundle mainBundle] pathForResource:@"SearchWebView" ofType:@"js"];
    NSString *jsCode = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    [self evaluateJavaScript:jsCode completionHandler:nil];
    NSString *startSearch = [NSString stringWithFormat:@"MyApp_UnderlineAllOccurencesOfString('%@');",str];
    [self evaluateJavaScript:startSearch completionHandler:nil];
    
    [self evaluateJavaScript:@"MyApp_SearchResultCount;" completionHandler:^(id _Nullable count, NSError * _Nullable error) {
        if (result) {
            result((NSInteger)count);
        }
    }];
}

@end
