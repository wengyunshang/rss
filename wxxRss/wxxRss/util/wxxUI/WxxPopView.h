//
//  WxxPopView.h
//  ZWYPopKeyWords
//
//  Created by weng xiangxun on 14/12/23.
//  Copyright (c) 2014年 ZWY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WxxPopView : UIView{

}
+ (WxxPopView *)sharedWxxPopView;
-(void)showText:(NSString*)string;
-(void)showText:(NSString *)string yesBtn:(NSString*)yesStr;
-(void)showPopText:(NSString*)str;
-(void)showPopText:(NSString*)str time:(float)time;
@end
