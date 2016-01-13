//
//  WxxNetUTIL.h
//  ZWYPopKeyWords
//
//  Created by weng xiangxun on 14/12/27.
//  Copyright (c) 2014年 ZWY. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^WxxNetUTILLoadCallback)(id response);
@class RssData;
@interface WxxNetUTIL : NSObject

 + (WxxNetUTIL *)sharedWxxNetUTIL;
-(void)getBigClass:(WxxNetUTILLoadCallback)callback;
-(void)getLittleClass:(WxxNetUTILLoadCallback)callback;
-(void)getNewForClassId:(RssClassData*)rssclassData  callback:(WxxNetUTILLoadCallback)callback;
-(void)getTimelineNewForLastTimecallback:(WxxNetUTILLoadCallback)callback;
-(void)getBeforNewForClassId:(RssClassData*)rssclassData rssdata:(RssData *)rssdate  callback:(WxxNetUTILLoadCallback)callback;
-(BOOL)isOpen3g;
@end
