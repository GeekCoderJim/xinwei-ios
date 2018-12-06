//
//  BaseNavigationController.m
//  SuXunTong
//
//  Created by JoheZjq on 15/8/11.
//  Copyright (c) 2015年 scan. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0) { // 判断是否是IOS7
//        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackTranslucent animated:NO];
//    }
    // Do any additional setup after loading the view.
    self.navigationBar.translucent=NO;
}

#pragma mark 一个类只会调用一次
+ (void)initialize
{
    
    // 1.取出设置主题的对象
    UINavigationBar *navBar = [UINavigationBar appearance];
//    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    
    
    if ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0) { // 判断是否是IOS7
        navBar.tintColor = [UIColor colorWithRed:58/255.0 green:58/255.0 blue:58/255.0 alpha:1];
    }
    
    [navBar setBackgroundImage:[UIImage imageNamed:@""] forBarMetrics:UIBarMetricsDefault];
    
    // 3.设置导航栏标题颜色为自定义颜色
    [navBar setTitleTextAttributes:@{
                                     
                                     NSForegroundColorAttributeName : [UIColor blackColor]
                                     }];

    // 4.设置导航栏按钮文字颜色为白色
//    [barItem setTitleTextAttributes:@{
//                                      NSForegroundColorAttributeName : [UIColor blackColor],
//                                      //                                      UITextAttributeFont : [UIFont systemFontOfSize:13]
//                                      NSFontAttributeName:[UIFont systemFontOfSize:14]
//                                      } forState:UIControlStateNormal];
   // [[UINavigationBar appearance] setTintColor:[UIColor redColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//push的时候判断到子控制器的数量。当大于零时隐藏BottomBar 也就是UITabBarController 的tababar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //隐藏返回标题
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:0 target:nil action:nil];
    


    [viewController.navigationItem setBackBarButtonItem:backItem];
    if(self.viewControllers.count>0){
        viewController.hidesBottomBarWhenPushed = YES;
    }
   
    [super pushViewController:viewController animated:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
