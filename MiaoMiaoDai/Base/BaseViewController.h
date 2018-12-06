//
//  BaseViewController.h
//  zlydoc-iphone
//
//  Created by Ryan on 14-5-23.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BaseViewController : UIViewController
@property(strong,nonatomic)UserEntity *userEntity;
@property(assign,nonatomic)int requestCount;
@property(strong,nonatomic)UIView *nothingView;
@property(strong,nonatomic)UILabel *noticeLabel;
@end
