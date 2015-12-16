//
//  WxxWeaterView.m
//  WxxAccount
//
//  Created by weng xiangxun on 15/4/22.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "WxxWeaterView.h"

@interface WxxWeaterView ()
{
    UIColor *_currentWaterColor;
    
    float _currentLinePointY;
    float hgt;
    float a;
    float b;
    
    BOOL jia;
}
@end


@implementation WxxWeaterView


- (id)initWithFrame:(CGRect)frame color:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:color];
        
        a = 0.5;
        b = 0;
        jia = NO;
        hgt = 0;
        _currentWaterColor = WXXCOLOR(232, 171, 51, 1);//[UIColor colorWithRed:86/255.0f green:202/255.0f blue:139/255.0f alpha:1];
        _currentLinePointY = self.frame.size.height;
        
        [NSTimer scheduledTimerWithTimeInterval:0.04 target:self selector:@selector(animateWave) userInfo:nil repeats:YES];
        
    }
    return self;
}

-(void)sethgt:(float)hgtarg{
    hgt = hgtarg;
}

-(void)animateWave
{
    if (jia) {
        a += 0.01;
    }else{
        a -= 0.01;
    }
    
    
    if (a<=1) {
        jia = YES;
    }
    
    if (a>=1.5) {
        jia = NO;
    }
    
    
    b+=0.1;
    
    [self setNeedsDisplay];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    
    //画水
    CGContextSetLineWidth(context, 1);
    CGContextSetFillColorWithColor(context, [_currentWaterColor CGColor]);
    
    float y=_currentLinePointY;
    CGPathMoveToPoint(path, NULL, 0, y);
    for(float x=0;x<=self.frame.size.width;x++){
        y= a * sin( x/180*M_PI*2 + 4*b/M_PI ) * 5 + hgt;
        CGPathAddLineToPoint(path, nil, x, y);
    }
    
    CGPathAddLineToPoint(path, nil, 320, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, rect.size.height);
    CGPathAddLineToPoint(path, nil, 0, _currentLinePointY);
    
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextDrawPath(context, kCGPathStroke);
    CGPathRelease(path);
    
    
}
@end
