//
//  EPUBModel.h
//  iOSProject
//
//  Created by 360doc on 2018/4/24.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "EPUBParser.h"

@interface EPUBModel : NSObject

@property (strong,nonatomic) NSString *unzipEpubFolder; //epub解压到
@property (nonatomic,strong) NSMutableDictionary *epubInfo; //epub基本信息
@property (nonatomic,strong) NSMutableArray *epubCatalogs;  //epub目录信息
@property (nonatomic,strong) NSMutableArray *epubPageRefs;  //epub页码索引
@property (nonatomic,strong) NSMutableArray *epubPageItems; //epub页码信息

@end
