//
//  AddPhotoView.h
//  SuXunTong
//
//  Created by 尤鸿斌 on 2017/11/3.
//  Copyright © 2017年 scan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddPhotoView : UIScrollView

@property (strong, nonatomic) UIButton *FrontButton;
@property (strong, nonatomic) UIButton *OppoSiteButton;
@property (strong, nonatomic) UIButton *BankCardButton;
@property (strong, nonatomic) UIButton *CardWithPeopleButton;
@property (strong, nonatomic) UILabel *nameLab;
@property (strong, nonatomic) UILabel *IDCardLab;
@property (strong, nonatomic) UILabel *bankCardLab;

@property (strong, nonatomic) UIButton *FinishButton;

@end
