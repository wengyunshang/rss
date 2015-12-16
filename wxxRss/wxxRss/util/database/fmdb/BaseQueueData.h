//
//  BaseQueueData.h
//  wxxRss
//
//  Created by weng xiangxun on 15/5/18.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabaseQueue.h"
@interface BaseQueueData : NSObject{
}

+(FMDatabaseQueue *)getSharedInstance;
@end
