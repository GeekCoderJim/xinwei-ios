//
//  MMDProductCell.m
//  MiaoMiaoDai
//
//  Created by 陈恒均 on 2018/11/24.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "MMDProductCell.h"

@interface MMDProductCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageV;
@property (weak, nonatomic) IBOutlet UILabel *productNameLab;
@property (weak, nonatomic) IBOutlet UILabel *limitLab;
@property (weak, nonatomic) IBOutlet UILabel *dayOutLab;

@end


@implementation MMDProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(MMDCompanyModel *)model{
    _model = model;
//    self.iconImageV.image = [UIImage imageNamed:@""];
    self.productNameLab.text = model.name;
}

@end
