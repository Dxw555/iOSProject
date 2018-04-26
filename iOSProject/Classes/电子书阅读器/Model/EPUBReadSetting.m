//
//  EPUBReadSetting.m
//  iOSProject
//
//  Created by 360doc on 2018/4/17.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "EPUBReadSetting.h"
#import "GDataXMLNode.h"
#import "NSFileManager+Manager.h"

@implementation EPUBReadSetting



#pragma mark - ljz
//字体
- (NSMutableArray *)arrFont {
    if (!_arrFont) {
        _arrFont = [[NSMutableArray alloc] init];
       
        NSMutableDictionary *fontItem=[NSMutableDictionary dictionary];
        [fontItem setObject:@"0" forKey:@"type"];   // 0 系统自带 ， 1 为 custom
        [fontItem setObject:NSLocalizedString(@"系统字体", @"") forKey:@"name"];
        [fontItem setObject:@"Helvetica" forKey:@"fontName"];
        
        [_arrFont addObject:fontItem];
    }
    return _arrFont;
}
//主题
- (NSMutableArray *)arrTheme {
    if (!_arrTheme) {
        _arrTheme = [[NSMutableArray alloc] init];
        
        NSString *themeFilePath =[NSFileManager dxw_fileFindFullPathWithFileName:@"epubtheme.xml" InDirectory:nil];
        
        if (![NSFileManager dxw_isFileExist:themeFilePath]) {
            return _arrTheme;
        }
        
        NSData *xmlData=[[NSData alloc] initWithContentsOfFile:themeFilePath];
        if (xmlData) {
            NSError *err = nil;
            GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData error:&err];
            if ([err code] == 0)
            {
                //根节点
                GDataXMLElement *root = [doc rootElement];
                
                NSError *errXPath=nil;
                NSArray *arrItems=[root nodesForXPath:@"item" error:&errXPath];
                
                for (GDataXMLElement *item1 in arrItems)
                {
                    NSString *name= [[item1 attributeForName:@"name"] stringValue];
                    
                    NSString *bodycolor=nil;
                    NSString *textcolor=nil;
                    
                    {
                        NSArray *arr1=[item1 nodesForXPath:@"bodycolor" error:nil];
                        if ([arr1 count]>0) {
                            GDataXMLElement *child1=arr1[0];
                            bodycolor=[child1 stringValue];
                        }
                    }
                    {
                        NSArray *arr1=[item1 nodesForXPath:@"textcolor" error:nil];
                        if ([arr1 count]>0) {
                            GDataXMLElement *child1=arr1[0];
                            textcolor=[child1 stringValue];
                        }
                    }
                    
                    //
                    if ([textcolor length]>0 && [bodycolor length]>0) {
                        NSMutableDictionary *theme1=[NSMutableDictionary dictionary];
                        [theme1 setObject:name forKey:@"name"];
                        [theme1 setObject:bodycolor forKey:@"bodycolor"];
                        [theme1 setObject:textcolor forKey:@"textcolor"];
                        [_arrTheme addObject:theme1];
                    }
                }
            }
        }
    }
    return _arrTheme;
}

- (NSMutableDictionary *)dictPageWithOffYCount {
    if (!_dictPageWithOffYCount) {
        _dictPageWithOffYCount = [[NSMutableDictionary alloc] init];
    }
    return _dictPageWithOffYCount;
}

@end
