//
//  HomeViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/2/28.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "HomeViewController.h"
#import "LoginViewController.h"
#import "HelpViewController.h"
#import "HomeRequest.h"
#import "BorrowMoneyViewController.h"
#import "MessageViewController.h"
#import "ListViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "PublicRequest.h"
#import "RZRequest.h"


#import "JTViewController.h"

@interface HomeViewController ()<CLLocationManagerDelegate,UIAlertViewDelegate>
@property(strong,nonatomic)UILabel *moneyLabel,*timeLabel;
@property(strong,nonatomic)UIButton *nextBtn;

@property (nonatomic,strong ) CLLocationManager *locationManager;//定位服务
@property (nonatomic,copy)    NSString *currentCity;//城市
@property (nonatomic,copy)    NSString *strLatitude;//经度
@property (nonatomic,copy)    NSString *strLongitude;//维度
@end

@implementation HomeViewController
-(void)viewWillAppear:(BOOL)animated{
    if ([YhbMethods readBOOLUserDefault:@"isLogin"]==YES) {
        [HomeRequest getUserLoanLinesWithPhone:self.userEntity.phoneNumber Success:^(id obj) {
            NSLog(@"%@",obj);
            _moneyLabel.text=[NSString stringWithFormat:@"%@",obj[@"validAmount"]];
        }];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupviews];
    
    [self locatemap];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(toLogin) name:@"loginFail" object:nil];
    
    if ([YhbMethods readBOOLUserDefault:@"isLogin"]==YES) {
        [HomeRequest getUserLoanLinesWithPhone:self.userEntity.phoneNumber Success:^(id obj) {
            NSLog(@"%@",obj);
            _moneyLabel.text=[NSString stringWithFormat:@"%@",obj[@"validAmount"]];
        }];
        [RZRequest getUserInfoSuccess:^(id obj) {
            NSDictionary *dic = [YhbMethods setDicNullClass:obj];
            NSString *name=dic[@"name"];
            if ([name isKindOfClass:[NSString class]]&&name.length>1) {
                self.userEntity.name = name;
                self.userEntity.idCard=dic[@"idCard"];
            }
        }];
    }
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:Image(@"icon_message") style:0 target:self action:@selector(ToMessageList)];
    
}
-(void)ToMessageList{
    MessageViewController *vc=[MessageViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)borrowMoney{
    if ([YhbMethods readBOOLUserDefault:@"isLogin"]==YES) {
        
        JTViewController *vc = [JTViewController new];
//        BorrowMoneyViewController *vc=[BorrowMoneyViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self toLogin];
    }
    
}
-(void)returnMoney{
    ListViewController *vc=[ListViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)toLogin{
    LoginViewController *vc=[LoginViewController new];
  
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
    nav.navigationBar.translucent=NO;
    nav.navigationBar.barTintColor=[YhbMethods colorWithHexString:COLOR_MAIN];
    nav.navigationBar.tintColor=[UIColor whiteColor];
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    [self presentViewController:nav animated:YES completion:nil];
}

-(void)toHelp{
    [self.navigationController pushViewController:[HelpViewController new] animated:YES];
}

#pragma mark --- location

- (void)locatemap{
    
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        [_locationManager requestAlwaysAuthorization];
        _currentCity = [[NSString alloc]init];
        [_locationManager requestWhenInUseAuthorization];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 5.0;
        [_locationManager startUpdatingLocation];
    }
}

#pragma mark - 定位失败
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    if ([YhbMethods readBOOLUserDefault:@"isLogin"]==YES) {
        NSMutableDictionary *param = [NSMutableDictionary new];
        NSString *deviceInfo = [NSString stringWithFormat:@"%@ %@",[YhbMethods getDeviceName],[YhbMethods getSystemVersion]];
        [param setValue:deviceInfo forKey:@"deviceInfo"];
        
        [PublicRequest uploadLocationInfoAndDeviceInfo:param];
    }
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"请在设置中打开定位" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"打开定位", nil];
    alert.tag=2000;
    [alert show];
}
#pragma mark - 定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    [_locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    CLGeocoder *geoCoder = [[CLGeocoder alloc]init];
    
    NSTimeInterval locationAge = -[currentLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 1.0){//如果调用已经一次，不再执行
        return;
    }
    //地理反编码 可以根据坐标(经纬度)确定位置信息(街道 门牌等)
    [geoCoder reverseGeocodeLocation:currentLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count >0) {
            CLPlacemark *placeMark = placemarks[0];
            _currentCity = placeMark.locality;
            if (!_currentCity) {
                _currentCity = @"无法定位当前城市";
            }
            
            NSString *message = [NSString stringWithFormat:@"%@%@%@%@%@",placeMark.country,_currentCity,placeMark.subLocality,placeMark.thoroughfare,placeMark.name];
            
            if ([YhbMethods readBOOLUserDefault:@"isLogin"]==YES) {
                NSMutableDictionary *param = [NSMutableDictionary new];
                [param setValue:[NSString stringWithFormat:@"%f",currentLocation.coordinate.latitude] forKey:@"latitude"];
                [param setValue:[NSString stringWithFormat:@"%f",currentLocation.coordinate.longitude] forKey:@"longitude"];
                [param setValue:message forKey:@"addrStr"];
                [param setValue:@"" forKey:@"description"];
                NSString *deviceInfo = [NSString stringWithFormat:@"%@ %@",[YhbMethods getDeviceName],[YhbMethods getSystemVersion]];
                [param setValue:deviceInfo forKey:@"deviceInfo"];
                
                [PublicRequest uploadLocationInfoAndDeviceInfo:param];
            }
            
        }else if (error == nil && placemarks.count){
            
            NSLog(@"NO location and error return");
        }else if (error){
            
            NSLog(@"loction error:%@",error);
        }
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
     if (alertView.tag==2000){
        if (buttonIndex==1) {
            NSURL *settingURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            [[UIApplication sharedApplication]openURL:settingURL];
        }
    }
    
}




