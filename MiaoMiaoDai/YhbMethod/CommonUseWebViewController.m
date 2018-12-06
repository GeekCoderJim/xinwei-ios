//
//  CommonUseWebViewController.m
//  SuXunTong
//
//  Created by 尤鸿斌 on 2017/8/18.
//  Copyright © 2017年 scan. All rights reserved.
//

#import "CommonUseWebViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
//#import "PublicRequst.h"
#import "RZRequest.h"

@interface CommonUseWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@property(strong,nonatomic)WKWebView *webview;
@end

@implementation CommonUseWebViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}
-(void)viewWillDisappear:(BOOL)animated{
    [AppUtils dismissHUD];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title=self.titleStr;
    [self webview];
    self.view=_webview;
    
    if ([_type isEqualToString:@"local"]) {
        NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"FindPassword" ofType:@"html"];
        NSString *html = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        [_webview loadHTMLString:html baseURL:baseURL];
    }else{
        NSURL *url = [NSURL URLWithString:self.urlStr];
        [_webview loadRequest:[NSURLRequest requestWithURL:url]];
        
    }
    
    UIBarButtonItem *closeBtn = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close)];

    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithImage:Image(@"icon_back") style:0 target:self action:@selector(goBack)];

    [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects: backBtn,closeBtn ,nil]];

}

-(void)close{
    [SVProgressHUD showWithStatus:@"正在刷新状态..."];
    [RZRequest getUserVerifyStatus:^(id obj) {
        [SVProgressHUD dismiss];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

-(void)goBack{
    if ([_webview canGoBack]) {
        [_webview goBack];
    }else{
        [SVProgressHUD showWithStatus:@"正在刷新状态..."];
        [RZRequest getUserVerifyStatus:^(id obj) {
            [SVProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [SVProgressHUD showWithStatus:@"载入中..."];
}
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [SVProgressHUD dismiss];
}
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    [SVProgressHUD showErrorWithStatus:@"载入失败，请退出重新进入"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    [SVProgressHUD dismiss];
    if ([self.type isEqualToString:@""]) {
        jsContent = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        self.title=[webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    }else{
    }
}

-(WKWebView *)webview{
    if (!_webview) {
        _webview=[[WKWebView alloc]initWithFrame:self.view.bounds];
        _webview.navigationDelegate=self;
    }
    return _webview;
}
- (void)dismiss:(id)sender {
    [SVProgressHUD dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
