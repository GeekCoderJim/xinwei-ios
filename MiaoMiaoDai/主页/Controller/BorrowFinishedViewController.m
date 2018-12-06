//
//  BorrowFinishedViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/4/8.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "BorrowFinishedViewController.h"

@interface BorrowFinishedViewController ()

@end

@implementation BorrowFinishedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"申请成功";
    [self setupviews];
    
}
-(void)setupviews{
    self.view.backgroundColor=[UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    UIView *topview=[[UIView alloc]init];
    topview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:topview];
    topview.sd_layout
    .topSpaceToView(self.view, AUTO(10))
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(AUTO(50));
    
    UILabel *shenqingLabel=[UILabel new];
    shenqingLabel.text=@"申请";
    shenqingLabel.textColor=[YhbMethods colorWithHexString:@"#02C701"];
    shenqingLabel.font=Font(AUTO(16));
    [topview addSubview:shenqingLabel];
    shenqingLabel.sd_layout
    .centerYEqualToView(topview)
    .leftSpaceToView(topview, AUTO(20))
    .autoHeightRatio(0);
    [shenqingLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    UILabel *shenheLabel=[UILabel new];
    shenheLabel.text=@"审核中";
    shenheLabel.textColor=[YhbMethods colorWithHexString:@"#02C701"];
    shenheLabel.font=Font(AUTO(16));
    [topview addSubview:shenheLabel];
    shenheLabel.sd_layout
    .centerYEqualToView(topview)
    .centerXEqualToView(topview)
    .autoHeightRatio(0);
    [shenheLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    UILabel *fangkuanLabel=[UILabel new];
    fangkuanLabel.text=@"放款";
    fangkuanLabel.textColor=[UIColor lightGrayColor];
    fangkuanLabel.font=Font(AUTO(16));
    [topview addSubview:fangkuanLabel];
    fangkuanLabel.sd_layout
    .centerYEqualToView(topview)
    .rightSpaceToView(topview, AUTO(20))
    .autoHeightRatio(0);
    [fangkuanLabel setSingleLineAutoResizeWithMaxWidth:300];
    
    UIView *line1=[UIView new];
    line1.backgroundColor=shenqingLabel.textColor;
    [topview addSubview:line1];
    line1.sd_layout
    .centerYEqualToView(topview)
    .leftSpaceToView(shenqingLabel, AUTO(20))
    .rightSpaceToView(shenheLabel, AUTO(20))
    .heightIs(AUTO(0.5));
    
    UIView *line2=[UIView new];
    line2.backgroundColor=[UIColor lightGrayColor];
    [topview addSubview:line2];
    line2.sd_layout
    .centerYEqualToView(topview)
    .rightSpaceToView(fangkuanLabel, AUTO(20))
    .leftSpaceToView(shenheLabel, AUTO(20))
    .heightIs(AUTO(0.5));
    
    UIView *center=[UIView new];
    center.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:center];
    center.sd_layout
    .topSpaceToView(topview, AUTO(10))
    .leftEqualToView(self.view)
    .rightEqualToView(self.view)
    .heightIs(AUTO(100));
    
    UIImageView *imageview=[[UIImageView alloc]initWithImage:Image(@"success_borrow")];
    [center addSubview:imageview];
    imageview.sd_layout
    .centerXEqualToView(center)
    .topSpaceToView(center, AUTO(20))
    .bottomSpaceToView(center, AUTO(20))
    .widthEqualToHeight();
    
    UIButton *addButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"返回主页" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.titleLabel.font=Font(AUTO(16));
    addButton.backgroundColor=[YhbMethods colorWithHexString:@"#02C701"];
    [YhbMethods setView:addButton CornerRadius:AUTO(5) AndMasks:YES];
    [addButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    addButton.sd_layout
    .topSpaceToView(center, AUTO(15))
    .leftSpaceToView(self.view, AUTO(20))
    .rightSpaceToView(self.view, AUTO(20))
    .heightIs(AUTO(44));
    addButton.sd_cornerRadius=@(AUTO(5));
    
    
    UILabel *NoticeLabel=[UILabel new];
    NoticeLabel.textColor=[UIColor lightGrayColor];
    NoticeLabel.font=Font(AUTO(12));
    NoticeLabel.text=@"安全提示：\n在您借款申请过程中，秒秒贷官方及工作人员不会通过电话、短信、邮件等任何方式，向您收取任何担保费、咨询费等费用。请您提高警惕，谨防诈骗。";
    [self.view addSubview:NoticeLabel];
    NoticeLabel.sd_layout
    .topSpaceToView(addButton, AUTO(30))
    .leftSpaceToView(self.view, AUTO(10))
    .rightSpaceToView(self.view, AUTO(10))
    .autoHeightRatio(0);
}
-(void)back{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
