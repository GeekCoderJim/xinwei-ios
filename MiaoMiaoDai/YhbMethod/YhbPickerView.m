//
//  YhbPickerView.m
//  SuperMarket
//
//  Created by 尤鸿斌 on 2017/11/22.
//  Copyright © 2017年 HongBin You. All rights reserved.
//

#import "YhbPickerView.h"

@implementation YhbPickerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.hidden=YES;
        
        UIView *bg=[[UIView alloc]initWithFrame:ScreenBounds];
        bg.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self addSubview:bg];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [bg addGestureRecognizer:tap];
        
        self.moveView=[UIView new];
        _moveView.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [self addSubview:_moveView];
        _moveView.sd_layout
        .centerXEqualToView(self)
        .centerYIs(self.center.y)
        .widthIs(ScreenWidth-AUTO(100))
        .heightIs(AUTO(320));
        _moveView.sd_cornerRadius=@(AUTO(5));
        
        self.titleLabel = [[UILabel alloc]initWithFrame:Frame(0, 0, ScreenWidth-AUTO(100), AUTO(40))];
        _titleLabel.backgroundColor=[YhbMethods colorWithHexString:COLOR_MAIN];
        _titleLabel.text=@"性别选择";
        _titleLabel.textColor=[UIColor whiteColor];
        _titleLabel.textAlignment=NSTextAlignmentCenter;
        [_moveView addSubview:_titleLabel];
        
        self.tableview=[[UITableView alloc]initWithFrame:Frame(0, AUTO(40), ScreenWidth-AUTO(100), AUTO(280))];
        _tableview.delegate=self;
        _tableview.dataSource=self;
        _tableview.bounces=NO;
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_moveView addSubview:_tableview];
        
        self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreBtn setImage:Image(@"下面还有") forState:UIControlStateNormal];
        _moreBtn.hidden=YES;
        _moreBtn.backgroundColor=[UIColor whiteColor];
        [_moveView addSubview:_moreBtn];
        _moreBtn.sd_layout
        .bottomEqualToView(_moveView)
        .heightIs(AUTO(20))
        .leftEqualToView(_moveView)
        .rightEqualToView(_moveView);
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identity=@"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identity];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identity];

    }
    if (currentType==0) {
        cell.textLabel.text=self.dataSource[indexPath.row];
    }else if (currentType==1){
        NSDictionary *dic = self.dataSource[indexPath.row];
        cell.textLabel.text=dic[@"com_name"];
    }else {
        NSDictionary *dic = self.dataSource[indexPath.row];
        cell.textLabel.text=dic[@"name"];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return AUTO(40);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.block(indexPath,currentType);
    [self hide];
}
-(void)setDDataSource:(NSArray *)dataSource With:(int)type{
    currentType=type;
    self.dataSource=dataSource;
    if (dataSource.count<=10) {
        _moveView.sd_layout
        .centerXEqualToView(self)
        .centerYIs(self.center.y)
        .widthIs(ScreenWidth-AUTO(100))
        .heightIs(AUTO(40)*(dataSource.count+1));
        self.tableview.frame=Frame(0, AUTO(40),ScreenWidth-AUTO(100) , dataSource.count*AUTO(40));
        _moreBtn.hidden=YES;
    }else{
        _moveView.sd_layout
        .centerXEqualToView(self)
        .centerYIs(self.center.y)
        .widthIs(ScreenWidth-AUTO(100))
        .heightIs(AUTO(40)*11+AUTO(20));
        self.tableview.frame=Frame(0, AUTO(40),ScreenWidth-AUTO(100) , 10*AUTO(40));
        _moreBtn.hidden=NO;
    }
    [_moveView updateLayout];
    [self.tableview reloadData];

}
-(void)show{
    
    self.hidden=NO;
    [YhbMethods scaleAnimationFromScale:1 toScale:1.1 autoreverses:YES repeatCount:1 duration:0.1 forView:_moveView removeDelay:0.5];
}
-(void)hide{
//    [UIView animateWithDuration:0.3 animations:^{
//        _moveView.sd_layout
//        .centerXEqualToView(self)
//        .centerYIs(ScreenHeight+AUTO(320))
//        .widthIs(ScreenWidth-AUTO(100))
//        .heightIs(AUTO(320));
//        [_moveView updateLayout];
//    } completion:^(BOOL finished) {
        self.hidden=YES;
//    }];
}

@end
