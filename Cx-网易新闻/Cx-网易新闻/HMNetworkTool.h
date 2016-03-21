//
//  HMNetworkTool.h
//  Cx-网易新闻
//
//  Created by 柴轩的macbook on 16/3/13.
//  Copyright © 2016年 柴轩的macbook. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface HMNetworkTool : AFHTTPSessionManager

+(instancetype)sharedNetworkTool;
@end
