//
//  HMLoopCell.m
//  Cx-网易新闻
//
//  Created by 柴轩的macbook on 16/3/13.
//  Copyright © 2016年 柴轩的macbook. All rights reserved.
//

#import "HMLoopCell.h"
#import <UIImageView+WebCache.h>

@interface HMLoopCell ()
@property (nonatomic, strong) UIImageView *iconView;
@end

@implementation HMLoopCell

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        
        self.iconView=[[UIImageView alloc]init];
        [self.contentView addSubview:self.iconView];
    }
    return self;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    self.iconView.frame=self.bounds;
}

-(void)setURLStr:(NSString *)URLStr{
    
    _URLStr=URLStr;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:URLStr]];
    
}
@end
