//
//  JJBaseRequest.h
//  JJTools
//
//  Created by Brain on 2018/12/12.
//  Copyright © 2018 Brain. All rights reserved.
//

#import <Foundation/Foundation.h>

//NS_ASSUME_NONNULL_BEGIN

typedef void(^successHandler)(id responseObject,NSInteger statusCode);
typedef void(^failHandler)(NSError *e,NSInteger statusCode,NSString *errorMsg);

//上传文件
typedef void(^uploadingHandler)(double progressValue);      //上传进度实时回调
typedef void(^uploadCompleteHandler)(id responseObject);    //上传完成时回调
typedef void(^uploadErrorHandler)(NSError *errMessage);     //上传失败时回调

//下载文件
typedef void(^downloadingHandler)(double processValue);     //下载进度实时回调
typedef void(^downloadCompleteHandler)(NSString *filePath); //下载完成时回调
typedef void(^downloadErrorHandler)(NSError *errMessage);   //下载失败时回调
@interface JJBaseRequest : NSObject


/**
 网络请求的基类

 @param url url地址
 @param method get post
 @param parameters dic
 @param headers  请求头
 @param successHandler 成功的回调
 @param failHandler 失败的回调
 */
-(void)doHttpWithUrl:(NSString *)url andMetohd:(NSString *)method andParameters:(NSDictionary *)parameters andHeaders:(NSDictionary *)headers withSuccessHandler:(successHandler)successHandler andFailHandler:(failHandler)failHandler;

///**
// *  上传文件方法，实时返回上传进度
// *
// *  @param url              上传服务器地址
// *  @param path             本地文件路径
// *  @param fileName         文件名
// *  @param mimeType         文件类型
// *  @param uploadingHandler 上传进度实时回调
// *  @param completeHandler  完成时回调
// *  @param errHandler       失败时回调
// */
//- (void)upLoadFileWithUrl:(NSString*)url filePath:(NSString*)path fileName:(NSString*)fileName mimeType:(NSString*)mimeType withPorcessingHandler:(uploadingHandler)uploadingHandler withCompleteHandler:(uploadCompleteHandler)completeHandler withErrorHandler:(uploadErrorHandler)errHandler;
//
///**
// *  下载文件方法，实时返回下载进度
// *
// *  @param url                     下载地址
// *  @param downloadingHandler      下载进度回调
// *  @param downloadCompleteHandler 下载完成回调
// *  @param errHandler              错误回调
// */
//- (void)downloadFileWithUrl:(NSString*)url withProcess:(downloadingHandler)downloadingHandler withCompleteHandler:(downloadCompleteHandler)downloadCompleteHandler withErrorHandler:(downloadErrorHandler)errHandler;
//
////新
//- (void)upLoadFileWithUrl:(NSString*)url dicParama:(NSDictionary *)dicPara filePath:(NSString*)path name:(NSString*)name fileName:(NSString*)fileName mimeType:(NSString*)mimeType withPorcessingHandler:(uploadingHandler)uploadingHandler withCompleteHandler:(uploadCompleteHandler)completeHandler withErrorHandler:(uploadErrorHandler)errHandler;
//
//- (void)upLoadFileWithUrl:(NSString*)url dicParama:(NSDictionary *)dicPara fileArr:(NSArray *)arrFile name:(NSString*)name fileName:(NSString*)fileName mimeType:(NSString*)mimeType withPorcessingHandler:(uploadingHandler)uploadingHandler withCompleteHandler:(uploadCompleteHandler)completeHandler withErrorHandler:(uploadErrorHandler)errHandler;
/**
 * 上传图片
 *
 *  @param url  下载地址
 *  @param paramDict 参数字典
 *  @param imageData 文件内容
 *  @param fileName 文件名称
 *  @param key 文件对应key
 *  @param successHandler 成功回调
 *  @param failHandler    失败回调
 */
- (void)uploadImageWithUrl:(NSString*)url dicParama:(NSDictionary *)paramDict imageData:(NSData *)imageData fileName:(NSString *)fileName key:(NSString *)key withSuccessHandler:(successHandler)successHandler andFailHandler:(failHandler)failHandler;

@end

//NS_ASSUME_NONNULL_END
