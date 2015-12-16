//
//  AddRssView.h
//  wxxRss
//
//  Created by weng xiangxun on 15/5/21.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddRssView : UIView<UITextFieldDelegate>
-(void)resignFirstRespond;
@property (nonatomic , copy) void (^setCallBack)();
-(void)showSelf;
-(void)hideSelf;
@end
