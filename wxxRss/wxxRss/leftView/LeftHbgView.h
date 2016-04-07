//
//  LeftHbgView.h
//  zouzhe2.2
//
//  Created by weng xiangxun on 15/3/17.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    setRemoveAd,
    setComment,
    setReStore,
    setCollect,
    setWebView,
    setHideRead,
    setAds,
}leftType;

@interface LeftHbgView : UIView<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate>

+ (LeftHbgView *)sharedLeftHbgView;
-(void)showSelf;
-(void)reflashInfo;
@end
