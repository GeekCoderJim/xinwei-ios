//
//  PersonInfoViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/3/1.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "RZTableViewCell.h"
#import "BaseInfoViewController.h"
#import "EmergencyViewController.h"
#import "RZRequest.h"

@interface PersonInfoViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView *tableview;
@property(copy,nonatomic)NSArray *dataSource;

@end

@implementation PersonInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    self.title=@"个人信息";
    
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    self.dataSource=@[@{@"title":@"基本信息",@"icon":@"icon_human"},
                      @{@"title":@"紧急联系人",@"icon":@"icon_people"}];
    [self tableview];
    
    UILabel *label=[[UILabel alloc]initWithFrame:Frame(0, 0, ScreenWidth, AUTO(60))];
    NSString *str=@"我们承诺保障您的个人信息安全";
    label.textAlignment=NSTextAlignmentCenter;
    label.attributedText=[YhbMethods createStrAddImgAttributedStringWithText:str andTextColor:[UIColor darkGrayColor] andStrFont:AUTO(15) andImg:Image(@"icon_smile") andImgSize:CGRectMake(-AUTO(5), -AUTO(5), AUTO(20), AUTO(20)) atIndex:0];
    self.tableview.tableFooterView=label;
    self.view=self.tableview;

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(reloadTable) name:NotificationName_UserEntityReload object:nil];
}
-(void)reloadTable{
  [self.tableview reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RZTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[RZTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
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
    if (indexPath.row==0) {
        if ([self.userEntity.userInfoStatus boolValue]==YES) {
            cell.detailTextLabel.text=@"";
        }else{
            cell.detailTextLabel.text=@"请完善";
        }
    }else{
        if ([self.userEntity.userInfoStatus boolValue]==YES) {
            cell.detailTextLabel.text=@"";
        }else{
            cell.detailTextLabel.text=@"请完善";
        }
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        BaseInfoViewController *vc=[BaseInfoViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        EmergencyViewController *vc=[EmergencyViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AUTO(50);
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
