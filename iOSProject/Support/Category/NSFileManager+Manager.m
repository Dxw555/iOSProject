//
//  NSFileManager+Manager.m
//  iOSProject
//
//  Created by 360doc on 2018/4/24.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import "NSFileManager+Manager.h"

@implementation NSFileManager (Manager)

//文件夹是否存在
+ (BOOL)dxw_isFileExist:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:path];
}

//创建文件夹
+ (BOOL)dxw_createDirectory:(NSString*)strFolderPath {
    
    BOOL bDo1=YES;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:strFolderPath] == NO)
    {
        bDo1=[fileManager createDirectoryAtPath:strFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return bDo1;
}

//根据名称，返回绝对路径
+ (NSString *)dxw_fileFindFullPathWithFileName:(NSString*)fileName InDirectory:(NSString*)inDirectory {
    NSString *ret=nil;
    NSRange r1=[fileName rangeOfString:@"."];
    if (r1.location != NSNotFound )
    {
        NSString *name=[fileName substringToIndex:r1.location];
        NSString *fileExt=[fileName pathExtension];
        ret = [[NSBundle mainBundle] pathForResource:name ofType:fileExt inDirectory:inDirectory];
    }
    return ret;
}

//删除文件
+ (BOOL)dxw_deleteFileAtPath:(NSString*)path {
    BOOL bDo1=NO;
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path])
    {
        bDo1=[fileManager removeItemAtPath:path error:nil];
    }
    return bDo1;
}

//当前文件 或 文件夹的 父文件夹
+ (NSString *)dxw_parentFolderWithFilePath:(NSString*)fileFullPath {
    if ([fileFullPath length]<1) {
        return nil;
    }
    NSInteger lastSlash = [fileFullPath rangeOfString:@"/" options:NSBackwardsSearch].location;
    NSString *parentPath = [fileFullPath substringToIndex:lastSlash];
    return parentPath;
}

@end
