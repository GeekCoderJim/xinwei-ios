//
//  MyQRCodeViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/9/1.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "MyQRCodeViewController.h"

@interface MyQRCodeViewController ()
{
    UIImageView *qrcodeImage;
}

@end

@implementation MyQRCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的二维码";
    
    qrcodeImage = [[UIImageView alloc]init];
    [self.view addSubview:qrcodeImage];
    qrcodeImage.sd_layout
    .topSpaceToView(self.view, 30)
    .centerXEqualToView(self.view)
    .widthIs(300)
    .heightEqualToWidth();
    
    qrcodeImage.image = [self generateQRCode:self.shareUrl width:300 height:300];
    
    UIButton *addButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"保存到手机" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.titleLabel.font=Font(AUTO(16));
    addButton.backgroundColor=[YhbMethods colorWithHexString:COLOR_BIG_BUTTON];
    [addButton addTarget:self action:@selector(saveImageToAlbum) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    addButton.sd_layout
    .topSpaceToView(qrcodeImage, 30)
    .leftSpaceToView(self.view, 30)
    .rightSpaceToView(self.view, 30)
    .heightIs(44);
    addButton.sd_cornerRadius=@(5);
    
    
}
-(void)saveImageToAlbum{
    
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(300, 300),YES,0);
    [qrcodeImage drawViewHierarchyInRect:qrcodeImage.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    //以下是保存文件到沙盒路径下
    //把图片转成NSData类型的数据来保存文件
    NSData *data;
    //判断图片是不是png格式的文件
    NSString *imageType = nil;
    if (UIImagePNGRepresentation(image)) {
        //返回为png图像。
        data = UIImagePNGRepresentation(image);
        imageType = @"png";
    }else {
        //返回为JPEG图像。
        data = UIImageJPEGRepresentation(image, 1.0);
        imageType = @"jpeg";
    }
    
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    [SVProgressHUD showSuccessWithStatus:@"已将图片保存到相册"];
}

- (UIImage *)generateQRCode:(NSString *)code width:(CGFloat)width height:(CGFloat)height {
    
    // 生成二维码图片
    CIImage *qrcodeImage;
    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"H" forKey:@"inputCorrectionLevel"];
    qrcodeImage = [filter outputImage];
    
    // 消除模糊
    CGFloat scaleX = width / qrcodeImage.extent.size.width;
    CGFloat scaleY = height / qrcodeImage.extent.size.height;
    CIImage *transformedImage = [qrcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
