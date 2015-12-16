//
//  AppDelegate.h
//  wxxRss
//
//  Created by weng xiangxun on 15/5/11.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ViewController.h"
@interface SMAppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic,strong) ViewController *indexVC;
@property (nonatomic,strong)UINavigationController *linenv;
@property (strong, nonatomic) UIWindow *window;


@end