//
//  HMLoopFlowLayOut.m
//  Cx-网易新闻
//
//  Created by 柴轩的macbook on 16/3/13.
//  Copyright © 2016年 柴轩的macbook. All rights reserved.
//

#import "HMLoopFlowLayOut.h"

@implementation HMLoopFlowLayOut

//在执行该方法前,collectionView尺寸已经确定
-(void)prepareLayout{
    
    [super prepareLayout];
   
    //设置item的尺寸
    self.itemSize=self.collectionView.bounds.size;
    self.minimumInteritemSpacing=0;
    self.minimumLineSpacing=0;
    //设置分页效果
    self.collectionView.pagingEnabled=YES;
    //设置滚动方向
    self.scrollDirection=UICollectionViewScrollDirectionHorizontal;
    //隐藏水平滚动条
    self.collectionView.showsHorizontalScrollIndicator=NO;
    
    
    
}

@end
