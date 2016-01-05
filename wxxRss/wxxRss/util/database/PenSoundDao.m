
//  PenSoundDao.m
//  LearningMachine0.1
//
//  Created by Jenson on 11-2-28.
//  Copyright 2011 __MyCompanyName__. All rights reserved. 
#import "PenSoundDao.h" 
#import "FMResultSet.h"
#import "FMDatabase.h"
#define DBNAME @"db.sqlite"
#define rssdata @"rssdata"
#define rssclass @"rssclass"
#define rssBigClass @"rssBigClass"
@implementation PenSoundDao
static PenSoundDao *_sharedPenSoundDao = nil; 
/**
 数据库采用单例模式: 不必每个地方去管理
 */
+ (PenSoundDao *)sharedPenSoundDao{
    if (!_sharedPenSoundDao) {
        _sharedPenSoundDao = [[self alloc] init];
        
    }
    return _sharedPenSoundDao;
}

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

-(NSMutableArray*)selectRssCollectList:(NSString*)collect{
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
    __block NSMutableArray *infoArr = [[NSMutableArray alloc]init];
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
        
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where yncollect = %@ order by published desc",rssdata,collect];
        
        FMResultSet *rs = [wxxdb executeQuery:sql];
        while ([rs next]) {
            RssData *dbData = [[RssData alloc]init];
            
            dbData.rrauthor  = [rs stringForColumn:rauthor];
            dbData.rrclassid = [rs stringForColumn:rclassid];
            dbData.rrcontent = DECODEBase64String([rs stringForColumn:rcontent]);
            dbData.rrid      = [rs stringForColumn:rid];
            dbData.rrlink    = [rs stringForColumn:rlink];
            dbData.rrpublished = [WxxTimeUtil getTimeForTimeintercal:[rs stringForColumn:rpublished]];
            dbData.rrread    = [rs stringForColumn:rread];
            dbData.rrsummary = [rs stringForColumn:rsummary];
            dbData.rrtitle   = [rs stringForColumn:rtitle];
            dbData.rrupdated = [rs stringForColumn:rupdated];
            dbData.rrimage   = [rs stringForColumn:rimage];
            dbData.rrynread  = [rs stringForColumn:rynread];
            dbData.rryncollect = [rs stringForColumn:ryncollect];
            [infoArr addObject:dbData];
            
        }
        
        [wxxdb close];
    }];
    return infoArr;
}



-(NSMutableArray*)selectRssList:(NSString*)classId{
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
    __block NSMutableArray *infoArr = [[NSMutableArray alloc]init];
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
        BOOL lockedread = [[[NSUserDefaults standardUserDefaults] objectForKey:@"hideread"] boolValue];
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where rcid = %@ order by published desc",rssdata,classId];
        if (lockedread) {
            sql = [NSString stringWithFormat:@"select * from %@ where rcid = %@ and ynread = 0 order by published desc",rssdata,classId];
        }
        
        
        FMResultSet *rs = [wxxdb executeQuery:sql];
        while ([rs next]) {
            RssData *dbData = [[RssData alloc]init];
            
            dbData.rrauthor  = [rs stringForColumn:rauthor];
            dbData.rrclassid = [rs stringForColumn:rclassid];
            dbData.rrcontent = DECODEBase64String([rs stringForColumn:rcontent]);
            dbData.rrid      = [rs stringForColumn:rid];
            dbData.rrlink    = [rs stringForColumn:rlink];
            dbData.rrpublished = [WxxTimeUtil getTimeForTimeintercal:[rs stringForColumn:rpublished]];
            dbData.rrread    = [rs stringForColumn:rread];
            dbData.rrsummary = [rs stringForColumn:rsummary];
            dbData.rrtitle   = [rs stringForColumn:rtitle];
            dbData.rrupdated = [rs stringForColumn:rupdated];
            dbData.rrimage   = [rs stringForColumn:rimage];
            dbData.rrynread  = [rs stringForColumn:rynread];
            dbData.rryncollect = [rs stringForColumn:ryncollect];
            [infoArr addObject:dbData];
            
        }

        [wxxdb close];
    }];
    return infoArr;
    
