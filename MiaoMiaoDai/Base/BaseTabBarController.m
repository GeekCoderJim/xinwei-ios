//
//  BaseTabBarController.m
//  SuXunTong
//
//  Created by JoheZjq on 15/8/11.
//  Copyright (c) 2015年 scan. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseNavigationController.h"
#import "HomeViewController.h"
#import "RZViewController.h"
#import "QuickPayViewController.h"
#import "MineViewController.h"
#import "JTViewController.h"

#define ScreenWidth [[UIScreen mainScreen] bounds].size.width
@interface BaseTabBarController ()

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.translucent=NO;
    

    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[YhbMethods colorWithHexString:@"#7d7d7d"],
                                                        NSFontAttributeName:[UIFont systemFontOfSize:AUTO(11)]} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[YhbMethods colorWithHexString:@"#ca261e"],
                                                        NSFontAttributeName:[UIFont systemFontOfSize:AUTO(11)]} forState:UIControlStateSelected];


    HomeViewController *home = [[HomeViewController alloc]init];
    BaseNavigationController *MainNav = [self setTabBarWithVC:home andTitle:@"借款" andNormalImage:Image(@"money_off") andSelectedImage:Image(@"money_on")];
//    MainNav.navigationBar.hidden=YES;
    [MainNav.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:0];
    MainNav.tabBarItem.title = @"借款";
    
    
//    QuickPayViewController *quickpay=[QuickPayViewController new];
//    BaseNavigationController *quickNav = [self setTabBarWithVC:quickpay andTitle:@"快捷收款" andNormalImage:Image(@"quick_off") andSelectedImage:Image(@"quick_on")];
//    quickNav.navigationBar.barTintColor=[UIColor colorWithRed:0.8 green:0.1 blue:0.1 alpha:1];
    
    JTViewController *jt=[JTViewController new];
    BaseNavigationController *jtNav = [self setTabBarWithVC:jt andTitle:@"借条" andNormalImage:Image(@"借条_2") andSelectedImage:Image(@"借条_1")];

    RZViewController *group = [[RZViewController alloc]init];
    BaseNavigationController *groupNav= [[BaseNavigationController alloc]init];
    groupNav=[self setTabBarWithVC:group andTitle:@"认证" andNormalImage:Image(@"verify_off") andSelectedImage:Image(@"verify_on")];

    MineViewController *more = [[MineViewController alloc]init];
    BaseNavigationController *moreNav = [[BaseNavigationController alloc]init];
    moreNav=[self setTabBarWithVC:more andTitle:@"我的" andNormalImage:Image(@"my_off") andSelectedImage:Image(@"my_on")];
    moreNav.navigationBar.hidden=YES;
//
    self.viewControllers = [NSArray arrayWithObjects:MainNav,jtNav,groupNav,moreNav, nil];
    if (isAppStore) {
        self.viewControllers = [NSArray arrayWithObjects:groupNav,moreNav, nil];
    }



    UITabBarItem *tab=[UITabBarItem appearance];
    

    //选中前字体和颜色
    NSMutableDictionary *norlDic=@{}.mutableCopy;
    norlDic[NSFontAttributeName]=[UIFont systemFontOfSize:10];
    norlDic[NSForegroundColorAttributeName]=[UIColor colorWithRed:0.3 green:0.36 blue:0.44 alpha:1];
    [tab setTitleTextAttributes:norlDic forState:UIControlStateDisabled];

    //选中后字体和颜色
    NSMutableDictionary *selectedDic=@{}.mutableCopy;
    selectedDic[NSFontAttributeName]=[UIFont systemFontOfSize:10];
    selectedDic[NSForegroundColorAttributeName]=[YhbMethods colorWithHexString:@"#1298FE"];
    [tab setTitleTextAttributes:selectedDic forState:UIControlStateSelected];

}
-(BaseNavigationController *)setTabBarWithVC:(UIViewController *)vc
                                    andTitle:(NSString *)title
                              andNormalImage:(UIImage *)n_image
                            andSelectedImage:(UIImage *)s_image
{
    BaseNavigationController *nav=[[BaseNavigationController alloc]initWithRootViewController:vc];
    nav.navigationBar.translucent=NO;
    nav.navigationBar.barTintColor=[YhbMethods colorWithHexString:COLOR_MAIN];
    nav.navigationBar.backgroundColor=[YhbMethods colorWithHexString:COLOR_MAIN];
    nav.navigationBar.tintColor=[UIColor whiteColor];
    nav.navigationBar.shadowImage=[UIImage new];
    nav.tabBarItem.title=title;
    vc.title=title;
    vc.tabBarItem.image=[n_image  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage=[s_image  imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    // 3.设置导航栏标题颜色为自定义颜色
    [nav.navigationBar setTitleTextAttributes:@{
                                                
                                                NSForegroundColorAttributeName : [UIColor whiteColor]
                                                
                                                }];
    
    return nav;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
