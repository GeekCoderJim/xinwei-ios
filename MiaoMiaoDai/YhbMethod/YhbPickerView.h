//
//  YhbPickerView.h
//  SuperMarket
//
//  Created by 尤鸿斌 on 2017/11/22.
//  Copyright © 2017年 HongBin You. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ReturnRowBlock)(NSIndexPath *index,int currentType);
@interface YhbPickerView : UIView<UITableViewDelegate,UITableViewDataSource>
{
    int currentType;
}
@property(strong,nonatomic)ReturnRowBlock block;

@property(strong,nonatomic)UIView *moveView;

@property(strong,nonatomic)UILabel *titleLabel;

@property(strong,nonatomic)UITableView *tableview;

@property(strong,nonatomic)UIButton *moreBtn;
@property(strong,nonatomic)NSArray *dataSource;

-(void)setDDataSource:(NSArray *)dataSource With:(int)type;
-(void)show;
-(void)hide;
@end
