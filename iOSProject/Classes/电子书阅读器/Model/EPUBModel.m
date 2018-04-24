//
//  EPUBModel.m
//  iOSProject
//
//  Created by 360doc on 2018/4/24.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "EPUBModel.h"

@interface EPUBModel()


@property (nonatomic,strong) NSString *manifestFilePath;//epub 核心文件
@property (nonatomic,strong) NSString *opfFilePath;     //epub 核心文件
@property (nonatomic,strong) NSString *ncxFilePath;     //epub 核心文件

@property (nonatomic , strong) EPUBParser *epubParser; //epub解析器

@end

@implementation EPUBModel

- (EPUBModel *)EPUBModle:(NSString *)EPUBName {
    DXWWeakSelf(self);
    
    NSString *fileFullPath=[[NSBundle mainBundle] pathForResource:@"iOSApprentice" ofType:@"epub" inDirectory:nil];
    NSString *fileName=[[fileFullPath lastPathComponent] stringByDeletingPathExtension];
    
    
    if ( !_unzipEpubFolder || [_unzipEpubFolder length] <2)
    {
        NSString *libraryPath = [NSHomeDirectory() stringByAppendingPathComponent:  @"Library"];
        NSString *cachesPath=[libraryPath stringByAppendingPathComponent:@"Caches"];
        NSString *epubCachePath=[cachesPath stringByAppendingPathComponent:@"epubcache"];
        self.unzipEpubFolder=[NSString stringWithFormat:@"%@/%@",epubCachePath,fileName];
        [self createDirectory:_unzipEpubFolder];
    }
    
    
    self.manifestFilePath =[NSString stringWithFormat:@"%@/META-INF/container.xml", _unzipEpubFolder];
    
    int openSuccess=1;
    if ( ! [self isFileExist:self.manifestFilePath]) {
        openSuccess=[self.epubParser openFilePath:fileFullPath WithUnzipFolder:_unzipEpubFolder];
    }
    if (openSuccess<1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            DLog(@"文件open失败");
            
//            [_weakself showMsgInView:self.view ContentString:@"文件open失败" isActivity:NO HideAfter:3.0];
        });
        
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

-(BOOL)isFileExist:(NSString *)path
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:path];
}

-(BOOL)createDirectory:(NSString*)strFolderPath
{
    //创建文件夹
    BOOL bDo1=YES;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:strFolderPath] == NO) {
        bDo1=[fileManager createDirectoryAtPath:strFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return bDo1;
}


@end
