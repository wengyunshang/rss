//
//  WxxTextField.m
//  wxxRss
//
//  Created by weng xiangxun on 15/5/21.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "WxxTextField.h"

@implementation WxxTextField

//控制 placeHolder 的位置，左右缩 20
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 5 , 0 );
}

// 控制文本的位置，左右缩 20
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 5 , 0 );
}

@end
