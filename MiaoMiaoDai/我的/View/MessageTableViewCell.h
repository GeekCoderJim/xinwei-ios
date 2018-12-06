//
//  MessageTableViewCell.h
//  ShangCheng
//
//  Created by 尤鸿斌 on 2017/11/21.
//  Copyright © 2017年 HongBin You. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageModel.h"

@interface MessageTableViewCell : UITableViewCell

@property (nonatomic,strong) MessageModel *model;

@property(strong,nonatomic)UIImageView *imageview;

@property(strong,nonatomic)UILabel *titleLab;

@property(strong,nonatomic)UILabel *detailLab;

@property(strong,nonatomic)UILabel *timeLab;

@end
