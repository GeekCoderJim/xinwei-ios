//
//  IDCardQualificationViewController.h
//  SuXunTong
//
//  Created by 尤鸿斌 on 2017/3/27.
//  Copyright © 2017年 scan. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,phototype) {
    
    front = 11000, //正面
    opposite = 11001 ,//反面

};

typedef void(^TakePhotoBlock)(UIImage *image);
@interface IDCardQualificationViewController : BaseViewController
@property(assign, nonatomic) phototype phototype;
@property(strong,nonatomic)TakePhotoBlock takePhotoBlock;
@property(strong,nonatomic)UIImage *exampleImage;
@property(strong, nonatomic)UIImageView *ExampleImageView;
@end
