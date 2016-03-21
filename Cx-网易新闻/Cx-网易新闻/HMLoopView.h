//
//  HMLoopView.h
//  Cx-网易新闻
//
//  Created by 柴轩的macbook on 16/3/13.
//  Copyright © 2016年 柴轩的macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMLoopView : UIView
//创建图片轮播器
-(instancetype)initWithURLStr:(NSArray <NSString *> *)URLStr titles:(NSArray <NSString *>*)titles  didSelect:(void(^)(NSInteger index))didSelect;
@end
