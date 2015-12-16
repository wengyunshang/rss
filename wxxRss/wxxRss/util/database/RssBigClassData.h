//
//  RssBigClassData.h
//  wxxRss
//
//  Created by weng xiangxun on 15/5/19.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "WxxBaseData.h"
#define rbId   @"id"       //
#define rbName   @"name" //
#define rbr   @"r" //
#define rbg   @"g" //
#define rbb   @"b" //
@interface RssBigClassData : WxxBaseData
@property (nonatomic,strong)NSString *rrbId;
@property (nonatomic,strong)NSString *rrbName;
@property (nonatomic,strong)NSString *rrbr;
@property (nonatomic,strong)NSString *rrbg;
@property (nonatomic,strong)NSString *rrbb;
@end
