//
//  HMNewsController.m
//  Cx-网易新闻
//
//  Created by 柴轩的macbook on 16/3/14.
//  Copyright © 2016年 柴轩的macbook. All rights reserved.
//

#import "HMNewsController.h"
#import "HMNews.h"
#import "HMNewsCell.h"

@interface HMNewsController ()
//所有新闻数据
@property (nonatomic, strong)NSArray *news;
@end

@implementation HMNewsController

-(BOOL)prefersStatusBarHidden{
    
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [HMNews loadNewsSuccess:^(NSArray *news) {
        
        self.news=news;
        
        [self.tableView reloadData];
    
    } failed:^(NSError *error) {
        
        NSLog(@"%@",error);
    }];
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.news.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //获取重用标示
    NSString *ID=[HMNewsCell cellIDWithNews:self.news[indexPath.row]];
    
    HMNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ID    forIndexPath:indexPath];
    cell.news=self.news[indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获得模型
    HMNews *news=self.news[indexPath.row];
    
    return [HMNewsCell cellHeightWithNews:news];
}


@end
