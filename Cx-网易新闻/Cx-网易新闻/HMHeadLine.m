//
//  HMHeadLine.m
//  Cx-网易新闻
//
//  Created by 柴轩的macbook on 16/3/13.
//  Copyright © 2016年 柴轩的macbook. All rights reserved.
//

#import "HMHeadLine.h"
#import "HMNetworkTool.h"

@implementation HMHeadLine


+ (instancetype)headLineWithDict:(NSDictionary *)dict{
    
    id obj=[[self alloc]init];
    
    [obj setValuesForKeysWithDictionary:dict];
    return obj;
}
//只要重写该方法,就不会出现找不到对应属性对应的可以崩溃的错误
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{}

+(void)loadHeadLineSuccess:(void(^)(NSArray *headLines))success failed:(void(^)(NSError *error))failed{
    //断言
    NSAssert(success!=nil, @"必须传入成功回调");
    [[HMNetworkTool sharedNetworkTool] GET:@"ad/headline/0-4.html" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
       
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary  * responseObject) {
//        NSLog(@"%@",responseObject);
        //获得字典的第一个key
        NSString *rootKey=responseObject.keyEnumerator.nextObject;
        //获得数组
        NSArray *headLines=responseObject[rootKey];
        //遍历数组
        //创建模型数组
        NSMutableArray *desArr=[NSMutableArray arrayWithCapacity:headLines.count];
        [headLines enumerateObjectsUsingBlock:^(NSDictionary*  obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //创建模型
            HMHeadLine *model=[HMHeadLine headLineWithDict:obj];
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