//    [super getDOCDatabase:DBNAME];
//    //    asc(升序)/desc
//    NSString *sql = [NSString stringWithFormat:@"select * from %@ where rcid = %@ order by published desc",rssdata,classId];
//    
//    FMResultSet *rs = [db executeQuery:sql];
//    NSMutableArray *infoArr = [[NSMutableArray alloc]init];
//    
//    while ([rs next]) {
//        RssData *dbData = [[RssData alloc]init];
//        
//        dbData.rrauthor = [rs stringForColumn:rauthor];
//        dbData.rrclassid = [rs stringForColumn:rclassid];
//        dbData.rrcontent = DECODEBase64String([rs stringForColumn:rcontent]);
//         ;
//        dbData.rrid = [rs stringForColumn:rid];
//        dbData.rrlink = [rs stringForColumn:rlink];
//        dbData.rrpublished = [rs stringForColumn:rpublished];
//        dbData.rrread = [rs stringForColumn:rread];
//        dbData.rrsummary = [rs stringForColumn:rsummary];
//        dbData.rrtitle = [rs stringForColumn:rtitle];
//        dbData.rrupdated = [rs stringForColumn:rupdated];
//        dbData.rrimage = [rs stringForColumn:rimage];
//        [infoArr addObject:dbData];
//        
//    }
//    [super closeDatabase];
//    return infoArr;
}


//获取全部类别， 选中和未选中的
-(NSMutableArray*)selectBigClassList{
    
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
    __block NSMutableArray *infoArr = [[NSMutableArray alloc]init];
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
        
        NSString *sql = [NSString stringWithFormat:@"select * from %@",rssBigClass];
        
        FMResultSet *rs = [wxxdb executeQuery:sql];
        while ([rs next]) {
            RssBigClassData *dbData = [[RssBigClassData alloc]init];
            
            dbData.rrbId = [rs stringForColumn:rbId];
            
            dbData.rrbName = [rs stringForColumn:rbName];
            dbData.rrbr = [rs stringForColumn:rbr];
            dbData.rrbg = [rs stringForColumn:rbg];
            dbData.rrbb = [rs stringForColumn:rbb];
            [infoArr addObject:dbData];
            
        }
        
        [wxxdb close];
    }];
    return infoArr;
}


-(NSMutableArray*)selectrssClassToBigId:(NSString *)bigId{
    
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
    __block NSMutableArray *infoArr = [[NSMutableArray alloc]init];
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
        NSString *desc = @"asc";
        if ([bigId isEqualToString:@"0"]) {
            desc = @"desc";
        }
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where bigId = %@ order by id %@",rssclass,bigId,desc];
        
        FMResultSet *rs = [wxxdb executeQuery:sql];
        while ([rs next]) {
            RssClassData *dbData = [[RssClassData alloc]init];
            
            dbData.rrcName = [rs stringForColumn:rcName];
            dbData.rrcLink = [rs stringForColumn:rcLink];
            dbData.rrcId = [rs stringForColumn:rcId];
            dbData.rrcImage = [rs stringForColumn:rcImage];
            dbData.rrr = [rs stringForColumn:rcr];
            dbData.rrg = [rs stringForColumn:rcg];
            dbData.rrb = [rs stringForColumn:rcb];
            dbData.rrccheckselect = [rs stringForColumn:rccheckselect];
            dbData.rrctime = [rs stringForColumn:rctime];
            dbData.rrcbigId = [rs stringForColumn:rcbigId];
            dbData.rrcynapi = [rs stringForColumn:rcynapi];
            [infoArr addObject:dbData];
            
        }
        
        [wxxdb close];
    }];
    return infoArr;
}

