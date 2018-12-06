//
//  RZTableViewCell.h
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/2/28.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RZTableViewCell : UITableViewCell

@property(strong,nonatomic)UIImageView *icon, *edit;

@property(strong,nonatomic)UILabel *titleLabel;

@property(strong,nonatomic)UILabel *tips;
@end
