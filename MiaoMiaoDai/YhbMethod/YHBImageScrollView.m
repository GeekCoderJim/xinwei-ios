//
//  ZKImgRunLoopView.m
//  temp
//
//  Created by 朱凯 on 16/6/15.
//  Copyright © 2016年 朱凯. All rights reserved.
//

#import "YHBImageScrollView.h"
#import "UIImageView+WebCache.h"


@implementation YHBImageScrollView
#pragma mark -- 初始化
- (instancetype)initWithFrame:(CGRect)frame placeholderImg:(UIImage *)img{
    if (self = [super init]) {
        self.frame = frame;
        if (img) {
            self.placeholderImg = img;
        }
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl1];
    }
    return self;
}
#pragma mark -- 代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    BOOL isRight = self.oldContentOffsetX < point.x;
    self.oldContentOffsetX = point.x;
    // 开始显示最后一张图片的时候切换到第二个图
    if (point.x > self.frame.size.width*(self.imgCount-2)+self.frame.size.width*0.5 && !self.timer1) {
        self.pageControl1.currentPage = 0;
    }else if (point.x > self.frame.size.width*(self.imgCount-2) && self.timer1 && isRight){
        self.pageControl1.currentPage = 0;
    }else{
        self.pageControl1.currentPage = (point.x + self.frame.size.width*0.5) / self.frame.size.width;
    }
    // 开始显示第一张图片的时候切换到倒数第二个图
    if (point.x >= self.frame.size.width*(self.imgCount-1)) {
        [_scrollView setContentOffset:CGPointMake(self.frame.size.width+point.x-self.frame.size.width*self.imgCount, 0) animated:NO];
    }else if (point.x < 0) {
        [scrollView setContentOffset:CGPointMake(point.x+self.frame.size.width*(self.imgCount-1), 0) animated:NO];
    }
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}
#pragma mark -- 定时器
- (void)startTimer
{
    self.timer1 = [NSTimer timerWithTimeInterval:4.0f target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer1 forMode:NSRunLoopCommonModes];
}
- (void)nextPage
{
    [self.scrollView setContentOffset:CGPointMake((self.pageControl1.currentPage+1)*self.frame.size.width, 0) animated:YES];
}
- (void)stopTimer
{
    [self.timer1 invalidate];
    self.timer1 = nil;
}
#pragma mark -- 模型初始化
- (void)setImgArray:(NSArray *)imgArray{
    [(NSMutableArray *)imgArray addObject:imgArray[0]];
    _imgArray = imgArray;
    self.imgCount = imgArray.count;
    for (int i=0; i<imgArray.count; i++) {
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.image = [UIImage imageNamed:imgArray[i]];
        imgView.frame = CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        [self.scrollView addSubview:imgView];
    }
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width*imgArray.count, 0);
    self.pageControl1.numberOfPages = imgArray.count-1;
    [self addImgClick];
    [self startTimer];
}
- (void)setImgUrlArray:(NSMutableArray *)imgUrlArray{
    if (imgUrlArray.count!=0) {
        [(NSMutableArray *)imgUrlArray addObject:imgUrlArray[0]];
    }
    _imgUrlArray = imgUrlArray;
    self.imgCount = imgUrlArray.count;
    for (int i=0; i<imgUrlArray.count; i++) {
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.contentMode=UIViewContentModeScaleAspectFill;
        imgView.clipsToBounds=YES;
        NSURL *imgUrl = [NSURL URLWithString:imgUrlArray[i]];
        [imgView sd_setImageWithURL:imgUrl placeholderImage:self.placeholderImg];
        imgView.frame = CGRectMake(i*self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
        [self.scrollView addSubview:imgView];
    }
    self.scrollView.contentSize = CGSizeMake(self.frame.size.width*imgUrlArray.count, 0);
    self.pageControl1.numberOfPages = imgUrlArray.count-1;
    [self addImgClick];
    [self startTimer];
}
#pragma mark -- 点击图片
-(void)touchImageIndexBlock:(void (^)(NSInteger))block{
    __block YHBImageScrollView *men = self;
    self.block = ^(){
        if (block) {
            block((men.pageControl1.currentPage));
        }
    };
}
- (void)addImgClick{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick)];
    [self.scrollView addGestureRecognizer:tap];
}
- (void)imgClick{
    if (self.block) {
        self.block();
    }
}
#pragma mark -- 懒加载
- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.contentOffset = CGPointMake(0, 0);
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        self.imgIndexOf = 1;
        _scrollView.delegate = self;
    }
    return _scrollView;
}
- (UIPageControl *)pageControl1{
    if (!_pageControl1) {
        CGRect rect = CGRectMake(0, self.frame.size.height-13, self.frame.size.width, 4);
        _pageControl1 = [[UIPageControl alloc] initWithFrame:rect];
//        [_pageControl layoutSubviews1];
        _pageControl1.currentPage = 0;
//        [_pageControl setValue:[UIImage imageNamed:@"an"] forKeyPath:@"pageImage"];
//        [_pageControl setValue:[UIImage imageNamed:@"liang"] forKeyPath:@"currentPageImage"];
        //        self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        //        self.pageControl.pageIndicatorTintColor = [UIColor blueColor];
    }
    return _pageControl1;
}
@end

