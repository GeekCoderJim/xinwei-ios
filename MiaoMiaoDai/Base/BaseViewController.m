//
//  BaseViewController.m
//  zlydoc-iphone
//  Parent View Controller
//  Created by Ryan on 14-5-23.
//  Copyright (c) 2014年 zlycare. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()
@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    //设置状态栏字体颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.userEntity = [UserEntity shareUserEntity];

    self.nothingView=[[UIView alloc]initWithFrame:Frame(0, 0, ScreenWidth, ScreenHeight/2)];
    _nothingView.hidden=YES;
    
    UIImageView *image=[[UIImageView alloc]initWithImage:Image(@"noRecord_Default")];
    image.frame=Frame(0, 0, image.image.size.width, image.image.size.height);
    image.center=CGPointMake(_nothingView.center.x, AUTO(120));
    image.tag=100001;
    [_nothingView addSubview:image];
    
    self.noticeLabel=[UILabel new];
    _noticeLabel.textColor=[UIColor darkGrayColor];
    _noticeLabel.textAlignment=NSTextAlignmentCenter;
    _noticeLabel.font=[UIFont boldSystemFontOfSize:AUTO(16)];
    [_nothingView addSubview:_noticeLabel];
    _noticeLabel.sd_layout.topSpaceToView(image, AUTO(15)).leftEqualToView(_nothingView).rightEqualToView(_nothingView).autoHeightRatio(0);
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
