//
//  UINavigationController+NavAlpha.m
//  SuXunTong
//
//  Created by 尤鸿斌 on 2017/11/16.
//  Copyright © 2017年 scan. All rights reserved.
//

#import "UINavigationController+NavAlpha.h"


@implementation UINavigationController (NavAlpha)

- (void)setNeedsNavigationBackground:(CGFloat)alpha {
    // 导航栏背景透明度设置
    UIView *barBackgroundView = [[self.navigationBar subviews] objectAtIndex:0];// _UIBarBackground
    UIImageView *backgroundImageView = [[barBackgroundView subviews] objectAtIndex:0];// UIImageView
    if (self.navigationBar.isTranslucent) {
        if (backgroundImageView != nil && backgroundImageView.image != nil) {
            barBackgroundView.alpha = alpha;
        } else {
            UIView *backgroundEffectView = [[barBackgroundView subviews] objectAtIndex:1];// UIVisualEffectView
            if (backgroundEffectView != nil) {
                backgroundEffectView.alpha = alpha;
            }
        }
    } else {
        barBackgroundView.alpha = alpha;
    }
//    self.navigationBar.barTintColor=[UIColor whiteColor];
//    // 对导航栏下面那条线做处理
//    self.navigationBar.clipsToBounds = alpha;
}
@end
