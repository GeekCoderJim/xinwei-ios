//
//  AppJSObject.h
//  MiaoMiaoDai
//
//  Created by 尤鸿斌 on 2018/9/24.
//  Copyright © 2018年 HongBin You. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol AppJSObjectDelegate <JSExport>

-(void)invoke:(NSDictionary *)message;
@end

@interface AppJSObject : NSObject<AppJSObjectDelegate>

@property(nonatomic,weak) id<AppJSObjectDelegate> delegate;

@end


