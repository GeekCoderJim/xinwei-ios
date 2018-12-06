//
//  JTViewController.m
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/9/3.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "JTViewController.h"
#import <WebKit/WebKit.h>
#import "PublicRequest.h"
#import "AppJSObject.h"


@interface JTViewController ()<UIWebViewDelegate,AppJSObjectDelegate>
{
    JSContext *jsContent;
    
}
@property(strong,nonatomic)UIWebView *webview;

@property(copy,nonatomic)NSString *urlStr;




@end

@implementation JTViewController
-(void)viewWillAppear:(BOOL)animated{
    [self.tabBarController.tabBar setHidden:YES];
    self.tabBarController.tabBar.frame = CGRectZero;
    
    [PublicRequest getJTWebhOST:^(id obj) {
        [_webview loadRequest:[NSURLRequest requestWithURL:URL(obj)]];
        self.urlStr = [NSString stringWithFormat:@"%@",obj];
    }];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.frame = CGRectZero;


    [self.view addSubview: self.webview];

    
    
    
    
    
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithImage:Image(@"icon_back") style:0 target:self action:@selector(back)];
    
    UIBarButtonItem *close = [[UIBarButtonItem alloc]initWithImage:Image(@"icon_close") style:0 target:self action:@selector(close)];
    
    self.navigationItem.leftBarButtonItems=@[back,close];
    
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(payBack:) name:@"payResult" object:nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wechatPayResult:) name:@"wechatPayResult" object:nil];

}
-(void)payBack:(NSNotification *)notification{
    NSDictionary  *object=[notification object];
    NSLog(@"%@",object);
    NSString *str = [self dicToJSONString:object];
    
    NSString *jsStr = [NSString stringWithFormat:@"setTimeout(function(){callback('%@');}, 1);",str];
    [self.webview stringByEvaluatingJavaScriptFromString:jsStr];

    
    
    
//    NSString *alertJS= [NSString stringWithFormat:@"%@('%@')",@"callback",@"12312312312"];
//    [jsContent evaluateScript:@"callback('123123')"];
    
//    long resultStatus=[object[@"resultStatus"]longLongValue];
//    switch (resultStatus) {
//        case 9000:
//        {
//            //支付成功
////            AddOrderSuccessViewController *vc=[AddOrderSuccessViewController new];
////            vc.order_sn=self.order_sn;
////            [self.navigationController pushViewController:vc animated:YES];
//        }
//            break;
//        case 8000:
//        {
////            [self backWithMessage:@"正在处理中"];
//        }
//            break;
//        case 4000:
//        {
////            [self backWithMessage:@"订单支付失败"];
//        }
//            break;
//        case 5000:
//        {
////            [self backWithMessage:@"重复请求"];
//        }
//            break;
//        case 6001:
//        {
////            [self backWithMessage:@"用户中途取消"];
//        }
//            break;
//        case 6002:
//        {
////            [self backWithMessage:@"网络连接出错"];
//        }
//            break;
//        case 6004:
//        {
////            [self backWithMessage:@"支付结果未知"];
//        }
//            break;
//        default:
//        {
////            [self backWithMessage:@"其它支付错误"];
//        }
//            break;
//    }
//
}
//微信支付成功通知
-(void)wechatPayResult:(NSNotification *)notification{
    NSDictionary  *object=[notification object];
    NSLog(@"%@",object);
    NSString *str = [self dicToJSONString:object];
    NSString *jsStr = [NSString stringWithFormat:@"setTimeout(function(){callback('%@');}, 1);",str];
    [self.webview stringByEvaluatingJavaScriptFromString:jsStr];
}

-(void)getWXPayOrder:(NSDictionary *)dict{
        //调起微信支付
        PayReq* req             = [[PayReq alloc] init];
        req.partnerId           = [dict objectForKey:@"partnerId"];
        req.prepayId            = [dict objectForKey:@"prepayId"];
        req.nonceStr            = [dict objectForKey:@"nonceStr"];
        req.timeStamp           = [[dict objectForKey:@"timeStamp"]intValue];
        req.package             = [dict objectForKey:@"packageValue"];
        req.sign                = [dict objectForKey:@"sign"];
        [WXApi sendReq:req];
}

-(void)getAliPayOrder:(NSString *)payOrder{
    
        NSString *appScheme = @"ali-pay-mmd";
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:payOrder fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
        }];
    
}



-(void)back{
    if ([_webview canGoBack]) {
        [_webview goBack];
    }else{
        [self close];
    }
}
-(void)close{
    [self.tabBarController.tabBar setHidden:NO];
    self.navigationController.tabBarController.selectedIndex=0;
    [self.navigationController popViewControllerAnimated:YES];
    // 返回后还要恢复
    self.tabBarController.tabBar.frame = CGRectMake(0, kScreenHeight - TAB_BAR_HEIGHT, kScreenWidth, TAB_BAR_HEIGHT);

}
-(void)home{
    [_webview loadRequest:[NSURLRequest requestWithURL:URL(self.urlStr)]];
}
-(void)webViewDidStartLoad:(UIWebView *)webView{
    [SVProgressHUD showWithStatus:@"载入中..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
    
    jsContent = [self.webview valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    
    self.title=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    
    
    AppJSObject *jsObject = [AppJSObject new];
    jsObject.delegate = self;
    jsContent[@"mmdSDK"] = jsObject;
    
    
    
}
-(void)invoke:(NSDictionary *)message{
    NSLog(@"%@",message);
    NSString *api = message[@"api"];
    if ([api isEqualToString:@"wxpay"]) {
        [self getWXPayOrder:message[@"params"]];
    }else{
        [self getAliPayOrder:message[@"params"]];
    }
}


//-(void)callback:(NSString *)json{
//    NSLog(@"%@",json);
//}




-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [SVProgressHUD dismiss];
}





-(UIWebView *)webview{
    if (!_webview) {
        _webview=[[UIWebView alloc]initWithFrame:Frame(0, 0, kScreenWidth, kScreenHeight-NavHeight)];
        _webview.delegate=self;
    }
    return _webview;
}

- (NSString *)dicToJSONString:(NSDictionary *)dic{
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic
                                                   options:NSJSONReadingMutableLeaves | NSJSONReadingAllowFragments
                                                     error:nil];
    
    if (data == nil) {
        return nil;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:data
                                                 encoding:NSUTF8StringEncoding];
    
    //    NSError *error = nil;
    //
    //    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    //    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    return jsonString;
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
