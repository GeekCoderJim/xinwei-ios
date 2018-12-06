//
//  MMDProductVC.m
//  MiaoMiaoDai
//
//  Created by 陈恒均 on 2018/11/24.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "MMDProductVC.h"
#import "MMDProductCell.h"
#import "LoginRequest.h"
#import "MMDCompanyModel.h"
#import <MJExtension/MJExtension.h>

#define Weak(wself) __weak typeof(self)(wself) = self

static NSString *kMMDProductCell = @"MMDProductCell";
@interface MMDProductVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) MMDCompanyModel *companyModel;

@end

@implementation MMDProductVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"产品";
    self.view.backgroundColor = [UIColor orangeColor];
    [self setupTableView];
}


-(void)setupTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight) style:0];
    [self.view addSubview:self.tableView];
    self.tableView.dataSource =self;
    self.tableView.delegate =self;
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MMDProductCell" bundle:nil] forCellReuseIdentifier:kMMDProductCell];

    
}

#pragma - mark tableviewDatasource && tableviewDelegate

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    MMDProductCell *cell = [tableView dequeueReusableCellWithIdentifier:kMMDProductCell];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 63;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.block) {
        self.block(self.dataArray[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma - mark setter && getter

-(void)setPhoneNumber:(NSString *)phoneNumber{
    _phoneNumber = phoneNumber;
    self.companyModel = [MMDCompanyModel new];
    Weak(wkself);
    
    [LoginRequest getResUserListWithPhoneNum:phoneNumber Success:^(NSMutableDictionary *obj) {
        NSLog(@"%@",obj);
        wkself.dataArray = [MMDCompanyModel mj_objectArrayWithKeyValuesArray:obj[@"data"]];
        NSLog(@"%@",wkself.dataArray);
        MMDCompanyModel *companyModel = self.dataArray[0];
        companyModel.name = @"秒秒到";
        companyModel.ID = @"";
        NSLog(@"%@",wkself.dataArray);
        [wkself.tableView reloadData];
    }];
    
}

-(NSMutableArray *)dataArray{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



@end
