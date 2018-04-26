//
//  EPUBModel.m
//  iOSProject
//
//  Created by 360doc on 2018/4/24.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "EPUBModel.h"
#import "NSFileManager+Manager.h"

@interface EPUBModel()

@property (nonatomic , strong) EPUBParser *epubParser; //epub解析器


@end

@implementation EPUBModel

//epubModel
- (EPUBModel *)EPUBModle:(NSString *)fileFullPath {
    
    NSString *fileName=[[fileFullPath lastPathComponent] stringByDeletingPathExtension];
    
    if (!_unzipEpubFolder || [_unzipEpubFolder length] <2) {
        self.unzipEpubFolder = [self localPath:fileName];
    }
    
    self.manifestFilePath =[NSString stringWithFormat:@"%@/META-INF/container.xml", _unzipEpubFolder];
    
    int openSuccess=1;
    if (![NSFileManager dxw_isFileExist:self.manifestFilePath]) {
        openSuccess=[self.epubParser openFilePath:fileFullPath WithUnzipFolder:_unzipEpubFolder];
    }
    if (openSuccess<1) {
        DLog(@"文件open失败");
    }else {
        self.opfFilePath=[self.epubParser opfFilePathWithManifestFile:self.manifestFilePath WithUnzipFolder:_unzipEpubFolder];
        
        self.ncxFilePath=[self.epubParser ncxFilePathWithOpfFile:self.opfFilePath WithUnzipFolder:_unzipEpubFolder];
        
        //NSString *coverFile=[self.epubParser coverFilePathWithOpfFile:self.opfFilePath WithUnzipFolder:_unzipEpubFolder]; //ok
        
        //基本信息
        self.epubInfo=[self.epubParser epubFileInfoWithOpfFile:self.opfFilePath];
        
        //目录信息
        self.epubCatalogs=[self.epubParser epubCatalogWithNcxFile:self.ncxFilePath];
        
        //页码索引
        self.epubPageRefs=[self.epubParser epubPageRefWithOpfFile:self.opfFilePath];
        
        //页码信息
        self.epubPageItems=[self.epubParser epubPageItemWithOpfFile:self.opfFilePath];
    }
    
    return self;
}

//jsContent
- (NSString *)jsContentWithViewRect:(CGRect)rectView {
    
   self.epubSetting.currentTextSize = 20;
    
    //
    //NSString *js0=@"<?xml-stylesheet type=\"text/css\" href=\"font1.css\"?>";
    //    NSString *js0=@"<style type=\"text/css\"> @font-face{ font-family: 'DFPShaoNvW5'; src: url('DFPShaoNvW5-GB.ttf'); } </style> ";
    
    NSString *js0=@"";
    if (self.epubSetting.fontSelectIndex != 0) {
        if (self.epubSetting.arrFont.count > 0) {
            NSDictionary *dic = self.epubSetting.arrFont[self.epubSetting.fontSelectIndex];
            NSString *fontName = dic[@"fontName"];
            NSString *fontFile = dic[@"fontFile"];
            js0 = [self jsFontStyle:fontName fontFile:fontFile];
        }
    }
    
    NSString *js1=@"<style>img {  max-width:100% ; }</style>\n";
    
    NSMutableArray *arrJs=[NSMutableArray array];
    [arrJs addObject:@"<script>"];
    [arrJs addObject:@"var mySheet = document.styleSheets[0];"];
    [arrJs addObject:@"function addCSSRule(selector, newRule){"];
    [arrJs addObject:@"if (mySheet.addRule){"];
    [arrJs addObject:@"mySheet.addRule(selector, newRule);"];
    [arrJs addObject:@"} else {"];
    [arrJs addObject:@"ruleIndex = mySheet.cssRules.length;"];
    [arrJs addObject:@"mySheet.insertRule(selector + '{' + newRule + ';}', ruleIndex);"];
    [arrJs addObject:@"}"];
    [arrJs addObject:@"}"];
    
    
    [arrJs addObject:@"addCSSRule('p', 'text-align: justify;');"];
    [arrJs addObject:@"addCSSRule('highlight', 'background-color: yellow;');"];
    {
        NSString *css1 = [NSString stringWithFormat:@"addCSSRule('body', ' font-size:%@px;');",@(self.epubSetting.currentTextSize)];
        [arrJs addObject:css1];
        NSString *css2 = [NSString stringWithFormat:@"addCSSRule('p', ' font-size:%@px;');",@(self.epubSetting.currentTextSize)];
        [arrJs addObject:css2];
    }
    {
        NSString *fontName= [[self.epubSetting.arrFont objectAtIndex:self.epubSetting.fontSelectIndex] objectForKey:@"fontName"];
        NSString *css1=[NSString stringWithFormat:@"addCSSRule('body', ' font-family:\"%@\";');",fontName];
        [arrJs addObject:css1];
    }
    
    [arrJs addObject:@"addCSSRule('body', ' margin:0 15 0 15;');"];
    {
        NSString *css1=[NSString stringWithFormat:@"addCSSRule('html', 'padding: 0px; height: %@px; -webkit-column-gap: 0px; -webkit-column-width: %@px;');",@(rectView.size.height),@(rectView.size.width)];
        [arrJs addObject:css1];
        
    }
    
    [arrJs addObject:@"</script>"];
    
    NSString *jsJoin=[arrJs componentsJoinedByString:@"\n"];
    
    NSString *jsRet=[NSString stringWithFormat:@"%@\n%@\n%@",js0,js1,jsJoin];
    return jsRet;
}
//pageURL
-(NSString*)pageURLWithPageRefIndex:(NSInteger)pageRefIndex
{
    //得到当前页码索引的路径
    if (pageRefIndex <0 || pageRefIndex >= [self.epubPageRefs count]) {
        return nil;
    }
    
    NSString *pageRef=[self.epubPageRefs objectAtIndex:pageRefIndex];
    NSMutableDictionary *pageItem=[self pageItemWithPageRef:pageRef];
    if (pageItem) {
        
        NSString *href=pageItem[@"href"];
        
        NSString *pageURL=[NSString stringWithFormat:@"%@/%@",[NSFileManager dxw_parentFolderWithFilePath:self.opfFilePath],href];
        if ([NSFileManager dxw_isFileExist:pageURL]) {
            return pageURL;
        }
    }
    return nil;
}
//htmlContent
- (NSString *)htmlContentFromFile:(NSString *)pageURL AddJsContent:(NSString *)jsContent {
    return [self.epubParser HTMLContentFromFile:pageURL AddJsContent:jsContent];
}

