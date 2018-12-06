//
//  RZTableViewCell.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/2/28.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "RZTableViewCell.h"

@implementation RZTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle=UITableViewCellSeparatorStyleNone;
        
        self.icon=[[UIImageView alloc]init];
//        _icon.backgroundColor=[UIColor groupTableViewBackgroundColor];
        [self.contentView addSubview:_icon];
        _icon.sd_layout
        .centerYEqualToView(self.contentView)
        .leftSpaceToView(self.contentView, AUTO(10))
        .widthIs(AUTO(40))
        .heightEqualToWidth();
        
        self.titleLabel=[UILabel new];
        _titleLabel.font=Font(AUTO(16));
        [self.contentView addSubview:_titleLabel];
        _titleLabel.sd_layout
        .centerYEqualToView(_icon)
        .leftSpaceToView(_icon, AUTO(10))
        .autoHeightRatio(0);
        [_titleLabel setSingleLineAutoResizeWithMaxWidth:ScreenWidth];
        
         self.tips=[UILabel new];
        self.tips.textColor=[UIColor redColor];
        self.tips.font=Font(AUTO(11));
        self.tips.text=@"必填";
        self.tips.textAlignment=NSTextAlignmentCenter;
        [YhbMethods setViewBorder:self.tips BorderWidth:AUTO(1) BorderColor:[UIColor redColor]];
        [self.contentView addSubview:self.tips];
        self.tips.sd_layout
        .centerYEqualToView(_titleLabel)
        .leftSpaceToView(_titleLabel, AUTO(5))
        .widthIs(AUTO(30))
        .heightIs(AUTO(16));
        [YhbMethods setView:self.tips CornerRadius:AUTO(2) AndMasks:YES];
        
        self.edit=[[UIImageView alloc]initWithImage:Image(@"icon_edit")];
        [self.contentView addSubview:self.edit];
        self.edit.sd_layout
        .centerYEqualToView(self.contentView)
        .rightSpaceToView(self.contentView, AUTO(10))
        .widthIs(AUTO(25))
        .heightEqualToWidth();
        
        UIView *Line=[UIView new];
        Line.backgroundColor=COLOR_SEP;
        [self.contentView addSubview:Line];
        Line.sd_layout.bottomEqualToView(self.contentView).rightEqualToView(self.contentView).leftSpaceToView(self.contentView, AUTO(10)).heightIs(AUTO(0.5));
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
