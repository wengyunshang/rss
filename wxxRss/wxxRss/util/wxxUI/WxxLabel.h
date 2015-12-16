//
//  WxxLabel.h
//  WxxAccount
//
//  Created by weng xiangxun on 15/4/22.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WxxLabel : UILabel
@property(nonatomic) UIEdgeInsets insets;
- (id)initWithFrame:(CGRect)frame color:(UIColor*)color font:(float)fontnum;

-(id) initWithFrame:(CGRect)frame andInsets: (UIEdgeInsets) insets;
-(id) initWithInsets: (UIEdgeInsets) insets;
//多行
-(void)resetMoreLineFrame;
//单行
-(void)resetOneFrame;
//单行 ＋高度和宽度
-(void)resetOneFrameToMoreWidth:(float)moreWidth moreHeight:(float)moreHeight;
//单行 居右并间隔右边多少
-(void)resetLineFrameWithRight:(float)maxWidth rightOrg:(float)rightOrgx;
@end
