//
//  YHBImageScrollView.h
//  SuperMarket
//
//  Created by 尤鸿斌 on 2017/12/8.
//  Copyright © 2017年 HongBin You. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHBImageScrollView : UIView<UIScrollViewDelegate>
{
    int page;
}
/** 外面加层UIView*/
@property (nonatomic,strong) UIView *divView;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) UIPageControl *pageControl1;
/** 当前图片索引*/
@property (nonatomic,assign) NSInteger imgIndexOf;
/** 定时器*/
@property (nonatomic,strong) NSTimer *timer1;
/** 回调block*/
@property (nonatomic,copy) void (^block)();
@property (nonatomic,strong) UIImage *placeholderImg;
@property (nonatomic,assign) float oldContentOffsetX;
@property (nonatomic,assign) NSInteger imgCount;
/** 本地图片数组*/
@property (nonatomic,strong) NSArray *imgArray;
/** 网络图片数组*/
@property (nonatomic,strong) NSArray *imgUrlArray;
/** 图片点击调用*/
- (void)touchImageIndexBlock:(void (^)(NSInteger index))block;

- (instancetype)initWithFrame:(CGRect)frame placeholderImg:(UIImage *)img;
@end
