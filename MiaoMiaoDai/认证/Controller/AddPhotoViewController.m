//
//  AddPhotoViewController.m
//  SuXunTong
//
//  Created by 尤鸿斌 on 2017/3/27.
//  Copyright © 2017年 scan. All rights reserved.
//

#import "AddPhotoViewController.h"
#import "IDCardQualificationViewController.h"
#import "UserEntity.h"
#import "RZRequest.h"
#import "AddPhotoView.h"
#import <AliyunOSSiOS/OSSService.h>
#import "Conf.h"
#import "Auth.h"
#import "TXQcloudFrSDK.h"
#import "AddPhotoSecondViewController.h"
#import "YTServerAPI.h"


#import "AliRPVC.h"

#define Weak(wself) __weak typeof(self)(wself) = self
typedef NS_ENUM(NSInteger,upLoadImageType) {
    
    idcardfront = 100001, //身份证正面
    idcardback = 100002 ,//身份证反面
    bankcard = 100003,//银行卡
    bankcardwithidcard = 100004//银行卡+身份证
};
@interface AddPhotoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    AddPhotoView *addphotoview;
    int count;
    int pickPhotoFlag;
    NSMutableDictionary *imageAddressDic;
    upLoadImageType current_type;
    TXQcloudFrSDK *txsdk;
    
    NSInteger BtnTag;

}



@end

@implementation AddPhotoViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"信息认证";
    
    
    
    addphotoview = [[AddPhotoView alloc]initWithFrame:self.view.frame];
    addphotoview.FrontButton.tag=1000;
    addphotoview.OppoSiteButton.tag=1001;
    addphotoview.BankCardButton.tag=1002;
    addphotoview.CardWithPeopleButton.tag=1003;
    [addphotoview.FrontButton addTarget:self  action:@selector(photo:) forControlEvents:UIControlEventTouchUpInside];
    [addphotoview.OppoSiteButton addTarget:self  action:@selector(photo:) forControlEvents:UIControlEventTouchUpInside];
    [addphotoview.BankCardButton addTarget:self  action:@selector(photo:) forControlEvents:UIControlEventTouchUpInside];
    [addphotoview.CardWithPeopleButton addTarget:self  action:@selector(photo:) forControlEvents:UIControlEventTouchUpInside];
    [addphotoview.FinishButton addTarget:self  action:@selector(upload:) forControlEvents:UIControlEventTouchUpInside];
    self.view = addphotoview;
  
    imageAddressDic=[NSMutableDictionary new];
    
}

#pragma mark ---------------------------------------------- 按钮点击
-(void)photo:(UIButton *)sender{
    switch (sender.tag) {
        case 1000:
            current_type=idcardfront;
            break;
        case 1001:
            current_type=idcardback;
            break;
//        case 1002:
//            current_type=bankcard;
//            break;
//        case 1003:
//            current_type=bankcardwithidcard;
//            break;
        default:
            break;
    }
    [self takePhotoFromCameralWithTag:sender.tag];
}

- (void)upload:(UIButton *)sender {
    
    if (pickPhotoFlag<2) {
        [AppUtils showErrorMessage:@"您还有照片未拍摄，请继续完成拍摄"];
    }else{
        [self uploadFinish];
    }
}

#pragma mark ---------------------------------------------- 加水印
-(void)addWater:(UIButton *)btn{
    UILabel *Lab=[[UILabel alloc]initWithFrame:Frame(0, btn.frame.size.height/2, btn.frame.size.width, AUTO(20))];
    Lab.textColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:0.4];
    Lab.font=Font(AUTO(15));
    Lab.text=@"仅秒秒贷使用";
    Lab.adjustsFontSizeToFitWidth = YES;
    Lab.textAlignment=NSTextAlignmentCenter;
    Lab.numberOfLines = 0;
    [btn addSubview:Lab];
    Lab.transform = CGAffineTransformRotate (self.view.transform, -M_PI_2/7*1);

}

//从相机获取图片
-(void)takePhotoFromCameralWithTag :(NSInteger)tag
{
    BtnTag = tag - 1000;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = NO;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    Weak(wkself);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [picker dismissViewControllerAnimated:YES completion:nil];
            [wkself OCRwithIDCardWithImage:image andCardType:BtnTag];
            
        });
        
    });
    
}

-(void)uploadImage:(UIImage *)image{
    
    [RZRequest upLoadImage:image Success:^(id obj) {
        pickPhotoFlag++;
        if (current_type==idcardfront) {
            
            [addphotoview.FrontButton setBackgroundImage:image forState:UIControlStateNormal];
            [self addWater:addphotoview.FrontButton];
            [imageAddressDic setValue:obj[@"data"] forKey:@"idCardUrl"];
        }else if (current_type==idcardback) {
            [addphotoview.OppoSiteButton setBackgroundImage:image forState:UIControlStateNormal];
            [self addWater:addphotoview.OppoSiteButton];
            [imageAddressDic setValue:obj[@"data"] forKey:@"IdCardBackUrl"];
        }else if (current_type==bankcard) {
            [addphotoview.BankCardButton setBackgroundImage:image forState:UIControlStateNormal];
            [self addWater:addphotoview.BankCardButton];
            [imageAddressDic setValue:obj[@"data"] forKey:@"bankCardUrl"];
        }else{
            
            [addphotoview.CardWithPeopleButton setBackgroundImage:image forState:UIControlStateNormal];
            [self addWater:addphotoview.CardWithPeopleButton];
            [imageAddressDic setValue:obj[@"data"] forKey:@"manCardUrl"];
        }
    }];
}

- (void)OCRwithIDCardWithImage:(UIImage *)image andCardType : (NSInteger )requestTag{
    Weak(wkself);
    [[YTServerAPI instance] idcardOCR:image withCardType:requestTag callback:^(NSInteger error, NSDictionary *dic){
        if (error == 0) {
            [wkself uploadImage:image];
        }else{
            [AppUtils showErrorMessage:@"身份证识别失败，请重试！"];
        }
        
        
    }];
}

#pragma mark ---------------------------------------------- 上传成功
-(void)uploadFinish{
    
    AliRPVC *vc = [AliRPVC new];
    
//    AddPhotoSecondViewController *vc = [AddPhotoSecondViewController new];
////    vc.idcardImage = addphotoview.FrontButton.currentBackgroundImage;
////    vc.imageAddressDic = imageAddressDic;
    [self.navigationController pushViewController:vc animated:YES];

    
}
-(void)getStatus{
    [RZRequest getUserVerifyStatus:^(id obj) {
        [AppUtils showSuccessMessage:@"保存成功，正在返回"];
        [YhbMethods performBlock:^{
            [AppUtils dismissHUD];
            [self.navigationController popViewControllerAnimated:YES];
        } afterDelay:1.0f];
    }];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
