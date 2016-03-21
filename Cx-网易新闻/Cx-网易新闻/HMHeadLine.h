//
//  HMHeadLine.h
//  Cx-网易新闻
//
//  Created by 柴轩的macbook on 16/3/13.
//  Copyright © 2016年 柴轩的macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HMHeadLine : NSObject

@property (nonatomic, copy) NSString *imgsrc;

@property (nonatomic, copy) NSString *title;

+ (instancetype)headLineWithDict:(NSDictionary *)dict;

+(void)loadHeadLineSuccess:(void(^)(NSArray *headLines))success failed:(void(^)(NSError *error))failed;
@end
