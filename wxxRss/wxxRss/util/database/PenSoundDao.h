//
//  PenSoundDao.h
//  LearningMachine0.1
//
//  Created by Jenson on 11-2-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDao.h"
#import "BaseQueueData.h"
@class RssData;
@class RssClassData;
@class RssBigClassData;
@interface PenSoundDao : BaseDao {
    
}
+ (PenSoundDao *)sharedPenSoundDao;
-(void)saveRssClass:(RssClassData*)rsdata;
-(void)saveRss:(RssData*)rsdata;//保存一条新闻
-(NSMutableArray*)selectRssClassList;
-(NSMutableArray*)selectRssList:(NSString*)classId;
-(NSString*)selectRssCount4class:(NSString *)classid;
-(NSMutableArray*)selectRssCollectList:(NSString*)collect;
-(void)updateRssRead:(RssData*)rsdata;//已读
-(void)updateRssCollect:(RssData*)rsdata;//收藏
-(BOOL)ynCollect:(NSString *)link;
-(void)updateRssClassCheck:(RssClassData*)rsdata;
-(NSMutableArray*)selectAllRCList;
-(NSMutableArray*)selectBigClassList;
-(void)saveRssBigClass:(RssBigClassData*)rsdata;
-(NSMutableArray*)selectrssClassToBigId:(NSString *)bigId;
-(void)updateRssClass:(RssClassData*)rsdata;
-(RssClassData*)refreshRssClass:(RssClassData*)rsdata;
-(void)deleteRssClass:(RssClassData *)rsdata;
-(NSString *)selectNewMessageCountForRcid:(NSString*)rcid time:(NSString *)time;
-(int)selectMaxRssclassId;
-(NSString *)selectRssLastTime4ClassId:(NSString*)classId;
-(NSString *)selectRssLastTime4ClassIdandafterTime:(NSString*)classId rsstime:(NSString *)time;
-(NSString *)selectTime4Id:(NSString*)classId rsslink:(NSString *)rsslink;
-(int)selectMaxRssclassRank;
@end
