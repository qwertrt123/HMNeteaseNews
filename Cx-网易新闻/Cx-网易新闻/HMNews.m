//
//  HMNews.m
//  Cx-网易新闻
//
//  Created by 柴轩的macbook on 16/3/14.
//  Copyright © 2016年 柴轩的macbook. All rights reserved.
//

#import "HMNews.h"
#import "HMNetworkTool.h"

@implementation HMNews

+ (instancetype)newsWithDict:(NSDictionary *)dict{
    
    id obj=[[self alloc]init];
    
    [obj setValuesForKeysWithDictionary:dict];
    
    return obj;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

+(void)loadNewsSuccess:(void(^)(NSArray *news))success failed:(void(^)(NSError *error))failed{
    NSAssert(success!=nil, @"必须传入成功回调");
//    NSLog(@"%@",success);
    [[HMNetworkTool sharedNetworkTool] GET:@"article/headline/T1348647853363/0-20.html" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  responseObject) {
        
        NSLog(@"%@",responseObject);
        //获得字典的第一个key
        NSString *rootKey=responseObject.keyEnumerator.nextObject;
        //根据Key获得数组
        NSArray *news=responseObject[rootKey];
        //遍历数组
        //创建目标数组
        NSMutableArray *desArr=[NSMutableArray arrayWithCapacity:news.count];
        [news enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //创建模型
            HMNews *model=[HMNews newsWithDict:obj];
            //将模型添加到数组中
            [desArr addObject:model];
        }];
        
        success(desArr.copy);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failed) {
            failed(error);
        }
    }];
    
}

@end