//获取全部类别， 选中和未选中的
-(NSMutableArray*)selectAllRCList{
    
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
    __block NSMutableArray *infoArr = [[NSMutableArray alloc]init];
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
        
        NSString *sql = [NSString stringWithFormat:@"select * from %@",rssclass];
        
        FMResultSet *rs = [wxxdb executeQuery:sql];
        while ([rs next]) {
            RssClassData *dbData = [[RssClassData alloc]init];
            
            dbData.rrcName = [rs stringForColumn:rcName];
            dbData.rrcLink = [rs stringForColumn:rcLink];
            dbData.rrcId = [rs stringForColumn:rcId];
            dbData.rrcImage = [rs stringForColumn:rcImage];
            dbData.rrr = [rs stringForColumn:rcr];
            dbData.rrg = [rs stringForColumn:rcg];
            dbData.rrb = [rs stringForColumn:rcb];
            dbData.rrccheckselect = [rs stringForColumn:rccheckselect];
            dbData.rrctime = [rs stringForColumn:rctime];
            dbData.rrcbigId = [rs stringForColumn:rcbigId];
            dbData.rrcynapi = [rs stringForColumn:rcynapi];
            [infoArr addObject:dbData];
            
        }
        
        [wxxdb close];
    }];
    return infoArr;
}
//
//获取已订阅的类别
-(NSMutableArray*)selectRssClassList{
    
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
    __block NSMutableArray *infoArr = [[NSMutableArray alloc]init];
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
        
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where checkselect = %@ order by rank",rssclass,WXXYES];
        
        FMResultSet *rs = [wxxdb executeQuery:sql];
        while ([rs next]) {
            RssClassData *dbData = [[RssClassData alloc]init];
            dbData.rrcName = [rs stringForColumn:rcName];
            dbData.rrcLink = [rs stringForColumn:rcLink];
            dbData.rrcId = [rs stringForColumn:rcId];
            dbData.rrcImage = [rs stringForColumn:rcImage];
            dbData.rrr = [rs stringForColumn:rcr];
            dbData.rrg = [rs stringForColumn:rcg];
            dbData.rrb = [rs stringForColumn:rcb];
            dbData.rrcbigId = [rs stringForColumn:rcbigId];
            dbData.rrctime = [rs stringForColumn:rctime];
            dbData.rrccheckselect = [rs stringForColumn:rccheckselect];
            dbData.rrcynapi = [rs stringForColumn:rcynapi];
            dbData.rrcrank = [rs stringForColumn:rcrank];
            [infoArr addObject:dbData];
            
        }
        
        [wxxdb close];
    }];
    return infoArr;
}

-(RssClassData*)refreshRssClass:(RssClassData*)rsdata{
    
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
    __block RssClassData *dbData = [[RssClassData alloc]init];;
    
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
        
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where id = %@",rssclass,rsdata.rrcId];
        
        FMResultSet *rs = [wxxdb executeQuery:sql];
        
        while ([rs next]) {
            
            
            dbData.rrcName = [rs stringForColumn:rcName];
            dbData.rrcLink = [rs stringForColumn:rcLink];
            dbData.rrcId = [rs stringForColumn:rcId];
            dbData.rrcImage = [rs stringForColumn:rcImage];
            dbData.rrr = [rs stringForColumn:rcr];
            dbData.rrg = [rs stringForColumn:rcg];
            dbData.rrb = [rs stringForColumn:rcb];
            dbData.rrcbigId = [rs stringForColumn:rcbigId];
            dbData.rrcbigId = [rs stringForColumn:rcbigId];
            dbData.rrcynapi = [rs stringForColumn:rcynapi];
        }
        
        [wxxdb close];
    }];
    return dbData;
}

