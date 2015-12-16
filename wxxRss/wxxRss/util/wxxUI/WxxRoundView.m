//
//  WxxRoundView.m
//  WxxAccount
//
//  Created by weng xiangxun on 15/4/22.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "WxxRoundView.h"
@interface WxxRoundView ()
@property (nonatomic,strong)WxxLabel *titleLb;
@property (nonatomic,strong)WxxLabel *backLb;
@end
@implementation WxxRoundView
- (id)initWithFrame:(CGRect)frame color:(UIColor *)color font:(float)fontnum
{
    self = [super initWithFrame:frame];
    if (self) {
        //        self.layer.masksToBounds = YES;
        self.backgroundColor = color;
        self.layer.cornerRadius = CGRectGetWidth(self.frame)/2;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 2;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOpacity = 0.6;
        self.layer.shadowPath =  [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CGRectGetWidth(self.frame)/2].CGPath;
//        self.layer.borderColor = WXXCOLOR(0, 0, 0, 1).CGColor;
//        self.layer.borderWidth = 1;
        
        self.backLb = [[WxxLabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) color:fontColor font:self.frame.size.height-15];
        self.backLb.textAlignment = NSTextAlignmentCenter;
        self.backLb.alpha = 0.2;
        self.backLb.text = @"￥";
        self.backLb.hidden = YES;
        [self addSubview:self.backLb];
        
        
        self.titleLb = [[WxxLabel alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)) color:fontColor font:fontnum];
        self.titleLb.textAlignment = NSTextAlignmentCenter;
        self.titleLb.text = @"0";
//        self.titleLb.backgroundColor = [UIColor blackColor];
        [self addSubview:self.titleLb];
        
        UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleFingerEvent:)];
        singleFingerOne.numberOfTouchesRequired = 1; //手指数
        singleFingerOne.numberOfTapsRequired = 1; //tap次数
        singleFingerOne.delegate = self;
        [self addGestureRecognizer:singleFingerOne];
    }
    return self;
}


-(void)showself:(float)time{
    if (time<=0) {
        time = 0.3;
    }
    [UIView animateWithDuration:time animations:^{
        self.alpha = 1;
    }completion:^(BOOL finished) {
        
    }];
}
-(void)hideself:(float)time{
    if (time<=0) {
        time = 0.3;
    }
    [UIView animateWithDuration:time animations:^{
        self.alpha = 0;
    }completion:^(BOOL finished) {
        
    }];
}


-(void)handleSingleFingerEvent:(UITapGestureRecognizer *)gestureRecognizer{
    //    CGPoint point = [gestureRecognizer locationInView:self];
    [UIView animateWithDuration:0.3 animations:^{
        self.titleLb.alpha = 0.4;
        self.alpha = 0.9;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
            self.titleLb.alpha = 1;
            self.alpha = 1;
        }completion:^(BOOL finished) {
            
        }];
    }];
    if (self.callback) {
        self.callback();
    }
}

-(void)setbacklb:(NSString*)title{
//    self.backLb.hidden = NO;
    self.backLb.text = title;
}
-(void)settitle:(NSString*)title{
    self.titleLb.text = title;
}
@end
