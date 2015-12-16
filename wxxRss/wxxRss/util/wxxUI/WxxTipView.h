//
//  WxxTipView.h
//  WxxAccount
//
//  Created by weng xiangxun on 15/4/24.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WxxTipView : UIView
- (id)initWithFrame:(CGRect)frame color:(UIColor *)color text:(NSString*)text font:(float)font;
-(void)setTipColor:(UIColor *)color;
-(void)setText:(NSString *)text;
@end
