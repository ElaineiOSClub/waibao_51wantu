//
//  HttpTool.h
//  iosNav
//
//  Created by elaine on 15/5/13.
//  Copyright (c) 2015年 mandalat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface HttpTool : NSObject



/**
 *  下载附件
 *
 *  @param path     字符串路径
 *  @param filePath 保存的文件路径
 *  @param block
 *  @param success
 *  @param failure
 */
+ (void)downLoadWithUrlPath:(NSString *)path filePath:(NSString *)filePath progressBlock:(void (^)(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead))block completionBlockWithSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  Post
 *  @param urlString  urlString
 *  @param parameters urlString
 *  @param success
 *  @param failure    
 */
+ (void)httpToolPost:(NSString *)urlString parameters:(id)urlString success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  带header的Post
 *
 *  @param urlString        urlString description
 *  @param parameters       parameters description
 *  @param headerParameters headerParameters description
 *  @param success          success description
 *  @param httpToolGet      httpToolGet description
 *  @param urlString        urlString description
 *  @param parameters       parameters description
 *  @param success          success description
 *  @param failure          failure description
 */
+ (void)httpToolPost:(NSString *)urlString parameters:(id)parameters headerParameters:(NSDictionary *)headerParameters success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


/**
 *  Get
 *  @param urlString
 *  @param parameters
 *  @param success
 *  @param failure
 */
+ (void)httpToolGet:(NSString *)urlString parameters:(id)parameters success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

+ (void)httpToolGet:(NSString *)urlString parameters:(id)parameters headerParameters:(NSDictionary *)headerParameters success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
            failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


#pragma mark - cookie
+ (void)httpToolWithCookieGet:(NSString *)urlString
                   parameters:(id)parameters
                      success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                      failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


+ (void)httpToolWithCookiePost:(NSString *)urlString parameters:(id)parameters  success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end
