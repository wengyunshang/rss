//
//  WxxNetTBXMLUtil.h
//  wxxRss
//
//  Created by weng xiangxun on 15/5/12.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^netCallBack)(id response);
@class RssClassData;
@interface WxxNetTBXMLUtil : NSObject

+ (WxxNetTBXMLUtil *)shared;
- (void)loadURL:(RssClassData *)rssClassData callback:(netCallBack)callback;
-(void)initClass;
-(NSString*)getImage:(NSString *)htmlString;
@end
