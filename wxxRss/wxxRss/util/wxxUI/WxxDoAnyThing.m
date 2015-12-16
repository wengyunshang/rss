//
//  WxxDoAnyThing.m
//  wxxRss
//
//  Created by weng xiangxun on 15/5/14.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "WxxDoAnyThing.h"

@implementation WxxDoAnyThing
+(WxxDoAnyThing *)shared{
    static WxxDoAnyThing *_wxxHttpUtil = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!_wxxHttpUtil) {
            _wxxHttpUtil = [[WxxDoAnyThing alloc]init];
        }
    });
    return _wxxHttpUtil;
}

-(void)setViewShadow:(UIView*)v{
    v.layer.shadowPath = [UIBezierPath bezierPathWithRect:v.bounds].CGPath;
    v.layer.shadowOffset = CGSizeMake(0, 1);
    v.layer.shadowRadius = 2;
    v.layer.shadowColor = [UIColor blackColor].CGColor;
    v.layer.shadowOpacity = 0.7;
}
@end
