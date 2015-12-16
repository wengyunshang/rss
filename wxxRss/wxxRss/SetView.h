//
//  SetView.h
//  wxxRss
//
//  Created by weng xiangxun on 15/5/15.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#define fontlitte 15
#define fontmilllitte 18
#define fontbig 20
#define fontmaxbig 25
@interface SetView : UIView<UIGestureRecognizerDelegate>
@property (nonatomic , copy) void (^setCallBack)(setType type);
-(void)showSelf;
-(void)hideSelf;
@end
