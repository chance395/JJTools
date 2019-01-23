//
//  JJAlbumManagement.h
//  JJTools
//
//  Created by Brain on 2018/12/13.
//  Copyright © 2018 Brain. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JJAlbumManagement : NSObject
/**
 *  初始化方法
 *
 *  @param folderName 操作的目录文件
 *
 *  @return 操作对象
 */
- (instancetype)initWithFolderName:(NSString *)folderName;

/**
 *  保存图片到系统相册
 *
 *  @param imagePath  保存的图片路径
 */
- (void)saveImagePath:(NSString *)imagePath;

/**
 *  保存视频到系统相册
 *
 *  @param videoPath  保存的视频路径
 */
- (void)saveVideoPath:(NSString *)videoPath;

/**
 *  删除系统相册中的文件
 *
 *  @param filePath   文件的路径
 */
- (void)deleteFile:(NSString *)filePath;

/**
 *  用户是否授权访问系统相册
 *
 *  @return 是否授权访问系统相册
 */
- (BOOL)isGetAuthoritionOfAlbum;


@end

NS_ASSUME_NONNULL_END
