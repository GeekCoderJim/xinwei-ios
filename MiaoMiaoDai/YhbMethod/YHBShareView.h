//
//  YHBShareView.h
//  SuperMarket
//
//  Created by 尤鸿斌 on 2018/1/9.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YHBShareView : UIView
{
   
}
@property(strong,nonatomic)UIView *black_bg_view;
@property(strong,nonatomic)UIView *shareView;
@property(strong,nonatomic)UIButton *cancelBtn; 
@property(strong,nonatomic)NSString *shareTitle,*shareDesc,*shareURL;
@property(strong,nonatomic)UIImage *shareImage;

-(instancetype)initWithFrame:(CGRect)frame;
+(void)showWithInfo:(NSDictionary *)showInfo;

@end
