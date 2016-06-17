//
//  AFNHelper.m
//  AFNTest
//
//  Created by luan on 16/6/16.
//  Copyright © 2016年 luan. All rights reserved.
//

#import "AFNHelper.h"
#import <Foundation/Foundation.h>


//#define BaseUrl @"http://localhost/"
#define BaseUrl @"http://wan.sogou.com/"

@implementation AFNHelper

//单例实现
+ (AFNHelper *)sharedManager {
    
    static AFNHelper *handle = nil;
    
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handle = [AFNHelper manager];
        // 设置可接受的类型
        handle.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html",nil];
//        handle.responseSerializer = [AFHTTPResponseSerializer serializer];
    });
    
    return handle;
    
}


//get请求
+ (void )get:(NSString *)url parameter:(id)parameters success:(void (^)(id responseObject))success faliure:(void (^)(id error))failure
{
    
    [[AFNHelper sharedManager] GET:[BaseUrl stringByAppendingString:url] parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if(responseObject)  {
            
            success(responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
    
}

//post请求
+ (void)post:(NSString *)url parameters:(id)parameters success:(void(^)(id responseObject))success faliure:(void(^)(id error))failure {
    
    [[AFNHelper sharedManager] POST:[BaseUrl stringByAppendingString:url] parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(responseObject)  {
            
            success(responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
    
}


//文件上传
+ (void )post:(NSString *)url parameters:(id)parameters  constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block success:(void (^)(id responseObject))success faliure:(void (^)(id error))failure{
    
    [[AFNHelper sharedManager] POST:[BaseUrl stringByAppendingString:url] parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        block(formData);
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(responseObject)  {
            
            success(responseObject);
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
    
}


//文件下载
+ (void)downloadTaskWithUrl:(NSString *)url progress:(void (^)(id downloadProgress))ProgressBlock savePath:(NSString *)savePath  completionHandler:(void (^)(NSURLResponse *response ,NSURL *filePath))completion  error:(void (^)(id error))failure{
    
    //创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[BaseUrl stringByAppendingString:url]]];
    
    //创建任务
    NSURLSessionDownloadTask *download =  [[AFNHelper sharedManager]  downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        if (downloadProgress) {
            ProgressBlock(downloadProgress);
        }
        
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        
        return  [NSURL fileURLWithPath:savePath];
        
    }completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        
        if (!error) {
            completion(response,filePath);
        }
        else {
            
            failure(error);
            
        }
        
        
    }];
    //开启任务
    [download resume];   
}

@end
