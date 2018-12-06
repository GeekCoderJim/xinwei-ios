//
//  QuickPayViewController.m
//  MiaoMiaoDai
//
//  Created by Mac on 2018/5/20.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import "QuickPayViewController.h"
#import <WebKit/WebKit.h>
#import "PublicRequest.h"

@interface QuickPayViewController ()<WKUIDelegate,WKNavigationDelegate>

@property(strong,nonatomic)WKWebView *webview;

@property(copy,nonatomic)NSString *urlStr;
@end

@implementation QuickPayViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([YhbMethods readBOOLUserDefault:@"isLogin"]==NO) {
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.webview.UIDelegate=self;
    self.webview.navigationDelegate=self;
    self.view = self.webview;
    
    
    [PublicRequest getQuickPayWebHost:^(id obj) {
        [_webview loadRequest:[NSURLRequest requestWithURL:URL(obj)]];
        self.urlStr = [NSString stringWithFormat:@"%@",obj];
    }];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"首页" style:0 target:self action:@selector(home)];
}
-(void)home{
    [_webview loadRequest:[NSURLRequest requestWithURL:URL(self.urlStr)]];
}
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"fail === %@",webView.URL.absoluteString);
}
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [SVProgressHUD showWithStatus:@"载入中..."];
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [SVProgressHUD dismiss];
}

//-(void)back{
//    if ([_webview canGoBack]) {
//        [_webview goBack];
//    }else{
//        if (![_webview.URL.absoluteString isEqualToString:self.urlStr]) {
//            [_webview loadRequest:[NSURLRequest requestWithURL:URL(self.urlStr)]];
//        }
//    }
//
//
//}



-(WKWebView *)webview{
    if (!_webview) {
        _webview=[[WKWebView alloc]initWithFrame:self.view.frame];
    }
    return _webview;
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
