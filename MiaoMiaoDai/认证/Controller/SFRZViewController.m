//
//  SFRZViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/3/2.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "SFRZViewController.h"
#import "RZRequest.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface SFRZViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    NSInteger current_btn_tag;
    UIImage *idCardFrontImage,*FaceImage;
}
@property(strong,nonatomic)UIViewController * vc1,*vc2;

@end

@implementation SFRZViewController


-(void)viewWillDisappear:(BOOL)animated{
    self.vc1=nil;
    self.vc2=nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"身份认证";
  
    

    
    
    UIScrollView *scrollview=[[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollview.backgroundColor=[UIColor groupTableViewBackgroundColor];
    self.view=scrollview;

    NSArray *tipsArray=@[@"身份证正面照",@"身份证反面照",@"真实头像"];
    for (int i = 0 ; i<3; i++) {
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=Frame(0, i*AUTO(240), ScreenWidth, AUTO(240));
        button.tag=100+i;

        [button addTarget:self action:@selector(GetPhoto:) forControlEvents:UIControlEventTouchUpInside];
        [scrollview addSubview:button];
        
        UIImageView *imageview=[[UIImageView alloc]initWithFrame:Frame(0, AUTO(20), AUTO(255), AUTO(162))];
        imageview.image=Image(@"icon_head");
        imageview.center=CGPointMake(button.center.x, imageview.center.y);
        imageview.contentMode=UIViewContentModeScaleAspectFill;
        imageview.clipsToBounds=YES;
        imageview.tag=200+i;
        
        [button addSubview:imageview];
        
        UILabel *label=[[UILabel alloc]initWithFrame:Frame(0, AUTO(200), ScreenWidth, AUTO(20))];
        label.text=tipsArray[i];
        label.textColor=[UIColor lightGrayColor];
        label.font=Font(AUTO(15));
        label.textAlignment=NSTextAlignmentCenter;
        [button addSubview:label];
    }
    
    UIButton *addButton=[UIButton buttonWithType:UIButtonTypeCustom];
    addButton.frame=Frame(AUTO(20), AUTO(740), ScreenWidth-AUTO(40), AUTO(50));
    [addButton setTitle:@"认证" forState:UIControlStateNormal];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    addButton.titleLabel.font=Font(AUTO(16));
    addButton.backgroundColor=[YhbMethods colorWithHexString:COLOR_BIG_BUTTON];
    [YhbMethods setView:addButton CornerRadius:AUTO(5) AndMasks:YES];
    [addButton addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];

    [scrollview setupAutoContentSizeWithBottomView:addButton bottomMargin:AUTO(20)];

    
    
    [RZRequest getSFRZImageSuccess:^(id obj) {
        NSString *id_card_photo = obj[@"id_card_photo"];
        NSString *id_card_photo_back = obj[@"id_card_photo_back"];
        NSString *id_card_photo_face = obj[@"id_card_photo_face"];
        
        UIImageView *idcard=[self.view viewWithTag:200];
        [idcard sd_setImageWithURL:[NSURL URLWithString:id_card_photo]];
        UIImageView *idcard_back=[self.view viewWithTag:201];
        [idcard_back sd_setImageWithURL:[NSURL URLWithString:id_card_photo_back]];
        UIImageView *idcard_face=[self.view viewWithTag:202];
        [idcard_face sd_setImageWithURL:[NSURL URLWithString:id_card_photo_face]];
    }];
}

int count;
-(void)next{
    NSMutableArray *imgArr=[NSMutableArray new];
    for (int i = 0; i<3; i++) {
        UIImageView *imageview = [self.view viewWithTag:200+i];
        [imgArr addObject:imageview.image];
    }
//    
//    [RZRequest upLoadImages:imgArr Success:^(id obj) {
//        count++;
//        if (count<=3) {
//            [AppUtils showSuccessMessage:@"照片上传成功，正在返回"];
//            count=0;
//            [YhbMethods performBlock:^{
//                [self.navigationController popToRootViewControllerAnimated:YES];
//            } afterDelay:1.0];
//        }
//    }];
}

-(void)GetPhoto:(UIButton *)btn{
    current_btn_tag=btn.tag;
    [self setUserHeaderImg];
}

- (void)setUserHeaderImg{
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择上传" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打开照相机",@"从手机相册获取", nil];
    actionSheet.tag = 2008;
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
}
#pragma mark actionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self takePhotoFromCameral];
            break;
        case 1:
            [self takePhotoFromAlbum];
            break;
        default:
            break;
    }
}
//从图片库获取图片
- (void)takePhotoFromAlbum{
    UIImagePickerController *picker1 = [[UIImagePickerController alloc] init];
    //资源类型为图片库
    picker1.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker1.delegate = self;
    //设置选择后的图片可被编辑
    picker1.allowsEditing = YES;
    [self presentViewController:picker1 animated:YES completion:nil];
}

//从相机获取图片
-(void)takePhotoFromCameral{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    //获得选择的图片
    //当图片不为空时显示图片并保存图片
    if (image != nil) {
        NSLog(@"image = %@",image);
        //图片显示在界面上
        UIImageView *imagev=[self.view viewWithTag:current_btn_tag+100];
        imagev.image=image;
        
//        [self.headImageView setImage:image];
//
//        [PublicRequst upLoadImage:image Success:^(id obj) {
//            //关闭相册界面
        [self dismissViewControllerAnimated:YES completion:nil];
//            avatar=obj[0];
//        }];
    }
    
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
