//
//  WxxWebViewController.h
//  wxxRss
//
//  Created by weng xiangxun on 15/5/18.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NJKWebViewProgress.h"
@interface WxxWebViewController : UIViewController<UIWebViewDelegate,NJKWebViewProgressDelegate>
-(void)initWebWithUrl:(NSString *)url title:(NSString *)title;
@end
