//
//  RssClassData.m
//  wxxRss
//
//  Created by weng xiangxun on 15/5/12.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "RssClassData.h"

@implementation RssClassData
-(void)saveSelfToDB{
    
    return [[PenSoundDao sharedPenSoundDao]saveRssClass:self];
}

-(void)deleteSelf{
    [[PenSoundDao sharedPenSoundDao]deleteRssClass:self];
}

-(void)updateSelf{
    self.rrctime = [WxxTimeUtil getNowTimeInterval];
    [[PenSoundDao sharedPenSoundDao] updateRssClass:self];
}

-(void)refreshSelf{
    [[PenSoundDao sharedPenSoundDao]refreshRssClass:self];
}

-(void)updateCheck{
    //选中后，把时间设置为0 ， 首页刷新队列就会对这个rss加载
    self.rrctime = @"0";
    [[PenSoundDao sharedPenSoundDao] updateRssClassCheck:self];
}

//是否需要刷新
-(BOOL)ynNeedRefresh{
    //如果是自己api的新闻
    if ([self.rrcynapi intValue]==1) {
        return NO;
    }
    //大于一小时就刷新
    return [WxxTimeUtil beforeOneHoursForTimeintercal:self.rrctime];
}
@end
