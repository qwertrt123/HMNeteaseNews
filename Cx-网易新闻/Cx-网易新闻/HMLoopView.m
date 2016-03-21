//
//  HMLoopView.m
//  Cx-网易新闻
//
//  Created by 柴轩的macbook on 16/3/13.
//  Copyright © 2016年 柴轩的macbook. All rights reserved.
//

#import "HMLoopView.h"
#import "HMLoopFlowLayOut.h"
#import "HMLoopCell.h"
#import "HMWeakTimerTarget.h"

@interface HMLoopView  ()<UICollectionViewDataSource,UICollectionViewDelegate>
//标题
@property (nonatomic, strong) UILabel *titleLabel;
//分页
@property (nonatomic, strong) UIPageControl *pageControl;
//collectionView
@property (nonatomic, strong) UICollectionView *collectionView;
//URL
@property (nonatomic, strong) NSArray *URLStr;

@property (nonatomic, strong) NSArray *titles;
//定时器
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation HMLoopView

-(instancetype)initWithURLStr:(NSArray <NSString *> *)URLStr titles:(NSArray <NSString *>*)titles didSelect:(void(^)(NSInteger index))didSelect{
    
    if (self=[super init]) {
        
        //记录属性
        self.URLStr=URLStr;
        self.titles=titles;
        //设置页数
        self.pageControl.numberOfPages=URLStr.count;
        self.titleLabel.text=self.titles[0];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (URLStr.count>1) {
                
                [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.URLStr.count inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
                //添加定时器
                [self addTimer];
            }
        });
    }
    return self;
}
//添加定时器
-(void)addTimer{
    
    self.timer=[HMWeakTimerTarget scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    //添加到运行循环中
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
//移除定时器
-(void)remove{
    
    [self.timer invalidate];
    self.timer=nil;
}
//下一张图片
-(void)nextImage{
    
    //获得当前的页号
    NSInteger count=self.collectionView.contentOffset.x/self.frame.size.width;
    //设置偏移量
    NSInteger offset= (count+1)*self.frame.size.width;
    
    [self.collectionView setContentOffset:CGPointMake(offset, 0) animated:YES];
}
//初始化
-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self=[super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self=[super initWithCoder:aDecoder]) {
        
        [self setup];
    }
    return self;
}

-(void)setup{
    //创建collectionView
    UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:[[HMLoopFlowLayOut alloc]init]];
    //注册cell
    [collectionView registerClass:[HMLoopCell class] forCellWithReuseIdentifier:@"loop"];
    self.collectionView=collectionView;
    //设置代理和数据源
    collectionView.delegate=self;
    collectionView.dataSource=self;
    [self addSubview:collectionView];
    //设置标题
    self.titleLabel=[[UILabel alloc]init];
    //设置字体
    self.titleLabel.font=[UIFont systemFontOfSize:14];
    //设置颜色
    self.titleLabel.tintColor=[UIColor grayColor];
    [self addSubview:self.titleLabel];
    //创建分页指示器
    self.pageControl=[[UIPageControl alloc]init];
    self.pageControl.currentPageIndicatorTintColor=[UIColor redColor];
    self.pageControl.pageIndicatorTintColor=[UIColor grayColor];
    //如果只有一页,则隐藏分页指示器
    self.pageControl.hidesForSinglePage=YES;
    [self addSubview:self.pageControl];
    
}


-(void)layoutSubviews{
    [super layoutSubviews];
    //设置标题高度
    CGFloat titleH=30;
    //设置collectionView的frame
    CGRect frame=self.bounds;
    frame.size.height-=titleH;
    self.collectionView.frame=frame;
    
    CGFloat marginX=10;
    //设置pageController的frame
    CGFloat pageY=self.frame.size.height-titleH;
    CGFloat pageW=self.URLStr.count*15;
    CGFloat pageX=self.frame.size.width-pageW-marginX;
    CGFloat PageH=titleH;
    self.pageControl.frame=CGRectMake(pageX, pageY, pageW, PageH);
    
    //设置title的frame
    CGFloat titleX=marginX;
    CGFloat titleW=self.frame.size.width-3*marginX-pageW;
    self.titleLabel.frame=CGRectMake(titleX, pageY, titleW, PageH);
}

#pragma mark--UICollectionView数据源方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.URLStr.count*3;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HMLoopCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"loop" forIndexPath:indexPath];
    cell.URLStr=self.URLStr[indexPath.item%self.URLStr.count];
    
    return cell;
}

#pragma mark --UISCollView代理方法
//计算滚动的页号
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //计算当前滚动得距离
    NSInteger page=(scrollView.contentOffset.x/self.frame.size.width);
    if (page==0||page==[self.collectionView numberOfItemsInSection:0]-1) {
        
        page=self.URLStr.count-((page==0)?0:1);
        
        self.collectionView.contentOffset=CGPointMake(self.frame.size.width*page, 0);
    }
    //设置标题
    self.titleLabel.text=self.titles[page%self.titles.count];
    self.pageControl.currentPage=page%self.URLStr.count;
  
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndDecelerating:scrollView];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self remove];
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
    [self addTimer];
}
@end
