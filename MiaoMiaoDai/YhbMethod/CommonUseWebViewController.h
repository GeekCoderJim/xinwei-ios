//
//  CommonUseWebViewController.h
//  SuXunTong
//
//  Created by 尤鸿斌 on 2017/8/18.
//  Copyright © 2017年 scan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface CommonUseWebViewController : BaseViewController
{
    JSContext *jsContent;
}
@property(strong,nonatomic)NSString *titleStr;
@property(strong,nonatomic)NSString *urlStr;
@property(strong,nonatomic)NSString *type;
@property(strong,nonatomic)NSString *LocalFileName;
@end