-(NSString *)selectNewMessageCountForRcid:(NSString*)rcid time:(NSString *)time{
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
    __block NSString *count = @"0";
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
        
        NSString *sql = [NSString stringWithFormat:@"select count(*) from %@ where ynread = '0' and rcid = '%@' and updated >= %d",rssdata,rcid,[time intValue]-120];
        
        FMResultSet *rs = [wxxdb executeQuery:sql];
        while ([rs next]) {
            
            count = [rs stringForColumn:@"count(*)"];
        }
        [wxxdb close];
    }];
    
    return count;
}

-(NSString *)selectTime4Id:(NSString*)classId rsslink:(NSString *)rsslink{
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
    __block NSString *time = @"0";
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
        
        NSString *sql = [NSString stringWithFormat:@"select published from %@ where rcid = '%@' and link = '%@'",rssdata,classId,rsslink];
        
        FMResultSet *rs = [wxxdb executeQuery:sql];
        while ([rs next]) {
            
            time = [rs stringForColumn:@"published"];
        }
        [wxxdb close];
    }];
    if (!time) {
        time = @"0";
    }
    return time;
}


//根据类别和某条rss新闻的时间查询前一条新闻的时间
-(NSString *)selectRssLastTime4ClassIdandafterTime:(NSString*)classId rsstime:(NSString *)time{
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
    __block NSString *lasttime = @"0";
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
        
        NSString *sql = [NSString stringWithFormat:@"select max(published) from %@ where rcid = '%@' and published < time",rssdata,classId];
        
        FMResultSet *rs = [wxxdb executeQuery:sql];
        while ([rs next]) {
            
            lasttime = [rs stringForColumn:@"max(published)"];
        }
        [wxxdb close];
    }];
    if (!lasttime) {
        lasttime = @"0";
    }
    return lasttime;
}

//根据类别ID获取最后更新的那条数据时间
-(NSString *)selectRssLastTime4ClassId:(NSString*)classId{
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
    __block NSString *lasttime = @"0";
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
        
        NSString *sql = [NSString stringWithFormat:@"select max(published) from %@ where rcid = '%@'",rssdata,classId];
        
        FMResultSet *rs = [wxxdb executeQuery:sql];
        while ([rs next]) {
            
            lasttime = [rs stringForColumn:@"max(published)"];
        }
        [wxxdb close];
    }];
    if (!lasttime) {
        lasttime = @"0";
    }
    return lasttime;
}

//
//
-(BOOL)ynhaveRssClass:(NSString *)link{
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
    __block NSString *count = @"0";
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
        
        NSString *sql = [NSString stringWithFormat:@"select count(*) from %@ where link = '%@'",rssclass,link];
        
        FMResultSet *rs = [wxxdb executeQuery:sql];
        while ([rs next]) {
            
            count = [rs stringForColumn:@"count(*)"];
        }
        [wxxdb close];
    }];
    
    if ([count intValue]>0) {
        return YES;
    }
    return  NO;
    
    
//    [super getDOCDatabase:DBNAME];
//    
//    NSString *sql = [NSString stringWithFormat:@"select count(*) from %@ where link = '%@'",rssclass,link];
//    
//    FMResultSet *rs = [db executeQuery:sql];
//    
//    NSString *bookIds = nil;
//    while ([rs next]) {
//        
//        bookIds = [rs stringForColumn:@"count(*)"];
//    }
//    [super closeDatabase];
//    if ([bookIds intValue]>0) {
//        return YES;
//    }
//    return NO;
}

//#define rcId   @"id"       //
//#define rcName   @"name" //
//#define rcLink   @"link" //
//#define rcImage @"image"
//#define rcr @"r"
//#define rcg @"g"
//#define rcb @"b"
//#define rctime @"time"
//#define rccheckselect @"checkselect"
//#define rcbigId @"bigId"
-(void)updateRssClass:(RssClassData*)rsdata{
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
    //    UPDATE 表名称 SET 列名称 = 新值 WHERE 列名称 = 某值
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET image='%@' , time = '%@', rank = '%@' WHERE id = %@",rssclass,
                         rsdata.rrcImage,
                         rsdata.rrctime,
                         rsdata.rrcrank,
                         rsdata.rrcId];
        
        BOOL res = [wxxdb executeUpdate:sql];
        if (!res) {
            NSLog(@"failed");
        } else {
//            NSLog(@"success");
        }
        
        [wxxdb close];
    }];
}



