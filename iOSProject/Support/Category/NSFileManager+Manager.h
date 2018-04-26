//
//  NSFileManager+Manager.h
//  iOSProject
//
//  Created by 360doc on 2018/4/24.
//  Copyright © 2018年 dxw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSFileManager (Manager)

//文件夹是否存在
+ (BOOL)dxw_isFileExist:(NSString *)path;

//创建文件夹
+ (BOOL)dxw_createDirectory:(NSString*)strFolderPath ;

//根据名称，返回绝对路径
+ (NSString *)dxw_fileFindFullPathWithFileName:(NSString*)fileName InDirectory:(NSString*)inDirectory;

//删除文件
+ (BOOL)dxw_deleteFileAtPath:(NSString*)path ;

//当前文件 或 文件夹的 父文件夹
+ (NSString *)dxw_parentFolderWithFilePath:(NSString*)fileFullPath ;
@end
