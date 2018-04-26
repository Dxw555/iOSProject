//
//  EPUBViewController.m
//  iOSProject
//
//  Created by 360doc on 2018/4/17.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "EPUBViewController.h"
#import "EPUBWebView.h"

@interface EPUBViewController () <UIWebViewDelegate>

/** webView */
@property (nonatomic , strong) EPUBWebView *webView;

@end

@implementation EPUBViewController


- (instancetype)initWithPagrRefIndex:(NSInteger)pageRefIndex offYIndexInPage:(NSInteger)offYIndexInPage isPrePage:(BOOL)isPrePage epub:(EPUBModel *)epub {
    self = [super init];
    if (self) {
        self.epub = epub;
        self.currentPageRefIndex = pageRefIndex;
        self.currentOffYIndexInPage = offYIndexInPage;
        self.isPrePage = isPrePage;
        
        self.view.backgroundColor = DXWColorHex(0x0dad51);
        [self.view addSubview:self.webView];
        
        NSString *jsContent = [self.epub jsContentWithViewRect:self.webView.frame];
        NSString *pageURL=[self.epub pageURLWithPageRefIndex:self.currentPageRefIndex];
        NSString *htmlContent= [self.epub htmlContentFromFile:pageURL AddJsContent:jsContent];
        [self.webView loadHTMLString:htmlContent baseURL:[NSURL fileURLWithPath:pageURL]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}
#pragma mark - uiwe

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSInteger totalWidth = [[self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.scrollWidth"] integerValue];
    NSInteger theWebSizeWidth=self.webView.bounds.size.width - 30;
    int offCountInPage = (int)((float)totalWidth/theWebSizeWidth);
    [self.epub.epubSetting.dictPageWithOffYCount setObject:[NSString stringWithFormat:@"%@",@(offCountInPage)] forKey:[NSString stringWithFormat:@"%@",@(self.currentPageRefIndex)]];
    
    NSInteger currentOffCountInPage=[[self.epub.epubSetting.dictPageWithOffYCount objectForKey:[NSString stringWithFormat:@"%@",@(self.currentPageRefIndex)]] integerValue];
    if (self.isPrePage) {
        self.currentOffYIndexInPage = currentOffCountInPage - 1;
    }
    [self gotoOffYInPageWithOffYIndex:self.currentOffYIndexInPage WithOffCountInPage:offCountInPage];
}

- (int)gotoOffYInPageWithOffYIndex:(NSInteger)offyIndex WithOffCountInPage:(NSInteger)offCountInPage {
    //页码内跳转
    if(offyIndex >= offCountInPage)
    {
        offyIndex = offCountInPage - 1;
    }
    self.currentOffYIndexInPage = offyIndex;
    float pageOffset = offyIndex * self.webView.bounds.size.width;
    
    NSString* goToOffsetFunc = [NSString stringWithFormat:@" function pageScroll(xOffset){ window.scroll(xOffset,0); } "];
    NSString* goTo =[NSString stringWithFormat:@"pageScroll(%f)", pageOffset];

    [self.webView stringByEvaluatingJavaScriptFromString:goToOffsetFunc];
    [self.webView stringByEvaluatingJavaScriptFromString:goTo];
    
    
    //背景主题
//    //NSString *bodycolor= [NSString stringWithFormat:@"addCSSRule('body', 'background-color: #f6e5c3;')"];
    NSString *themeBodyColor=[self.epub.epubSetting.arrTheme[self.epub.epubSetting.themeIndex] objectForKey:@"bodycolor"];
    NSString *bodycolor= [NSString stringWithFormat:@"addCSSRule('body', 'background-color: %@;')",themeBodyColor];
    [self.webView stringByEvaluatingJavaScriptFromString:bodycolor];
//
//    //NSString *textcolor1=[NSString stringWithFormat:@"addCSSRule('h1', 'color: #ffffff;')"];
    NSString *themeTextColor=[self.epub.epubSetting.arrTheme[self.epub.epubSetting.themeIndex] objectForKey:@"textcolor"];
    NSString *textcolor1=[NSString stringWithFormat:@"addCSSRule('h1', 'color: %@;')",themeTextColor];
    [self.webView stringByEvaluatingJavaScriptFromString:textcolor1];
//
//    //NSString *textcolor2=[NSString stringWithFormat:@"addCSSRule('p', 'color: #ffffff;')"];
    NSString *textcolor2=[NSString stringWithFormat:@"addCSSRule('p', 'color: %@;')",themeTextColor];
    [self.webView stringByEvaluatingJavaScriptFromString:textcolor2];
    
    //刷新显示文本
//    [self refresh];
    //
    //    //刷新 epubVC Head,Foot
    //    [self.epubVC refreshChapterLabel];
    
    NSInteger currentPageRefIndex = self.currentPageRefIndex;
    NSInteger currentOffYIndexInPage = self.currentOffYIndexInPage;
    NSMutableDictionary *dictPageWithOffYCount = self.epub.epubSetting.dictPageWithOffYCount;
    NSInteger currentPageCount = [[dictPageWithOffYCount objectForKey:[NSString stringWithFormat:@"%@",@(currentPageRefIndex)]] integerValue];
    if (currentPageCount < 1) {
        currentPageCount = 1;
    }
    
    DLog(@"page = %ld %ld /%ld",currentPageRefIndex + 1,currentOffYIndexInPage + 1,currentPageCount);
    
    self.epub.epubSetting.currentPageRefIndex = self.currentPageRefIndex;
    self.epub.epubSetting.currentOffYIndexInPage = self.currentOffYIndexInPage;
    if (self.showFinish) {
        self.showFinish();
    }
    return 1;
}

#pragma mark - ljz
- (EPUBWebView *)webView {
    if (!_webView) {
        _webView = [[EPUBWebView alloc] initWithFrame:CGRectMake(0, 20, DXWScreenWidth, DXWScreenHeight - 30)];
        _webView.delegate = self;
        _webView.opaque = NO;
        _webView.backgroundColor = DXWColorHex(0x0dad51);
        _webView.scrollView.bounces = NO;
        _webView.scrollView.scrollEnabled = NO;
    }
    return _webView;
}

@end
