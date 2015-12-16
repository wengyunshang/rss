//
//  BaseDao.m
//  SQLiteSample
//
//  Created by wang xuefeng on 10-12-29.
//  Copyright 2010 www.5yi.com. All rights reserved.
//

//#import "DB.h"
#import "BaseDao.h"
#import "FMDatabase.h"
#include <sys/xattr.h>
@interface BaseDao(hidden)

- (BOOL)connDatabase:(NSString *)dbName;

@end


@implementation BaseDao

@synthesize db;

- (BOOL)connDatabase:(NSString *)dbName
{
	BOOL success = YES;
	
	NSString *defaultDBPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:dbName];

	if(success){
		db = [FMDatabase databaseWithPath:defaultDBPath] ;
		if ([db open]) {
			[db setShouldCacheStatements:YES];
		}else{
			success = NO;
		}
	}

	return success;
}

//把数据库写入到Document文件夹，  注意：ios软件在document和cache文件夹才可以有写的权限，所以要放到document
-(void)createDobumentDB:(NSString *)dbName{

	NSString *defaultDBPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:dbName];
	
	NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	//NSLog(@"%@",documentsDirectory);
	NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:dbName];
	NSData *da = [NSData dataWithContentsOfFile:defaultDBPath];
	
	[da writeToFile:writableDBPath atomically:YES];
}

- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
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

//- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
//{
//    const char* filePath = [[URL path] fileSystemRepresentation];
//    
//    const char* attrName = "com.apple.MobileBackup";
//    u_int8_t attrValue = 1;
//    
//    int result = setxattr(filePath, attrName, &attrValue, sizeof(attrValue), 0, 0);
//    return result == 0;
//}


//获取打开document下的数据库
- (BOOL)connDOCDatabase:(NSString *)dbName
{
	BOOL success;
	NSError *error;
	NSFileManager *fm = [NSFileManager defaultManager];
	NSArray  *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	//NSLog(@"%@",documentsDirectory);
	NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:dbName];
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
        
		NSString *defaultDBPath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:dbName];
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
	
	if(success){
		db = [FMDatabase databaseWithPath:writableDBPath] ;
		if ([db open]) {
			[db setShouldCacheStatements:YES];
		}else{
//			NSLog(@"Failed to open database.");
			success = NO;
		}
	}
	
	return success;
}

- (void)closeDatabase
{
	[db close];
}

//document下的db
- (FMDatabase *)getDOCDatabase:(NSString *)dbName
{
    if (!dbName || [dbName length]<=0) {
        dbName = @"book.sqlite";
    }
	if ([self connDOCDatabase:dbName]){
		return db;
	}
	
	return NULL;
}

//跟目录下的db
- (FMDatabase *)getDatabase:(NSString *)dbName
{
	if ([self connDatabase:dbName]){
		return db;
	}
	
	return NULL;
}



-(NSString *)SQL:(NSString *)sql inTable:(NSString *)table {
	return [NSString stringWithFormat:sql, table];
}

//- (void)dealloc {
//	
//	
//	[super dealloc];
//}

@end