//
//  AddPhotoSecondViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/9/1.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "AddPhotoSecondViewController.h"
#import "Conf.h"
#import "Auth.h"
#import "TXQcloudFrSDK.h"
#import "RZRequest.h"

@interface AddPhotoSecondViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    TXQcloudFrSDK *txsdk;
}
@property(strong,nonatomic)UIButton * idCardButton,*faceButton,*nextButton;


@end

@implementation AddPhotoSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"人脸核身";
    [self setupviews];
    
    //腾讯优图
    NSString *auth = [Auth appSign:1000000 userId:nil];
    txsdk = [[TXQcloudFrSDK alloc] initWithName:[Conf instance].appId authorization:auth endPoint:[Conf instance].API_END_POINT];

    [_idCardButton setBackgroundImage:self.idcardImage forState:UIControlStateNormal];

}
-(void)next{
    NSData *idcard_data=[YhbMethods imageWithImage:self.idcardImage scaledToSize:CGSizeMake(200, 150)];
    UIImage *idcard = [UIImage imageWithData:idcard_data];
    
    NSData *face_data =[YhbMethods imageWithImage:self.faceButton.currentBackgroundImage scaledToSize:CGSizeMake(200, 150)];
    UIImage *face = [UIImage imageWithData:face_data];
    
    
        [AppUtils showTipsMessage:@"请稍候..."];
        [txsdk faceCompare:idcard imageB:face successBlock:^(id responseObject) {
            NSLog(@"%@",responseObject);
            if ([responseObject[@"errorcode"]intValue]==0 && [responseObject[@"similarity"]intValue]>=80) {
                [AppUtils showProgressMessage:@"保存中..."];
                [RZRequest finishUploadImage:self.imageAddressDic success:^(id obj) {
                    [self getStatus];
                } failed:^(id obj) {
                    [AppUtils showErrorMessage:@"请求失败"];
                }];
            }else{
                [AppUtils showErrorMessage:@"检测到身份证与人脸相似度不高，请重试"];
            }
        } failureBlock:^(NSError *error) {
            NSLog(@"%@",error);
            [AppUtils showErrorMessage:@"检测到身份证与人脸相似度不高，请重试"];
        }];
}
-(void)getStatus{
    [RZRequest getUserVerifyStatus:^(id obj) {
        [AppUtils showSuccessMessage:@"保存成功，正在返回"];
        [YhbMethods performBlock:^{
            [AppUtils dismissHUD];
            [self.navigationController popToRootViewControllerAnimated:YES];
        } afterDelay:1.0f];
    }];
}
//从相机获取图片
-(void)takePhotoFromCameral
{
    
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
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [picker dismissViewControllerAnimated:YES completion:nil];
//            [self uploadImage:image];
            [self.faceButton setImage:nil forState:UIControlStateNormal];
            [self.faceButton setBackgroundImage:image forState:UIControlStateNormal];
        });
        
    });
    
}

-(void)setupviews{
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:self.view.frame];
    scroll.backgroundColor=[UIColor whiteColor];
    self.view = scroll;
    
    self.idCardButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _idCardButton.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [scroll addSubview:_idCardButton];
    _idCardButton.sd_layout.topSpaceToView(self.view, 20)
    .leftSpaceToView(scroll, 30)
    .rightSpaceToView(scroll, 30)
    .heightIs(200);
    
    UILabel *sfz = [UILabel new];
    sfz.text=@"身份证照片";
    sfz.font=Font(16);
    [scroll addSubview:sfz];
    sfz.sd_layout
    .topSpaceToView(_idCardButton, 10)
    .centerXEqualToView(scroll)
    .autoHeightRatio(0);
    [sfz setSingleLineAutoResizeWithMaxWidth:300];
    
    
    self.faceButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _faceButton.backgroundColor=[UIColor groupTableViewBackgroundColor];
    [_faceButton setImage:Image(@"人脸") forState:UIControlStateNormal];
    
    [scroll addSubview:_faceButton];
    _faceButton.sd_layout.topSpaceToView(sfz, 30)
    .leftSpaceToView(scroll, 30)
    .rightSpaceToView(scroll, 30)
    .heightIs(200);
    [_faceButton addTarget:self action:@selector(takePhotoFromCameral) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *zrzp = [UILabel new];
    zrzp.text=@"真人照片";
    zrzp.font=Font(16);
    [scroll addSubview:zrzp];
    zrzp.sd_layout
    .topSpaceToView(_faceButton, 10)
    .centerXEqualToView(scroll)
    .autoHeightRatio(0);
    [zrzp setSingleLineAutoResizeWithMaxWidth:300];
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextButton setTitle:@"上传" forState:UIControlStateNormal];
    [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextButton.backgroundColor=[YhbMethods colorWithHexString:COLOR_MAIN];
    [scroll addSubview:_nextButton];
    _nextButton.sd_layout
    .topSpaceToView(zrzp, 20)
    .leftEqualToView(_faceButton)
    .rightEqualToView(_faceButton)
    .heightIs(44);
    _nextButton.sd_cornerRadius=@(22);
    [_nextButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    
    [scroll setupAutoContentSizeWithBottomView:_nextButton bottomMargin:20];
}
- (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size{
    NSData * data = UIImageJPEGRepresentation(image, 1.0);
    CGFloat dataKBytes = data.length/1000.0;
    CGFloat maxQuality = 0.9f;
    CGFloat lastData = dataKBytes;
    while (dataKBytes > size && maxQuality > 0.01f) {
        maxQuality = maxQuality - 0.01f;
        data = UIImageJPEGRepresentation(image, maxQuality);
        dataKBytes = data.length / 1000.0;
        if (lastData == dataKBytes) {
            break;
        }else{
            lastData = dataKBytes;
        }
    }
    return data;
}


@end
