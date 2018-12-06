//
//  SettingViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/3/3.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "SettingViewController.h"
#import "PasswordViewController.h"


@interface SettingViewController ()

@property(strong,nonatomic)UITableView *tableview;


@end

@implementation SettingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"个人设置";
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor=[UIColor whiteColor];
    [btn setTitle:@"账号安全" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font=Font(AUTO(16));
    btn.frame=Frame(0, 0, ScreenWidth, AUTO(50));
    [btn addTarget:self action:@selector(zhaq) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
//    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
//    btn2.backgroundColor=[UIColor whiteColor];
//    [btn2 setTitle:@"检查更新" forState:UIControlStateNormal];
//    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    btn2.titleLabel.font=Font(AUTO(16));
//    btn2.frame=Frame(0, AUTO(51), ScreenWidth, AUTO(50));
//    [self.view addSubview:btn2];
//    [btn2 addTarget:self action:@selector(update) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *addButton=[UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame=Frame(AUTO(20), AUTO(150), ScreenWidth-AUTO(40), AUTO(50));
    [addButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.titleLabel.font=Font(AUTO(16));
    addButton.backgroundColor=[YhbMethods colorWithHexString:COLOR_BIG_BUTTON];
    [YhbMethods setView:addButton CornerRadius:AUTO(5) AndMasks:YES];
    [addButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
}
-(void)update{
    [AppUtils showTipsMessage:@"已是最新版本"];
}

-(void)next{
    [YhbMethods setBoolUserDefaults:NO andKey:@"isLogin"];
    [YhbMethods removeUserDefault:@"account"];
    [YhbMethods removeUserDefault:@"password"];
    [YhbMethods removeUserDefault:@"userInfo"];
    LoginViewController *vc=[LoginViewController new];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
    nav.navigationBar.translucent=NO;
    nav.navigationBar.barTintColor=[YhbMethods colorWithHexString:COLOR_MAIN];
    nav.navigationBar.tintColor=[UIColor whiteColor];
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [[UIApplication sharedApplication]keyWindow].rootViewController=nav;
}
-(void)zhaq{
    [self.navigationController pushViewController:[PasswordViewController new] animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
