//
//  AppDelegate.h
//  wxxRss
//
//  Created by weng xiangxun on 15/5/11.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GDTSplashAd.h"
#import "ViewController.h"
@interface SMAppDelegate : UIResponder <UIApplicationDelegate,GDTSplashAdDelegate>
@property (nonatomic,strong) ViewController *indexVC;
@property (nonatomic,strong)UINavigationController *linenv;
@property (strong, nonatomic) UIWindow *window;
@property (retain, nonatomic) GDTSplashAd *splash;
@property (retain, nonatomic) NSString *oldTime;
@end