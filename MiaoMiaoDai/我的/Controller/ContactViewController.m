//
//  ContactViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/3/3.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "ContactViewController.h"

@interface ContactViewController ()

@end

@implementation ContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"联系我们";
    
    [self setupviews];
    
}
-(void)setupviews{
    UIScrollView *scroll=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    scroll.backgroundColor=[UIColor groupTableViewBackgroundColor];

    self.view=scroll;
    
    UIImageView *imageview=[[UIImageView alloc]initWithFrame:Frame(0, AUTO(30), AUTO(100), AUTO(100))];
    imageview.image=Image(@"xinwei_logo");
    imageview.center=CGPointMake(scroll.center.x, imageview.center.y);
    [scroll addSubview:imageview];
    
    UILabel *title=[[UILabel alloc]initWithFrame:Frame(0, AUTO(150), ScreenWidth, AUTO(25))];
    title.text=@"鑫炜商务咨询有限公司";
    title.font=Font(AUTO(20));
    title.textAlignment=NSTextAlignmentCenter;
    [scroll addSubview:title];
    
    UILabel *lxdh=[UILabel new];
    lxdh.font=Font(AUTO(14));
    lxdh.text=@"联系电话";
    [scroll addSubview:lxdh];
    lxdh.sd_layout
    .topSpaceToView(title, AUTO(10))
    .centerXEqualToView(title)
    .autoHeightRatio(0);
    [lxdh setSingleLineAutoResizeWithMaxWidth:300];
    
    UILabel *phone=[UILabel new];
    phone.font=Font(AUTO(14));
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:@"0595-28882517"
                                                                                attributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
    phone.attributedText = attrStr;
    phone.textColor=[YhbMethods colorWithHexString:COLOR_MAIN];
    phone.userInteractionEnabled=YES;
    UITapGestureRecognizer *tap1=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(call)];
    [phone addGestureRecognizer:tap1];
    [scroll addSubview:phone];
    phone.sd_layout
    .topSpaceToView(lxdh, AUTO(10))
    .centerXEqualToView(title)
    .autoHeightRatio(0);
    [phone setSingleLineAutoResizeWithMaxWidth:300];
    
    
    UILabel *gsdz=[UILabel new];
    gsdz.font=Font(AUTO(14));
    gsdz.text=@"公司地址";
    [scroll addSubview:gsdz];
    gsdz.sd_layout
    .topSpaceToView(phone, AUTO(10))
    .centerXEqualToView(title)
    .autoHeightRatio(0);
    [gsdz setSingleLineAutoResizeWithMaxWidth:300];
    
    UILabel *address=[UILabel new];
    address.font=Font(AUTO(14));
    address.text=@"梅州鸿达创意园505";
    address.textColor=[YhbMethods colorWithHexString:COLOR_MAIN];
    [scroll addSubview:address];
    address.sd_layout
    .topSpaceToView(gsdz, AUTO(10))
    .centerXEqualToView(title)
    .autoHeightRatio(0);
    [address setSingleLineAutoResizeWithMaxWidth:300];
    
    UILabel *gsweb=[UILabel new];
    gsweb.font=Font(AUTO(14));
    gsweb.text=@"联系QQ号";
    [scroll addSubview:gsweb];
    gsweb.sd_layout
    .topSpaceToView(address, AUTO(10))
    .centerXEqualToView(title)
    .autoHeightRatio(0);
    [gsweb setSingleLineAutoResizeWithMaxWidth:300];
    
    UILabel *web=[UILabel new];
    web.font=Font(AUTO(14));
    web.text=@"3069677975";
//    NSMutableAttributedString *attrStr1 = [[NSMutableAttributedString alloc] initWithString:@"3069677975"
//                                                                                attributes:@{NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle)}];
//    web.attributedText = attrStr1;
    web.textColor=[YhbMethods colorWithHexString:COLOR_MAIN];
//    web.userInteractionEnabled=YES;
//    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jump)];
//    [web addGestureRecognizer:tap2];
    [scroll addSubview:web];
    web.sd_layout
    .topSpaceToView(gsweb, AUTO(10))
    .centerXEqualToView(title)
    .autoHeightRatio(0);
    [web setSingleLineAutoResizeWithMaxWidth:300];
    
    [scroll setupAutoContentSizeWithBottomView:web bottomMargin:AUTO(20)];
}
-(void)call{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel:0595-28882517"]];
}
-(void)jump{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.qzxwmy.com"]];

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
