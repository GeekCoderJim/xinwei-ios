//
//  RecordViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/3/3.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "RecordViewController.h"
#import "MineRequest.h"
#import "BorrowRecordCell.h"
#import "BorrowRecordModel.h"

@interface RecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UIView *noRecordView;

@property (nonatomic,strong) UITableView *tableview;

@property (nonatomic,strong) NSMutableArray *dataSource;

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"借款记录";
    self.view.backgroundColor=[UIColor groupTableViewBackgroundColor];
    
    [self tableview];
    
    [MineRequest getRecordListSuccess:^(id obj) {
        if ([obj isKindOfClass:[NSArray class]]) {
            NSArray *array=obj;
            if (array.count<=0) {
                [self.tableview removeFromSuperview];
                [self setNoRecordView];
            }else{
                [self.noRecordView removeFromSuperview];
                [self.view addSubview:self.tableview];
                for (NSDictionary *dic in array) {
                    BorrowRecordModel *model=[[BorrowRecordModel alloc]initWithDic:dic];
                    [self.dataSource addObject:model];
                }
                [self.tableview reloadData];
            }
            
        }
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identity=@"cell";
    BorrowRecordCell *cell=[tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell=[[BorrowRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];
    }
    BorrowRecordModel *model=self.dataSource[indexPath.row];
    cell.model=model;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BorrowRecordModel *model=self.dataSource[indexPath.row];
    return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[BorrowRecordCell class] contentViewWidth:ScreenWidth];
}
-(UITableView *)tableview{
    if (!_tableview) {
        _tableview=[[UITableView alloc]initWithFrame:Frame(0, 0, ScreenWidth, ScreenHeight-NavHeight) style:UITableViewStylePlain];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
    }
    return _tableview;
}
-(void)setNoRecordView{
    self.noRecordView=[[UIView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.noRecordView];
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:Frame(0, AUTO(40), AUTO(128), AUTO(128))];
    imageview.center=CGPointMake(_noRecordView.center.x, imageview.center.y);
    imageview.image=Image(@"icon_bill");
    [self.noRecordView addSubview:imageview];
    
    UILabel *label=[[UILabel alloc]initWithFrame:Frame(0, AUTO(178), ScreenWidth, AUTO(20))];
    label.text=@"暂无记录";
    label.font=Font(AUTO(16));
    label.textColor=[UIColor lightGrayColor];
    label.textAlignment=NSTextAlignmentCenter;
    [self.noRecordView addSubview:label];
}
-(NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[NSMutableArray new];
    }
    return _dataSource;
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