-(void)deleteRssClass:(RssClassData *)rsdata{
    
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
    //    UPDATE 表名称 SET 列名称 = 新值 WHERE 列名称 = 某值
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
//        NSString *sql = [NSString stringWithFormat:@"DELETE FROM %@ WHERE id = %@",rssclass,
//                         rsdata.rrcId];
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET checkselect='%@' WHERE id = %@",rssclass,
                         @"0",
                         rsdata.rrcId];
        BOOL res = [wxxdb executeUpdate:sql];
        if (!res) {
            NSLog(@"failed");
        } else {
//            NSLog(@"success");
        }
        
        [wxxdb close];
    }];
}

-(void)updateRssClassCheck:(RssClassData*)rsdata{
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
    //    UPDATE 表名称 SET 列名称 = 新值 WHERE 列名称 = 某值
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET time = %@ , checkselect = %@ WHERE id = %@",rssclass,
                         rsdata.rrctime,rsdata.rrccheckselect,rsdata.rrcId];

        BOOL res = [wxxdb executeUpdate:sql];
        if (!res) {
            NSLog(@"failed");
        } else {
//            NSLog(@"success");
        }
        
        [wxxdb close];
    }];
}
//
-(int)selectMaxRssclassId{
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
    __block int maxid = 10000;
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
        
        NSString *sql = [NSString stringWithFormat:@"select max(id) from %@",rssclass];
        
        FMResultSet *rs = [wxxdb executeQuery:sql];
        while ([rs next]) {
            
            maxid = [rs intForColumn:@"max(id)"];
        }
        [wxxdb close];
    }];
    if (maxid<10000) {
        maxid = 10000;
    }
    return  maxid;
}

//查询最大的rank (rank是首页的位置排行)
-(int)selectMaxRssclassRank{
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
    __block int maxid = 0;
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
        
        NSString *sql = [NSString stringWithFormat:@"select max(rank) from %@",rssclass];
        
        FMResultSet *rs = [wxxdb executeQuery:sql];
        while ([rs next]) {
            
            maxid = [rs intForColumn:@"max(rank)"];
        }
        [wxxdb close];
    }];
    
    return  maxid;
}

