//
//  PublicImageCell.m
//  SuperMarket
//
//  Created by 尤鸿斌 on 2018/2/6.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "PublicImageCell.h"

@implementation PublicImageCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.imageview=[[UIImageView alloc]initWithFrame:self.contentView.bounds];
        _imageview.backgroundColor=[UIColor groupTableViewBackgroundColor];
        _imageview.contentMode=UIViewContentModeScaleAspectFill;
        _imageview.clipsToBounds=YES;
        [self.contentView addSubview:_imageview];
        _imageview.sd_layout
        .topSpaceToView(self.contentView, AUTO(5))
        .bottomSpaceToView(self.contentView, AUTO(5))
        .leftSpaceToView(self.contentView, AUTO(5))
        .rightSpaceToView(self.contentView, AUTO(5));
        
        self.delButton=[UIButton buttonWithType:UIButtonTypeCustom];
        [_delButton setBackgroundImage:Image(@"删除图片") forState:UIControlStateNormal];
        [self.contentView addSubview:_delButton];
        _delButton.sd_layout
        .topEqualToView(self.contentView)
        .rightEqualToView(self.contentView)
        .heightIs(AUTO(20))
        .widthEqualToHeight();
        _delButton.backgroundColor=[UIColor whiteColor];
        _delButton.sd_cornerRadius=@(AUTO(10));
    }
    return self;
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
}
@end
