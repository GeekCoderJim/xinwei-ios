//
//  BankCardViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/3/3.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "BankCardViewController.h"
#import "CreditCardCell.h"
#import "HomeRequest.h"
#import "BankCardModel.h"
#import "AddNewCardViewController.h"

@interface BankCardViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *tableview;
@property(strong,nonatomic)UIView *noRecordView;
@property(strong,nonatomic)NSMutableArray *dataSource;

@end

@implementation BankCardViewController
-(void)viewWillAppear:(BOOL)animated{
//    self.backgroundColor=[YhbMethods colorWithHexString:@"#2E3132"];
    self.navigationController.navigationBar.barTintColor=[UIColor blackColor];
    [self getBankCardList];

}
-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor=[YhbMethods colorWithHexString:COLOR_MAIN];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的银行卡";
    [self tableview];
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];

    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCards)];
}
-(void)getBankCardList{
    [HomeRequest getBankCardListSuccess:^(id obj) {
        if ([obj[@"code"]isEqualToString:SUCCESS]) {
            [self.noRecordView removeFromSuperview];
            [self.view addSubview: self.tableview];
            NSArray *array=obj[@"content"];
            if ([array isKindOfClass:[NSArray class]]) {
                self.dataSource= [NSMutableArray new];
                for (NSDictionary *dic in array) {
                    BankCardModel *model=[[BankCardModel alloc]initWithDic:dic];
                    [self.dataSource addObject:model];
                }
                [self.tableview reloadData];
            }
            
        }else if([obj[@"code"]isEqualToString:RECORD_NO_EXIST]){
            [self.tableview removeFromSuperview];
            [self setNoRecordView];
        }else if ([obj[@"code"]isEqualToString:TOKEN_ERROR]||[obj[@"code"]isEqualToString:NO_LOGIN]){
            [YhbMethods LoginTimeOut];
        }else{
            [AppUtils showAlertMessage:obj[@"msg"]];
        }
    }];
}

-(void)addCards{
    if ([self.userEntity.userInfoStatus boolValue]==YES) {
        [self.navigationController pushViewController:[AddNewCardViewController new] animated:YES];
    }else{
        [AppUtils showAlertMessage:@"请先完善您的个人资料认证"];
    }
    
}
-(void)setNoRecordView{
    self.noRecordView=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.noRecordView];
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:Frame(0, AUTO(40), AUTO(160), AUTO(128))];
    imageview.center=CGPointMake(_noRecordView.center.x, imageview.center.y);
    imageview.image=Image(@"icon_card");
    [self.noRecordView addSubview:imageview];
    
    UILabel *label=[[UILabel alloc]initWithFrame:Frame(0, AUTO(190), ScreenWidth, AUTO(20))];
    label.text=@"暂无银行卡，点击右上角添加";
    label.font=Font(AUTO(18));
    label.textColor=[UIColor lightGrayColor];
    label.textAlignment=NSTextAlignmentCenter;
    [self.noRecordView addSubview:label];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identity=@"cell";
    CreditCardCell *cell=[tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell=[[CreditCardCell alloc]initWithStyle:0 reuseIdentifier:identity];
    }
    BankCardModel *model=_dataSource[indexPath.row];
    cell.model=model;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BankCardModel *model=_dataSource[indexPath.row];
    self.returnCard(model);
    [self.navigationController popViewControllerAnimated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AUTO(130);
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return AUTO(5);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:Frame(0, 0, ScreenWidth, AUTO(5))];
    view.backgroundColor=[YhbMethods colorWithHexString:@"#2E3132"];
    return view;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return   UITableViewCellEditingStyleDelete;
}
//先要设Cell可编辑
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    CreditCardInfoModel *model=creditcardList[indexPath.row];
//    selectedCard=model.card_no;
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要删除这张卡吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=110;
    [alert show];
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

-(UITableView *)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:Frame(0, 0, ScreenWidth, ScreenHeight-NavHeight) style:UITableViewStylePlain];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.backgroundColor=[YhbMethods colorWithHexString:@"#2E3132"];
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
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