-(void)setupviews{
    
    UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    scroll.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    self.view=scroll;
    
    UIView *topview=[[UIView alloc]initWithFrame:Frame(0, 0, ScreenWidth, AUTO(300))];
    topview.backgroundColor=[YhbMethods colorWithHexString:COLOR_MAIN];
    [scroll addSubview:topview];
    
    UIView *whiteRound=[[UIView alloc]init];
    whiteRound.backgroundColor=[UIColor whiteColor];
    [topview addSubview:whiteRound];
    whiteRound.sd_layout
    .centerXEqualToView(topview)
    .centerYEqualToView(topview)
    .widthIs(AUTO(250))
    .heightEqualToWidth();
    whiteRound.sd_cornerRadius=@(AUTO(125));
    
    UIView *blueRound=[[UIView alloc]init];
    blueRound.backgroundColor=topview.backgroundColor;
    [whiteRound addSubview:blueRound];
    blueRound.sd_layout
    .centerXEqualToView(whiteRound)
    .centerYEqualToView(whiteRound)
    .widthIs(AUTO(240))
    .heightEqualToWidth();
    blueRound.sd_cornerRadius=@(AUTO(120));
    
    //
    self.moneyLabel=[UILabel new];
    _moneyLabel.font=[UIFont systemFontOfSize:AUTO(44) weight:UIFontWeightMedium];
    _moneyLabel.textColor=[UIColor whiteColor];
    [blueRound addSubview:_moneyLabel];
    _moneyLabel.sd_layout
    .centerYIs(blueRound.center.y-AUTO(10))
    .centerXEqualToView(blueRound)
    .autoHeightRatio(0);
    [_moneyLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    
    UILabel *jkje=[UILabel new];
    jkje.text=@"可借的钱";
    jkje.font=[UIFont systemFontOfSize:AUTO(18)];
    jkje.textColor=[UIColor whiteColor];
    [blueRound addSubview:jkje];
    jkje.sd_layout
    .topSpaceToView(_moneyLabel, AUTO(5))
    .centerXEqualToView(blueRound)
    .autoHeightRatio(0);
    [jkje setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
    
    UIButton *returnMoneyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [returnMoneyBtn setTitle:@"还款" forState:UIControlStateNormal];
    [returnMoneyBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    returnMoneyBtn.titleLabel.font=Font(AUTO(14));
    returnMoneyBtn.backgroundColor=[UIColor whiteColor];
    [YhbMethods setViewBorder:returnMoneyBtn BorderWidth:AUTO(1) BorderColor:[UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1]];
    [YhbMethods setView:returnMoneyBtn CornerRadius:AUTO(3) AndMasks:YES];
    [returnMoneyBtn addTarget:self action:@selector(returnMoney) forControlEvents:UIControlEventTouchUpInside];

    [scroll addSubview:returnMoneyBtn];
    returnMoneyBtn.sd_layout
    .topSpaceToView(topview, AUTO(15))
    .leftSpaceToView(scroll, AUTO(15))
    .rightSpaceToView(scroll, ScreenWidth/2+AUTO(15))
    .heightIs(AUTO(40));
    
    
    UIButton *borrowMoneyBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [borrowMoneyBtn setTitle:@"借款" forState:UIControlStateNormal];
    [borrowMoneyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    borrowMoneyBtn.titleLabel.font=Font(AUTO(14));
    borrowMoneyBtn.backgroundColor=[YhbMethods colorWithHexString:COLOR_MAIN];
    [YhbMethods setView:borrowMoneyBtn CornerRadius:AUTO(3) AndMasks:YES];
    [borrowMoneyBtn addTarget:self action:@selector(borrowMoney) forControlEvents:UIControlEventTouchUpInside];
    [scroll addSubview:borrowMoneyBtn];
    borrowMoneyBtn.sd_layout
    .topSpaceToView(topview, AUTO(15))
    .rightSpaceToView(scroll, AUTO(15))
    .leftSpaceToView(scroll, ScreenWidth/2+AUTO(15))
    .heightIs(AUTO(40));
    
    UIButton *helpBtn=[UIButton buttonWithType:UIButtonTypeSystem];
    [helpBtn setTitle:@"帮助中心" forState:UIControlStateNormal];
    helpBtn.titleLabel.font=Font(AUTO(14));
    [scroll addSubview:helpBtn];
    helpBtn.sd_layout
    .topSpaceToView(scroll, ScreenHeight-NavHeight-TAB_BAR_HEIGHT-AUTO(50))
    .centerXEqualToView(scroll);
    [helpBtn setupAutoSizeWithHorizontalPadding:AUTO(10) buttonHeight:AUTO(30)];
    [helpBtn addTarget:self action:@selector(toHelp) forControlEvents:UIControlEventTouchUpInside];
    
    if ([YhbMethods readBOOLUserDefault:@"isLogin"]==NO) {
        jkje.text=@"登录查看可借额度";
        jkje.sd_resetLayout
        .centerYEqualToView(blueRound)
        .centerXEqualToView(blueRound)
        .autoHeightRatio(0);
        [jkje setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
        _moneyLabel.hidden=YES;
        
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toLogin)];
        [blueRound addGestureRecognizer:tap];
    }
  
    

    
}
-(void)slideValueChanged:(UISlider *)slide{
    if (slide.tag==1110) {
        //首页借款额度
        long maxMoney=5000;
        float numberToRound;
        int result;
        numberToRound = maxMoney*slide.value;
        result = (int)roundf(numberToRound);
        
        if (result<1000) {
            _moneyLabel.text=@"￥0.00";
        }else{
            NSString *str=[NSString stringWithFormat:@"%d",result];
            _moneyLabel.text=[NSString stringWithFormat:@"￥%@%@",[str substringToIndex:str.length-3],@"000"];
        }
    }else{
        _timeLabel.text=[NSString stringWithFormat:@"%.0f",slide.value];
    }
    
    
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
