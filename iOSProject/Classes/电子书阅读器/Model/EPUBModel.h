//
//  EPUBModel.h
//  iOSProject
//
//  Created by 360doc on 2018/4/24.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EPUBParser.h"
#import "EPUBReadSetting.h"

@interface EPUBModel : NSObject

@property (nonatomic, strong) NSString *unzipEpubFolder; //epub解压到
@property (nonatomic, strong) NSMutableDictionary *epubInfo; //epub基本信息
@property (nonatomic, strong) NSMutableArray *epubCatalogs;  //epub目录信息
@property (nonatomic, strong) NSMutableArray *epubPageRefs;  //epub页码索引
@property (nonatomic, strong) NSMutableArray *epubPageItems; //epub页码信息

@property (nonatomic, strong) NSString *manifestFilePath;//epub 核心文件
@property (nonatomic, strong) NSString *opfFilePath;     //epub 核心文件
@property (nonatomic, strong) NSString *ncxFilePath;     //epub 核心文件
@property (nonatomic, strong) EPUBReadSetting *epubSetting;     //epub 阅读设置

//EPUBModel
- (EPUBModel *)EPUBModle:(NSString *)EPUBName ;

//jsContent
- (NSString *)jsContentWithViewRect:(CGRect)rectView ;

//pageURL
-(NSString*)pageURLWithPageRefIndex:(NSInteger)pageRefIndex ;

//htmlContent
- (NSString *)htmlContentFromFile:(NSString *)pageURL AddJsContent:(NSString *)jsContent ;

@end
