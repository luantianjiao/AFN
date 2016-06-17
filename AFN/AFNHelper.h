//
//  AFNHelper.h
//  AFNTest
//
//  Created by luan on 16/6/16.
//  Copyright © 2016年 luan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AFHTTPSessionManager.h>

@interface AFNHelper : AFHTTPSessionManager

//单例
+ (AFNHelper *)sharedManager;

/**
 *  get请求
 *
 *  @param url        接口url
 *  @param parameters 参数
 *  @param success    请求成功的block
 *  @param failure    请求失败的block
 */
+ (void)get:(NSString *)url parameter:(id )parameters success:(void(^)(id responseObject))success faliure:(void(^)(id error))failure;

/**
 *  post请求
 *
 *  @param url        接口url
 *  @param parameters 参数
 *  @param success    请求成功的block
 *  @param failure    请求失败的block
 */
+ (void)post:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success faliure:(void(^)(id error))failure;
/**
 *  post请求 不拼接基地址
 *
 *  @param url        接口url
 *  @param parameters 参数
 *  @param success    请求成功的block
 *  @param failure    请求失败的block
 */
+ (void)postNoBaseUrl:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success faliure:(void(^)(id error))failure;


/**
 *  文件上传
 *
 *  @param url        接口url
 *  @param parameters 参数
 *  @param block      图片data
 *  @param success    请求成功的block
 *  @param failure    请求失败的block
 */
+ (void )post:(NSString *)url parameters:(id)parameters  constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block success:(void (^)(id responseObject))success faliure:(void (^)(id error))failure;


/**
 *  文件下载
 *
 *  @param request       下载请求
 *  @param ProgressBlock 下载进度block
 *  @param savePath      储存路径
 *  @param failure       下载失败block
 */
+ (void)downloadTaskWithUrl:(NSString *)url progress:(void (^)(id downloadProgress))ProgressBlock savePath:(NSString *)savePath  completionHandler:(void (^)(NSURLResponse *response ,NSURL *filePath))completion  error:(void (^)(id error))failure;


@end
