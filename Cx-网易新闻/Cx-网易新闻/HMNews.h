//
//  HMNews.h
//  Cx-网易新闻
//
//  Created by 柴轩的macbook on 16/3/14.
//  Copyright © 2016年 柴轩的macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMNews : NSObject
/**
 *  新闻标题
 */
@property (nonatomic, copy) NSString *title;
/**
 *  新闻摘要
 */
@property (nonatomic, copy) NSString *digest;
/**
 *  新闻图片
 */
@property (nonatomic, copy) NSString *imgsrc;
/**
 *  跟帖数
 */
@property (nonatomic, strong) NSNumber *replyCount;
/**
 *  多张图片
 */
@property (nonatomic, strong) NSArray *imgextra;
/**
 *  是否是大图
 */
@property (nonatomic, assign) BOOL imgType;

+ (instancetype)newsWithDict:(NSDictionary *)dict;

+(void)loadNewsSuccess:(void(^)(NSArray *news))success failed:(void(^)(NSError *error))failed;
@end
