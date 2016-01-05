//
//  BaseQueueData.m
//  wxxRss
//
//  Created by weng xiangxun on 15/5/18.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "BaseQueueData.h"
//#import "FMDatabaseQueue.h"
//#import "FMDatabase.h"
#define DBNAME @"db.sqlite"
@implementation BaseQueueData

+(FMDatabaseQueue *)getSharedInstance
{
    static FMDatabaseQueue *my_FMDatabaseQueue=nil;
    
    if (!my_FMDatabaseQueue) {
        
        my_FMDatabaseQueue = [FMDatabaseQueue databaseQueueWithPath:[self getDBPath]];
    }
//    NSLog(@"++++++++++++++++++++++++++++++++++++++:%@",my_FMDatabaseQueue);
    return my_FMDatabaseQueue;
}


+(NSString*)getDBPath{
    
        BOOL success;
        NSError *error;
        NSFileManager *fm = [NSFileManager defaultManager];
        NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        //NSLog(@"%@",documentsDirectory);
        NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:DBNAME];
        //	NSLog(@"数据库地址:%@",writableDBPath);
        //不备份到icloud
        
        
        success = [fm fileExistsAtPath:writableDBPath];
        
        //如果document下没有这个数据库，去根目录拷贝一分
        if(!success){
            /*------- CREATE SQL---------*/
            //        CREATE TABLE `dudu_user` (
            //                                  `uid` int(11) NOT NULL AUTO_INCREMENT,
            //                                  `uphone` varchar(32) DEFAULT NULL,
            //                                  `upassword` varchar(32) DEFAULT NULL,
            //                                  `uname` varchar(32) DEFAULT NULL,
            //                                  `usex` varchar(32) DEFAULT NULL,
            //                                  `uage` varchar(32) DEFAULT NULL,
            //                                  PRIMARY KEY (`uid`)
            //                                  ) ENGINE=InnoDB DEFAULT CHARSET=utf8
            
            NSString *defaultDBPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:DBNAME];
            //NSLog(@"%@",defaultDBPath);
            success = [fm copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
            if(!success){
                //			NSLog(@"error: %@", [error localizedDescription]);
            }else{
                NSURL *pathURL= [NSURL fileURLWithPath:writableDBPath];
                [self addSkipBackupAttributeToItemAtURL:pathURL];
            }
            success = YES;
        }
        return writableDBPath;
}
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    NSLog(@"%@",[URL path]);
    //    BOOL bb=    [[NSFileManager defaultManager] fileExistsAtPath: [URL path]];
    
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}


//+(BOOL)insertMsg:(NSString *)message
//{
//    FMDatabaseQueue * queue = [self getSharedInstance];
//    
//    [queue inDatabase:^(FMDatabase *db) {
//        [db open];
//        
//        BOOL res = [db executeUpdate:@""];
//        if (!res) {
//            NSLog(@"failed");
//        } else {
//            NSLog(@"success");
//        }
//        
//        [db close];
//    }];
//    return YES;
//    
//}


//+(BOOL)updateMsg:(EveryChatMessage *)message MsgTime:(NSString *)msgTime
//{
//    FMDatabaseQueue * queue = [MyFMDatabaseQueue getSharedInstance];
//    
//    [queue inDatabase:^(FMDatabase *db) {
//        [db open];
//        
//        BOOL res = [db executeUpdate:@"update chatmessage set msgsource_type=?,msg_type=?,content=?,sender=?,receiver=?,msgtime=?,msgissendsuc=?,read=?,systemtype=?,recordtime=? where msgtime=?",message.msgSource_type,message.msg_type,message.content,message.sender,message.receiver,message.msgTime,message.msgIsSendSuc,message.read,message.systemType,message.recordTime,msgTime];
//        if (!res) {
//            NSLog(@"failed");
//        } else {
//            NSLog(@"success");
//        }
//        
//        [db close];
//    }];
//    return YES;
//}

//- (IBAction)multithread:(id)sender {
//    FMDatabaseQueue * queue = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
//    dispatch_queue_t q1 = dispatch_queue_create("queue1", NULL);
//    dispatch_queue_t q2 = dispatch_queue_create("queue2", NULL);
//    
//    dispatch_async(q1, ^{
//        for (int i = 0; i < 100; ++i) {
//            [queue inDatabase:^(FMDatabase *db) {
//                NSString * sql = @"insert into user (name, password) values(?, ?) ";
//                NSString * name = [NSString stringWithFormat:@"queue111 %d", i];
//                BOOL res = [db executeUpdate:sql, name, @"boy"];
//                if (!res) {
//                    debugLog(@"error to add db data: %@", name);
//                } else {
//                    debugLog(@"succ to add db data: %@", name);
//                }
//            }];
//        }
//    });
//    
//    dispatch_async(q2, ^{
//        for (int i = 0; i < 100; ++i) {
//            [queue inDatabase:^(FMDatabase *db) {
//                NSString * sql = @"insert into user (name, password) values(?, ?) ";
//                NSString * name = [NSString stringWithFormat:@"queue222 %d", i];
//                BOOL res = [db executeUpdate:sql, name, @"boy"];
//                if (!res) {
//                    debugLog(@"error to add db data: %@", name);
//                } else {
//                    debugLog(@"succ to add db data: %@", name);
//                }
//            }];
//        }
//    });
//}
@end
