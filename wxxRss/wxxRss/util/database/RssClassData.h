//
//  RssClassData.h
//  wxxRss
//
//  Created by weng xiangxun on 15/5/12.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "WxxBaseData.h"

#define rcId   @"id"       //
#define rcName   @"name" //
#define rcLink   @"link" //
#define rcImage @"image"
#define rcr @"r"
#define rcg @"g"
#define rcb @"b"
#define rctime @"time"
#define rccheckselect @"checkselect"
#define rcbigId @"bigId"
#define rcynapi @"ynapi"
#define rcrank @"rank"
@interface RssClassData : WxxBaseData
@property (nonatomic,strong)NSString *rrcId;
@property (nonatomic,strong)NSString *rrcName;
@property (nonatomic,strong)NSString *rrcLink;
@property (nonatomic,strong)NSString *rrcImage;
@property (nonatomic,strong)NSString *rrr;
@property (nonatomic,strong)NSString *rrg;
@property (nonatomic,strong)NSString *rrb;
@property (nonatomic,strong)NSString *rrctime;
@property (nonatomic,strong)NSString *rrccheckselect;
@property (nonatomic,strong)NSString *rrcbigId;
@property (nonatomic,strong)NSString *rrcynapi;
@property (nonatomic,strong)NSString *rrcrank;
-(void)updateCheck;
-(BOOL)ynNeedRefresh;
@end