#pragma mark - 公共方法
-(NSString*)jsFontStyle:(NSString *)fontName fontFile:(NSString *)fontFile
{
    //注意 fontName, DFPShaoNvW5.ttf 如果改为 aa.ttf, 那么fontname也应该是“DFPShaoNvW5”，
    //fontName是系统认的名称,非文件名， 我这里把文件名改了，参考本文件的 customFontWithPath 方法得到真正的fontName
    
    //NSString *jsFont=@"<style type=\"text/css\"> @font-face{ font-family: 'DFPShaoNvW5'; src: url('DFPShaoNvW5-GB.ttf'); } </style> ";
    NSString *jsFontStyle=[NSString stringWithFormat:@"<style type=\"text/css\"> @font-face{ font-family: '%@'; src: url('%@'); } </style>",fontName,fontFile];
    
    return jsFontStyle;
}

//epub 文件,解压到沙盒路径
- (NSString *)localPath:(NSString *)fileName {
    
    NSString *libraryPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library"];
    NSString *cachesPath = [libraryPath stringByAppendingPathComponent:@"Caches"];
    NSString *epubCachePath = [cachesPath stringByAppendingPathComponent:@"epubcache"];
    NSString *path = [NSString stringWithFormat:@"%@/%@",epubCachePath,fileName];
    BOOL success = [NSFileManager dxw_createDirectory:path];
    if (success) {
        return path;
    }
    return nil;
}

-(NSMutableDictionary*)pageItemWithPageRef:(NSString*)pageRef
{
    //根据 pageRef  返回对应的 pageItem
    
    for (NSMutableDictionary *item1 in self.epubPageItems) {
        
        NSString *itemID=item1[@"id"];
        //NSString *itemhref=item1[@"href"];
        
        if ([itemID isEqualToString:pageRef]) {
            return item1;
        }
    }
    return nil;
}

#pragma mark - ljz
- (EPUBParser *)epubParser {
    if (!_epubParser) {
        _epubParser = [[EPUBParser alloc] init];
    }
    return _epubParser;
}

- (EPUBReadSetting *)epubSetting {
    if (!_epubSetting) {
        _epubSetting = [[EPUBReadSetting alloc] init];
    }
    return _epubSetting;
}

@end
