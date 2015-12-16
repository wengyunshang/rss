//
//  WxxBaseViewController.h
//  WxxAccount
//
//  Created by weng xiangxun on 15/4/22.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WxxBaseViewController : UIViewController
-(void)backColor;
-(UIBarButtonItem*) createBackButton;
-(UIBarButtonItem*) createHeadBbarbtn;
-(void)whiteBack;
-(UIBarButtonItem*) createRightbarbtn:(NSString*)imgstr action:(SEL)action;
-(UIBarButtonItem*) createTitlebtn:(NSString*)title action:(SEL)action;
@end
