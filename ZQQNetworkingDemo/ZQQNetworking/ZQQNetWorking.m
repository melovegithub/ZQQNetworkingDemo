//
//  ZQQNetWorking.m
//  ZQQNetworkingDemo
//
//  Created by zqq on 15/11/30.
//  Copyright © 2015年 zqq. All rights reserved.
//

#import "ZQQNetWorking.h"
#import "AFNetworking.h"


/**
 *  __VA_ARGS__ 是一个可变参数的宏(gcc支持)。实现思想就是宏定义中参数列表的最后一个参数为省略号（也就是三个点）。这样预定义宏_ _VA_ARGS_ _就可以被用在替换部分中，替换省略号所代表的字符串。加##用来支持0个可变参数的情况。
 */

// 项目打包上线都不会打印日志，因此可放心。
#ifdef DEBUG
#define ZQQAppLog(s, ... ) NSLog( @"[%@：in line: %d]-->[message: %@]", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define ZQQAppLog(s, ... )
#endif

static BOOL isEnableInterfaceDebug = NO;

@implementation ZQQNetWorking

+(ZQQNetWorking *)sharedManager{
    static ZQQNetWorking *sharedNetworkingSingleton = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedNetworkingSingleton = [[self alloc] init];
    });
    return sharedNetworkingSingleton;
}

- (void)enableInterfaceDebug:(BOOL)isDebug{
    isEnableInterfaceDebug = isDebug;
}

- (BOOL)isDebug{
    return isEnableInterfaceDebug;
}

#pragma mark - private
- (AFHTTPRequestOperationManager *)manager{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/javascript"]];
    return manager;
}

- (ZQQRequestOperation *)getWithUrl:(NSString *)url
                            success:(ZQQResponseSuccess)success
                              faile:(ZQQResponseFaile)faile{
    return [self getWithUrl:url params:nil success:success faile:faile];
}

- (ZQQRequestOperation *)getWithUrl:(NSString *)url
                             params:(NSDictionary *)params
                            success:(ZQQResponseSuccess)success
                              faile:(ZQQResponseFaile)faile{
    
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    AFHTTPRequestOperationManager *manager = [self manager];
    
    AFHTTPRequestOperation *operation = [manager GET:url parameters:params
                                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                 if (success) {
                                                     success(responseObject);
                                                 }
                                                 //开启打印
                                                 if([self isDebug]){
                                                  [self logWithSuccessResponse:responseObject url:operation.response.URL.absoluteString params:params];
                                                 }
                                             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                 if (faile) {
                                                     faile(error);
                                                 }
                                                 //开启打印
                                                 if([self isDebug]){
                                                   [self logWithFaileError:error url:operation.response.URL.absoluteString params:params];
                                                 }
                                             }];
    
    return operation;
}

- (ZQQRequestOperation *)postWithUrl:(NSString *)url
                              params:(NSDictionary *)params
                             success:(ZQQResponseSuccess)success
                               faile:(ZQQResponseFaile)faile{
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [self manager];
    
    AFHTTPRequestOperation *operation = [manager POST:url
                                           parameters:params
                                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                  if (success) {
                                                      success(responseObject);
                                                  }
                                                  //开启打印
                                                  if([self isDebug]){
                                                      [self logWithSuccessResponse:responseObject url:operation.response.URL.absoluteString params:params];
   
                                                  }
                                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                  if (faile) {
                                                      faile(error);
                                                  }
                                                  //开启打印
                                                  if([self isDebug]){
                                                      [self logWithFaileError:error url:operation.response.URL.absoluteString params:params];
                                                  }
                                              }];
    return operation;
}

- (ZQQRequestOperation *)uploadWithImage:(UIImage *)image
                                     url:(NSString *)url
                                filename:(NSString *)filename
                                    name:(NSString *)name
                                 success:(ZQQResponseSuccess)success
                                   faile:(ZQQResponseFaile)faile{
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperationManager *manager = [self manager];
    
    AFHTTPRequestOperation *operation  = [manager POST:url
                                            parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                                NSData *imageData = UIImageJPEGRepresentation(image, 1);
                                                
                                                NSString *imageFileName = filename;
                                                if (filename == nil || ![filename isKindOfClass:[NSString class]] || filename.length == 0) {
                                                    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                                                    formatter.dateFormat = @"yyyyMMddHHmmss";
                                                    NSString *str = [formatter stringFromDate:[NSDate date]];
                                                    imageFileName = [NSString stringWithFormat:@"%@.jpg", str];
                                                }
                                                
                                                [formData appendPartWithFileData:imageData name:name fileName:imageFileName mimeType:@"image/jpeg"];
                                                
                                            } success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                
                                                if (success) {
                                                    success(responseObject);
                                                }
                                                
                                                //开启打印
                                                if([self isDebug]){
                                                [self logWithSuccessResponse:responseObject url:operation.response.URL.absoluteString params:nil];
                                                }
                                                
                                            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                if (faile) {
                                                    faile(error);
                                                }
                                                
                                                //开启打印
                                                if([self isDebug]){
                                                    [self logWithFaileError:error url:operation.response.URL.absoluteString params:nil];
   
                                                }
                                            }];
    
    return operation;
}

- (void)logWithSuccessResponse:(id)response url:(NSString *)url params:(NSDictionary *)params{
    ZQQAppLog(@"\nabsoluteUrl: %@\n params:%@\n response:%@\n\n",
              url,
              params,
              response);
}

- (void)logWithFaileError:(NSError *)error url:(NSString *)url params:(NSDictionary *)params{
    ZQQAppLog(@"\nabsoluteUrl: %@\n params:%@\n errorInfos:%@\n\n",
              url,
              params,
              [error localizedDescription]);
}

@end
