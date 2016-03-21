//
//  HMNewsCell.h
//  Cx-网易新闻
//
//  Created by 柴轩的macbook on 16/3/14.
//  Copyright © 2016年 柴轩的macbook. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HMNews;

@interface HMNewsCell : UITableViewCell

@property (nonatomic, strong) HMNews *news;

+(NSString *)cellIDWithNews:(HMNews *)news;

//返回cell的高度
+(CGFloat)cellHeightWithNews:(HMNews *)news;
@end
