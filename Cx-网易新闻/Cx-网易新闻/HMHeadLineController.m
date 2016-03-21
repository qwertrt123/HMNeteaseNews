//
//  HMHeadLineController.m
//  Cx-网易新闻
//
//  Created by 柴轩的macbook on 16/3/13.
//  Copyright © 2016年 柴轩的macbook. All rights reserved.
//

#import "HMHeadLineController.h"
#import "HMHeadLine.h"
#import "HMLoopView.h"

@interface HMHeadLineController ()

@end

@implementation HMHeadLineController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [HMHeadLine loadHeadLineSuccess:^(NSArray *headLines) {
        
        NSLog(@"%@",headLines);
        //创建图片轮播器
        HMLoopView *loopView=[[HMLoopView alloc]initWithURLStr:[headLines valueForKeyPath:@"imgsrc"] titles:[headLines valueForKeyPath:@"title"] didSelect:^(NSInteger index) {
            
        }];
        //设置frame
        loopView.frame=self.view.bounds;
        //添加到控制器上
        [self.view addSubview:loopView];
    } failed:^(NSError *error) {
        
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
