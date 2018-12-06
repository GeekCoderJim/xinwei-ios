//
//  IDCardQualificationViewController.m
//  SuXunTong
//
//  Created by 尤鸿斌 on 2017/3/27.
//  Copyright © 2017年 scan. All rights reserved.
//

#import "IDCardQualificationViewController.h"

#import "AddPhotoViewController.h"

@interface IDCardQualificationViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIImage *selectedImage;
}
@property(strong,nonatomic) UIScrollView *scrollview;

@property (strong, nonatomic) UIButton *takePhotoButton;

@end

@implementation IDCardQualificationViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"拍照示例";
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    [_takePhotoButton setTitleColor:[YhbMethods colorWithHexString:COLOR_MAIN] forState:UIControlStateNormal];
    [YhbMethods setViewBorder:_takePhotoButton BorderWidth:1 BorderColor:[YhbMethods colorWithHexString:COLOR_MAIN]];
    [YhbMethods setView:_takePhotoButton CornerRadius:25 AndMasks:YES];
    [self setupViews];
    self.ExampleImageView.image=_exampleImage;
}

-(void)setupViews{
    self.scrollview=[[UIScrollView alloc]initWithFrame:ScreenBounds];
    _scrollview.backgroundColor=[UIColor whiteColor];
    self.view=self.scrollview;
    
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(0, AUTO(30), ScreenWidth, AUTO(30))];
    label1.text=@"请参照本示例照片";
    label1.textAlignment=NSTextAlignmentCenter;
    label1.textColor=[UIColor darkGrayColor];
    label1.font=Font(AUTO(14));
    [self.scrollview addSubview:label1];
    
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(0, AUTO(60), ScreenWidth, AUTO(30))];
    label2.text=@"确保证件上的信息真实有效且清晰可见";
    label2.textAlignment=NSTextAlignmentCenter;
    label2.textColor=[UIColor darkGrayColor];
    label2.font=Font(AUTO(14));
    [self.scrollview addSubview:label2];
    
    double height=self.exampleImage.size.height/(self.exampleImage.size.width/(ScreenWidth-AUTO(20)));
    self.ExampleImageView=[[UIImageView alloc]initWithFrame:CGRectMake(AUTO(10), AUTO(100), ScreenWidth-AUTO(20), height)];
    [self.scrollview addSubview:self.ExampleImageView];
    
    self.takePhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _takePhotoButton.frame=CGRectMake(AUTO(45), AUTO(120)+height, ScreenWidth-AUTO(90), AUTO(44));
    _takePhotoButton.backgroundColor=[YhbMethods colorWithHexString:@"#ea1711"];
    _takePhotoButton.titleLabel.font=Font(AUTO(16));
    [_takePhotoButton setTitle:@"开始拍照" forState:UIControlStateNormal];
    [_takePhotoButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [YhbMethods setView:_takePhotoButton CornerRadius:AUTO(22) AndMasks:YES];
    [self.scrollview addSubview:self.takePhotoButton];
    [_takePhotoButton addTarget:self action:@selector(takePhotoFromCameral) forControlEvents:UIControlEventTouchUpInside];

    self.scrollview.contentSize=CGSizeMake(ScreenWidth, _takePhotoButton.frame.origin.y+_takePhotoButton.frame.size.height+AUTO(20));
    
}
-(void)pop{
   
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
        [picker dismissViewControllerAnimated:YES completion:nil];
        [self.navigationController popViewControllerAnimated:YES];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.takePhotoBlock(image);

        });
        
    });
    
}


@end
