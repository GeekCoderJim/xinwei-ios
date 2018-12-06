//
//  YhbPageControl.m
//  ShangCheng
//
//  Created by 尤鸿斌 on 2017/11/18.
//  Copyright © 2017年 HongBin You. All rights reserved.
//

#import "YhbPageControl.h"

#define dotW 10
#define magrin 3

@implementation YhbPageControl
- (void)layoutSubviews{
        [super layoutSubviews];
        
        //计算圆点间距
        CGFloat marginX =   dotW + magrin;
        
        //计算整个pageControll的宽度
        CGFloat newW = (self.subviews.count - 1 ) * marginX;
        
        //设置新frame
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newW, 10);
        
        //设置居中
        CGPoint center = self.center;
        center.x = self.superview.center.x;
        self.center = center;
    
        //遍历subview,设置圆点frame
        for (int i=0; i<[self.subviews count]; i++) {
            UIImageView* dot = [self.subviews objectAtIndex:i];
            
            if (i == self.currentPage) {
                [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW,  2)];
            }else {
                [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW,  2)];
            }
        }
}
- (void)layoutSubviews1{
    [super layoutSubviews];
    
    //计算圆点间距
    CGFloat marginX =   dotW + magrin;
    
    //计算整个pageControll的宽度
    CGFloat newW = (self.subviews.count - 1 ) * marginX;
    
    //设置新frame
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newW, 10);
    
    //设置居中
    CGPoint center = self.center;
    center.x = self.superview.center.x;
    self.center = center;
    
    //遍历subview,设置圆点frame
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        
        if (i == self.currentPage) {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW,  2)];
        }else {
            [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW,  2)];
        }
    }
}
@end
