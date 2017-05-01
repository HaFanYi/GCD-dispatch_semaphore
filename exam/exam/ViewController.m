//
//  ViewController.m
//  exam
//
//  Created by watchman on 2017/5/1.
//  Copyright © 2017年 Hervey. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking/AFNetworking.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self request];
}


//测试请求
- (void)request {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self request1];
    }) ;
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self request2];
    }) ;
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self request3];
    }) ;
   dispatch_group_notify(group, dispatch_get_main_queue(), ^{
       NSLog(@"刷新界面");
   });
}

//真正的网络请求
- (void)request1{
    //创建信号量并设置计数默认为0
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"%s","http://v3.wufazhuce.com:8000/api/channel/movie/more/0?platform=ios&version=v4.0.1"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       //计数加1
        dispatch_semaphore_signal(semaphore);
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dic in data) {
            NSLog(@"请求1---%@",dic[@"id"]);
        }
         //11380-- data.lastObject[@"id"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //计数加1
        dispatch_semaphore_signal(semaphore);
    }];
    //若计数为0则一直等待
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}
- (void)request2{
    //创建信号量并设置计数默认为0
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *url1 = [NSString stringWithFormat:@"%s","http://v3.wufazhuce.com:8000/api/channel/movie/more/11380?platform=ios&version=v4.0.1"];
    [manager GET:url1 parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //计数加1
        dispatch_semaphore_signal(semaphore);
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dic in data) {
            NSLog(@"请求2---%@",dic[@"id"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //计数加1
        dispatch_semaphore_signal(semaphore);
    }];
    //若计数为0则一直等待
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}
- (void)request3{
    //创建信号量并设置计数默认为0
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString *url2 = [NSString stringWithFormat:@"%s","http://v3.wufazhuce.com:8000/api/channel/movie/more/11317?platform=ios&version=v4.0.1"];
    [manager GET:url2 parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //计数加1
        dispatch_semaphore_signal(semaphore);
        NSArray *data = responseObject[@"data"];
        for (NSDictionary *dic in data) {
            NSLog(@"请求3---%@",dic[@"id"]);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //计数加1
        dispatch_semaphore_signal(semaphore);
    }];
    //若计数为0则一直等待
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
