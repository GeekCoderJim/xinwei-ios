//
//  MineViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/2/28.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "MineViewController.h"
#import "MineTableViewHeader.h"
#import "RZTableViewCell.h"
#import "RecordViewController.h"
#import "ContactViewController.h"
#import "HelpViewController.h"
#import "SettingViewController.h"
#import "ListViewController.h"
#import "BankCardViewController.h"
#import "LoginViewController.h"
#import "HomeRequest.h"
#import "WXApi.h"
#import "YHBShareView.h"
#import "PublicRequest.h"
#import "MyQRCodeViewController.h"

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
@property(strong,nonatomic)MineTableViewHeader *tableHeader;
@property(strong,nonatomic)UITableView *tableview;
@property(copy,nonatomic)NSArray *dataSource;
@property(copy,nonatomic)NSDictionary *shareInfo;

@end

@implementation MineViewController
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    if ([YhbMethods readBOOLUserDefault:@"isLogin"]==YES) {
        if ([YhbMethods readUserDefault:@"account"]) {
            self.tableHeader.nameLabel.text=[YhbMethods readUserDefault:@"account"];
        }else{
            self.tableHeader.nameLabel.text=@"登录/注册";
        }
        [HomeRequest getUserLoanLinesWithPhone:self.userEntity.phoneNumber Success:^(id obj) {
            NSLog(@"%@",obj);
            _tableHeader.moneyLabel.text=[NSString stringWithFormat:@"%.2f元",[obj[@"owe"]floatValue]];
        }];
        [HomeRequest getBankCardListSuccess:^(id obj) {
            if ([obj[@"code"]isEqualToString:SUCCESS]) {
                NSArray *array=obj[@"content"];
                if ([array isKindOfClass:[NSArray class]]) {
                    _tableHeader.bankCardLabel.text=[NSString stringWithFormat:@"%ld张",(long)array.count];
                }
            }else if([obj[@"code"]isEqualToString:RECORD_NO_EXIST]){
                _tableHeader.bankCardLabel.text=@"0张";
            }else if ([obj[@"code"]isEqualToString:TOKEN_ERROR]||[obj[@"code"]isEqualToString:NO_LOGIN]){
                [YhbMethods LoginTimeOut];
                _tableHeader.bankCardLabel.text=@"0张";
            }else{
                [AppUtils showAlertMessage:obj[@"msg"]];
                _tableHeader.bankCardLabel.text=@"0张";
            }
        }];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    self.dataSource=@[@{@"title":@"借款记录",@"icon":@"icon_record"},
                      @{@"title":@"分享给朋友",@"icon":@"icon_share"},
                      @{@"title":@"我的二维码",@"icon":@"icon_qrcode"},
                      @{@"title":@"帮助中心",@"icon":@"icon_help"},
                      @{@"title":@"联系我们",@"icon":@"icon_contact"},
//                      @{@"title":@"意见反馈",@"icon":@"icon_help"},
                      @{@"title":@"个人设置",@"icon":@"icon_setting"}];
    if (isAppStore) {
        self.dataSource=@[@{@"title":@"分享给朋友",@"icon":@"icon_share"},
                          @{@"title":@"我的二维码",@"icon":@"icon_qrcode"},
//                          @{@"title":@"帮助中心",@"icon":@"icon_help"},
                          @{@"title":@"联系我们",@"icon":@"icon_contact"},
//                          @{@"title":@"意见反馈",@"icon":@"icon_help"},
                          @{@"title":@"个人设置",@"icon":@"icon_setting"}];
    }
    [self tableview];
    
    
    self.tableHeader=[[MineTableViewHeader alloc]initWithFrame:Frame(0, 0, ScreenWidth, AUTO(200))];
    [self.tableHeader.returnMoneyButton addTarget:self action:@selector(toOrderList) forControlEvents:UIControlEventTouchUpInside];
    [self.tableHeader.bankCardButton addTarget:self action:@selector(bankcard) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toLogin)];
    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toLogin)];
    self.tableHeader.headImageView.userInteractionEnabled=YES;
    [self.tableHeader.headImageView addGestureRecognizer:tap];
    self.tableHeader.nameLabel.userInteractionEnabled=YES;
    [self.tableHeader.nameLabel addGestureRecognizer:tap2];
    
    
    self.tableview.tableHeaderView=self.tableHeader;
    self.view=self.tableview;
    
    [PublicRequest getShareInfo:^(id obj) {
        _shareInfo=obj;
    }];

    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setLoginStatus) name:@"isLogin" object:nil];
}
-(void)setLoginStatus{
    self.tableHeader.nameLabel.text=self.userEntity.userAccount;
}
-(void)toLogin{
    if ([YhbMethods readBOOLUserDefault:@"isLogin"]==NO) {
        UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:[LoginViewController new]];
        nav.navigationBar.translucent=NO;
        nav.navigationBar.barTintColor=[YhbMethods colorWithHexString:COLOR_MAIN];
        nav.navigationBar.tintColor=[UIColor whiteColor];
        [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

-(void)toOrderList{
    ListViewController *vc=[ListViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)bankcard{
    BankCardViewController *vc=[BankCardViewController new];
    vc.returnCard = ^(BankCardModel *model) {};
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RZTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[RZTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.tips.hidden=YES;
        cell.edit.hidden=YES;
        cell.icon.sd_layout
        .centerYEqualToView(cell.contentView)
        .leftSpaceToView(cell.contentView, AUTO(10))
        .widthIs(AUTO(30))
        .heightEqualToWidth();
    }
    NSDictionary *dic=self.dataSource[indexPath.row];
    cell.icon.image=Image(dic[@"icon"]);
    cell.titleLabel.text=dic[@"title"];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger indexRow = indexPath.row;
    if (isAppStore) {
        if (indexRow==0) {
            indexRow+=1;
        }else{
            indexRow+=2;
        }
    }
    switch (indexRow) {
        case 0:
        {
            RecordViewController *vc=[RecordViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            case 1:
        {
            [self share];
        }
            
            break;
        case 2:
        {
            MyQRCodeViewController *vc=[MyQRCodeViewController new];
            vc.shareUrl = _shareInfo[@"shareUrl"];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            HelpViewController *vc=[HelpViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:{
            ContactViewController *vc=[ContactViewController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:{
            [self.navigationController pushViewController:[SettingViewController new] animated:YES];
        }
            break;
        default:
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AUTO(50);
}

//- (void)share{
//    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"微信好友",@"微信朋友圈", nil];
//    actionSheet.tag = 2008;
//    actionSheet.delegate = self;
//    [actionSheet showInView:self.view];
//
//
//}
//
//#pragma mark actionSheetDelegate
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    switch (buttonIndex) {
//        case 0:
//            [self shareWithType:0 Info:_shareInfo];
//            break;
//        case 1:
//            [self shareWithType:1 Info:_shareInfo];
//            break;
//        default:
//            break;
//    }
//}
//
//
//-(void)shareWithType:(NSInteger)type Info:(NSDictionary *)info {
//    //创建发送对象实例
//    SendMessageToWXReq *sendReq = [[SendMessageToWXReq alloc] init];
//    sendReq.bText = NO;//不使用文本信息
//    if (type==0) {
//        sendReq.scene = 0;//0 = 好友列表 1 = 朋友圈 2 = 收藏
//    }else{
//        sendReq.scene = 1;//0 = 好友列表 1 = 朋友圈 2 = 收藏
//    }
//
//
//    //创建分享内容对象
//    WXMediaMessage *urlMessage = [WXMediaMessage message];
//    urlMessage.title = info[@"title"];
//    urlMessage.description = info[@"description"];
//    [urlMessage setThumbImage:[UIImage imageNamed:@"xinwei_logo"]];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
//
//    //创建多媒体对象
//    WXWebpageObject *webObj = [WXWebpageObject object];
//    webObj.webpageUrl = info[@"shareUrl"];
//
//    //完成发送对象实例
//    urlMessage.mediaObject = webObj;
//    sendReq.message = urlMessage;
//
//    //发送分享信息
//    [WXApi sendReq:sendReq];
//}
-(void)share{
    NSMutableDictionary *dic=[NSMutableDictionary new];
    [dic setValue:_shareInfo[@"title"] forKey:@"title"];
    [dic setValue:[UIImage imageNamed:@"xinwei_logo"] forKey:@"image"];
    [dic setValue:_shareInfo[@"description"] forKey:@"content"];
    [dic setValue:_shareInfo[@"shareUrl"] forKey:@"url"];
    [YHBShareView showWithInfo:dic];
}


-(UITableView *)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        
    }
    return _tableview;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];    
}


@end