-(void)saveRssClass:(RssClassData*)rsdata{
    if (![self ynhaveRssClass:rsdata.rrcLink]) {
        
        FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
        
        [queue inDatabase:^(FMDatabase *wxxdb) {
            [wxxdb open];
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO  %@ (id,name,link,image,r,g,b,time,checkselect,bigId,ynapi,rank) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",rssclass,
                             rsdata.rrcId,
                             rsdata.rrcName!=nil?rsdata.rrcName:@"",
                             rsdata.rrcLink!=nil?rsdata.rrcLink:@"",
                             rsdata.rrcImage!=nil?rsdata.rrcImage:@"",
                             rsdata.rrr!=nil?rsdata.rrr:@"1",
                             rsdata.rrg!=nil?rsdata.rrg:@"1",
                             rsdata.rrb!=nil?rsdata.rrb:@"1",
                             @"0",
                             rsdata.rrccheckselect,
                             rsdata.rrcbigId,
                             rsdata.rrcynapi,
                             rsdata.rrcrank];

            
            BOOL res = [wxxdb executeUpdate:sql];
            if (!res) {
                NSLog(@"failed");
            } else {
//                NSLog(@"success");
            }
            
            [wxxdb close];
        }];
         
    }else{
        
//        FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
//        
//        [queue inDatabase:^(FMDatabase *wxxdb) {
//            [wxxdb open];
//            NSString *sql = [NSString stringWithFormat:@"update %@ set name='%@',link='%@',r='%@',g='%@',b='%@',checkselect='%@',bigId='%@' where link = '%@' and bigid= '%@'",rssclass,
//                             rsdata.rrcName!=nil?rsdata.rrcName:@"",
//                             rsdata.rrcLink!=nil?rsdata.rrcLink:@"",
//                             rsdata.rrr!=nil?rsdata.rrr:@"1",
//                             rsdata.rrg!=nil?rsdata.rrg:@"1",
//                             rsdata.rrb!=nil?rsdata.rrb:@"1",
//                             rsdata.rrccheckselect,
//                             rsdata.rrcbigId,
//                             rsdata.rrcLink,
//                             rsdata.rrcbigId];
//            
//            
//            BOOL res = [wxxdb executeUpdate:sql];
//            if (!res) {
//                NSLog(@"failed");
//            } else {
//                NSLog(@"success");
//            }
//            
//            [wxxdb close];
//        }];

    }
}
//
-(NSString*)selectRssCount4class:(NSString *)classid{
    
    
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
    __block NSString *count = @"0";
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
        
        NSString *sql = [NSString stringWithFormat:@"select count(*) from %@ where rcid = '%@'",rssdata,classid];
        
        FMResultSet *rs = [wxxdb executeQuery:sql];
        while ([rs next]) {
            
            count = [rs stringForColumn:@"count(*)"];
        }
        [wxxdb close];
    }];
    return  count;
    
//    [super getDOCDatabase:DBNAME];
//    
//    NSString *sql = [NSString stringWithFormat:@"select count(*) from %@ where rcid = '%@'",rssdata,classid];
//    
//    FMResultSet *rs = [db executeQuery:sql];
//    
//    NSString *count = @"0";
//    while ([rs next]) {
//        
//        count = [rs stringForColumn:@"count(*)"];
//    }
//    [super closeDatabase];
//    return  count;
}

-(void)saveRss:(RssData*)rsdata{
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
    
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
        NSString *sql = [NSString stringWithFormat:@"INSERT INTO  %@ (title,rcid,updated,published,link,author,summary,content,image,ynread,yncollect) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",rssdata,
                         rsdata.rrtitle!=nil?rsdata.rrtitle:@"",
                         rsdata.rrclassid!=nil?rsdata.rrclassid:@"",
                         rsdata.rrupdated!=nil?rsdata.rrupdated:@"0",
                         rsdata.rrpublished!=nil?rsdata.rrpublished:@"0",
                         rsdata.rrlink!=nil?rsdata.rrlink:@"",
                         rsdata.rrauthor!=nil?rsdata.rrauthor:@"",
                         rsdata.rrsummary!=nil?rsdata.rrsummary:@"",
                         ENCODEBase64String(rsdata.rrcontent!=nil?rsdata.rrcontent:@""),
                         rsdata.rrimage!=nil?rsdata.rrimage:@"",
                         WXXNO,//ynread 默认为0
                         WXXNO];//yncollect 默认为0

        BOOL res = [wxxdb executeUpdate:sql];
        if (!res) {
            NSLog(@"failed");
        } else {
//            NSLog(@"success");
        }
        
        [wxxdb close];
    }];
    
    
