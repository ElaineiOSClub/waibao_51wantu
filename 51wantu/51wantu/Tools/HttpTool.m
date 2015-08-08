//
//  HttpTool.m
//  iosNav
//
//  Created by elaine on 15/5/13.
//  Copyright (c) 2015年 mandalat. All rights reserved.
//

#import "HttpTool.h"


@implementation HttpTool

+ (void)downLoadWithUrlPath:(NSString *)path
                   filePath:(NSString *)filePath
              progressBlock:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))block
 completionBlockWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    NSURL *url = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.inputStream   = [NSInputStream inputStreamWithURL:url];
    operation.outputStream  = [NSOutputStream outputStreamToFileAtPath:filePath append:NO];
    
    //下载进度控制
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        block(bytesRead,totalBytesRead,totalBytesExpectedToRead);
    }];
    
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(operation,error);
    }];
    
    [operation start];

}

+ (void)httpToolPost:(NSString *)urlString
          parameters:(id)parameters
             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure

{
    AFHTTPRequestOperationManager *tx = [AFHTTPRequestOperationManager manager];
    
    [tx POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

+ (void)httpToolPost:(NSString *)urlString
          parameters:(id)parameters
    headerParameters:(NSDictionary *)headerParameters
             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure

{
    AFHTTPRequestOperationManager *tx = [AFHTTPRequestOperationManager manager];
    for (NSString *key in headerParameters.allKeys) {
        [tx.requestSerializer setValue:headerParameters[key] forHTTPHeaderField:key];
    }
    
    [tx POST:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
    
}



+ (void)httpToolGet:(NSString *)urlString
         parameters:(id)parameters
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure

{
    AFHTTPRequestOperationManager *tx = [AFHTTPRequestOperationManager manager];
    
    [tx GET:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
    
}

+ (void)httpToolGet:(NSString *)urlString
         parameters:(id)parameters headerParameters:(NSDictionary *)headerParameters
            success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure

{
    AFHTTPRequestOperationManager *tx = [AFHTTPRequestOperationManager manager];
    for (NSString *key in headerParameters.allKeys) {
        [tx.requestSerializer setValue:headerParameters[key] forHTTPHeaderField:key];
    }
    
    [tx GET:urlString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}



#pragma mark - 项目专用cookie
+ (void)httpToolWithCookieGet:(NSString *)urlString
                   parameters:(id)parameters
                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure

{
//    NSString *token = [AccountTool shareAccount].account.token;
//    NSString *cookie = [AccountTool shareAccount].account.cookie;
    
//    [self httpToolGet:urlString parameters:parameters headerParameters:@{@"Bear":token,@"cookie":cookie} success:success failure:failure];
}




+ (void)httpToolWithCookiePost:(NSString *)urlString
                    parameters:(id)parameters
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure

{
//    NSString *token = [AccountTool shareAccount].account.token;
//    NSString *cookie = [AccountTool shareAccount].account.cookie;
    
//    [self httpToolPost:urlString parameters:parameters headerParameters:@{@"Bear":token,@"cookie":cookie} success:success failure:failure];
}











@end
