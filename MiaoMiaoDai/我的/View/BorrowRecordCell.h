//
//  BorrowRecordCell.h
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/4/4.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BorrowRecordModel.h"

@interface BorrowRecordCell : UITableViewCell

@property (nonatomic,strong) BorrowRecordModel *model;

@property (nonatomic,strong) UIView *statusView;

@property (nonatomic,strong) UIImageView *statusImage;

@property (nonatomic,strong) UILabel *statusLabel;

@property (nonatomic,strong) UILabel *amountLabel;

@property (nonatomic,strong) UILabel *limitDayLabel;

@property (nonatomic,strong) UILabel *dateLabel;





@end