//    [super getDOCDatabase:DBNAME];
//    
//    NSString *sql = [NSString stringWithFormat:@"INSERT INTO  %@ (title,rcid,updated,published,link,author,summary,content,image) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@')",rssdata,
//                     rsdata.rrtitle!=nil?rsdata.rrtitle:@"",
//                     rsdata.rrclassid!=nil?rsdata.rrclassid:@"",
//                     [WxxTimeUtil getTimeintervalForStringDate:rsdata.rrupdated!=nil?rsdata.rrupdated:@""],
//                     [WxxTimeUtil getTimeintervalForStringDate:rsdata.rrpublished!=nil?rsdata.rrpublished:@""],
//                     rsdata.rrlink!=nil?rsdata.rrlink:@"",
//                     rsdata.rrauthor!=nil?rsdata.rrauthor:@"",
//                     rsdata.rrsummary!=nil?rsdata.rrsummary:@"",
//                     ENCODEBase64String(rsdata.rrcontent!=nil?rsdata.rrcontent:@""),
//                     rsdata.rrimage!=nil?rsdata.rrimage:@""];
////    NSLog(@"%@",sql);
//    [db executeUpdate:sql];
//    if ([db hadError]) {
//        NSLog(@"添加错误 请到这里(isnertNewCategory:)断点测试");
//    }
//    [super closeDatabase];
    
    
}

-(BOOL)ynCollect:(NSString *)link{
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
    __block NSString *yncollect = @"0";
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
        
        NSString *sql = [NSString stringWithFormat:@"select yncollect from %@ where link = '%@'",rssdata,link];
        
        FMResultSet *rs = [wxxdb executeQuery:sql];
        while ([rs next]) {
            
            yncollect = [rs stringForColumn:@"yncollect"];
        }
        [wxxdb close];
    }];
    
    if ([yncollect isEqualToString:WXXYES]) {
        return YES;
    }
    return  NO;
}

-(void)updateRssCollect:(RssData*)rsdata{
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
    //    UPDATE 表名称 SET 列名称 = 新值 WHERE 列名称 = 某值
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET yncollect = %@ WHERE link = '%@'",rssdata,
                         rsdata.rryncollect,rsdata.rrlink];
        
        BOOL res = [wxxdb executeUpdate:sql];
        if (!res) {
            NSLog(@"failed");
        } else {
//            NSLog(@"success");
        }
        
        [wxxdb close];
    }];
}
-(void)updateRssRead:(RssData*)rsdata{
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
//    UPDATE 表名称 SET 列名称 = 新值 WHERE 列名称 = 某值
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
        NSString *sql = [NSString stringWithFormat:@"UPDATE %@ SET ynread = %@ WHERE link = '%@'",rssdata,
                         rsdata.rrynread,rsdata.rrlink];
        
        BOOL res = [wxxdb executeUpdate:sql];
        if (!res) {
            NSLog(@"failed");
        } else {
//            NSLog(@"success");
        }
        
        [wxxdb close];
    }];
}


-(BOOL)ynhaveRssBigClass:(NSString *)bigid{
    FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
    __block NSString *count = @"0";
    [queue inDatabase:^(FMDatabase *wxxdb) {
        [wxxdb open];
        
        NSString *sql = [NSString stringWithFormat:@"select count(*) from %@ where id = '%@'",rssBigClass,bigid];
        
        FMResultSet *rs = [wxxdb executeQuery:sql];
        while ([rs next]) {
            
            count = [rs stringForColumn:@"count(*)"];
        }
        [wxxdb close];
    }];
    
    if ([count intValue]>0) {
        return YES;
    }
    return  NO;
}
-(void)saveRssBigClass:(RssBigClassData*)rsdata{
    if (![self ynhaveRssBigClass:rsdata.rrbId]) {
    
        FMDatabaseQueue * queue = [BaseQueueData getSharedInstance];
        
        [queue inDatabase:^(FMDatabase *wxxdb) {
            [wxxdb open];
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO  %@ (id,name,r,g,b) VALUES ('%@','%@','%@','%@','%@')",rssBigClass,
                             rsdata.rrbId,
                             rsdata.rrbName,
                             rsdata.rrbr,
                             rsdata.rrbg,
                             rsdata.rrbb];
            
            
            BOOL res = [wxxdb executeUpdate:sql];
            if (!res) {
                NSLog(@"failed");
            } else {
//                NSLog(@"success");
            }
            
            [wxxdb close];
        }];
        
    }
}

@end

