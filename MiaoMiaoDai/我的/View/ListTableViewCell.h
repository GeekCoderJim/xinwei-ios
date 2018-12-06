//
//  ListTableViewCell.h
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/4/8.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"

@interface ListTableViewCell : UITableViewCell

@property (nonatomic,strong) ListModel *model;

@property (nonatomic,strong) UIView *statusView;

@property (nonatomic,strong) UIImageView *statusImage;

@property (nonatomic,strong) UILabel *moneyLabel;

@property (nonatomic,strong) UIButton *returnButton;

@property (nonatomic,strong) UILabel *replyLabel;

@property (nonatomic,strong) UILabel *backLabel;

@end
