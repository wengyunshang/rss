//
//  WxxTipView.m
//  WxxAccount
//
//  Created by weng xiangxun on 15/4/24.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "WxxTipView.h"
@interface WxxTipView ()
@property (nonatomic,strong)WxxLabel *tipLb;
@end
@implementation WxxTipView
- (id)initWithFrame:(CGRect)frame color:(UIColor *)color text:(NSString*)text font:(float)font
{
    self = [super initWithFrame:frame];
    if (self) {
        //        self.layer.masksToBounds = YES;
        self.backgroundColor = color;
        
        
        
        
        
        self.tipLb = [[WxxLabel alloc]initWithFrame:CGRectMake(3, 3, 100, self.frame.size.height) color:fontColor font:font];
        self.tipLb.text = text;
        self.tipLb.backgroundColor = [UIColor clearColor];
        self.tipLb.textAlignment = NSTextAlignmentCenter;
//        self.tipLb.layer.cornerRadius = self.tipLb.frame.size.height/2;
//        self.tipLb.layer.masksToBounds = YES;
        [self addSubview:self.tipLb];
        [self.tipLb resetOneFrame];
        
        
//        [self.tipLb resetOneFrameToMoreWidth:18 moreHeight:12];
        
        CGRect rect = self.frame;
        rect.size.width = self.tipLb.frame.size.width+6;
        rect.size.height = self.tipLb.frame.size.height+6;
        self.frame = rect;
//        self.layer.cornerRadius = 2;
//        self.layer.shadowOffset = CGSizeMake(0, 0);
//        self.layer.shadowRadius = 2;
//        self.layer.shadowColor = [UIColor blackColor].CGColor;
//        self.layer.shadowOpacity = 0.6;
//        self.layer.shadowPath =  [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:CGRectGetWidth(self.frame)/2].CGPath;
        
    }
    return self;
}

-(void)setText:(NSString *)text{
    self.tipLb.text = text;
    [self.tipLb resetOneFrame];
    CGRect rect = self.frame;
    rect.size.width = self.tipLb.frame.size.width+6<16?23:self.tipLb.frame.size.width+6;
    rect.size.height = self.tipLb.frame.size.height+6;
    self.frame = rect;
}

-(void)setTipColor:(UIColor *)color{
    
    self.tipLb.textColor = color;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
