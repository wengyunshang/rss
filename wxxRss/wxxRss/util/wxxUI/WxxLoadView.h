//
//  WxxLoadView.h
//  ZWYPopKeyWords
//
//  Created by weng xiangxun on 14/12/27.
//  Copyright (c) 2014年 ZWY. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "SynthesizeSingleton.h"
@interface WxxLoadView : UIView
+ (WxxLoadView *)sharedWxxLoadView;
-(void)showself;
-(void)hideSelf;
@end
