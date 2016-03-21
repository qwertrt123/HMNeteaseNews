//
//  HMNewsCell.m
//  Cx-网易新闻
//
//  Created by 柴轩的macbook on 16/3/14.
//  Copyright © 2016年 柴轩的macbook. All rights reserved.
//

#import "HMNewsCell.h"
#import "HMNews.h"
#import <UIImageView+WebCache.h>

@interface HMNewsCell ()
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  摘要
 */
@property (weak, nonatomic) IBOutlet UILabel *digestLabel;
/**
 *  跟帖数
 */
@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;
/**
 *  多张图片
 */
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imgextra;



@end

@implementation HMNewsCell

-(void)setNews:(HMNews *)news{
    _news=news;
    self.titleLabel.text=news.title;
    self.digestLabel.text=news.digest;
    self.replyCountLabel.text=[NSString stringWithFormat:@"%zd人跟帖",[news.replyCount intValue]];
    //设置图片
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:news.imgsrc]];
    //设置多张图片
    [news.imgextra enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull imgDict, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIImageView *imageView=self.imgextra[idx];
        [imageView setBackgroundColor:[UIColor redColor]];
        //获得图片URLstring
        NSString *URLstring=imgDict[@"imgsrc"];
        [imageView sd_setImageWithURL:[NSURL URLWithString:URLstring]];
        
    }];
}

+(NSString *)cellIDWithNews:(HMNews *)news{
    NSString *ID=@"cell";
    if (news.imgType) {
        
        ID=@"bigCell";
    }else if (news.imgextra){
        
        ID=@"threeCell";
    }
    return ID;
}

+(CGFloat)cellHeightWithNews:(HMNews *)news{
    
    CGFloat height=80;
    if (news.imgType) {
        
        height=170;
    }else if (news.imgextra){
        
        height=130;
    }
    return height;
}

@end
