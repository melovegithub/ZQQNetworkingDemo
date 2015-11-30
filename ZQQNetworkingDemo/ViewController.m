//
//  ViewController.m
//  ZQQNetworkingDemo
//
//  Created by zqq on 15/11/30.
//  Copyright © 2015年 zqq. All rights reserved.
//

#import "ViewController.h"
#import "ZQQNetWorkingManager.h"
#import "ZQQNetWorking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //开启打印
    [[ZQQNetWorking sharedManager] enableInterfaceDebug:YES];
    
    NSString *getUrl = @"http://apistore.baidu.com/microservice/cityinfo?cityname=北京";
    
    //测试GET请求
    [[ZQQNetWorkingManager sharedManager] getWithUrl:getUrl success:^(id response) {
        
    } faile:^(NSError *error) {
        
    }];
    
    NSString *postUrl = @"http://data.zz.baidu.com/urls?site=www.henishuo.com&token=bRidefmXoNxIi3Jp";
    NSDictionary *postDict = @{ @"urls": @[@"http://www.henishuo.com/git-use-inwork/",
                                           @"http://www.henishuo.com/ios-open-source-hybloopscrollview/"]
                                };
    //测试POST请求
    [[ZQQNetWorkingManager sharedManager] postWithUrl:postUrl
                                               params:postDict
                                              success:^(id response) {
                                                  
                                              } faile:^(NSError *error) {
                                                  
                                              }];
}

@end
