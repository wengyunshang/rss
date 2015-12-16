//
//  WxxRoundView.h
//  WxxAccount
//
//  Created by weng xiangxun on 15/4/22.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WxxRoundView : UIView<UIGestureRecognizerDelegate>
@property (nonatomic , copy) void (^callback)();
-(id)initWithFrame:(CGRect)frame color:(UIColor *)color font:(float)fontnum;
-(void)setbacklb:(NSString*)title;
-(void)settitle:(NSString*)title;
-(void)showself:(float)time;
-(void)hideself:(float)time;
@end
