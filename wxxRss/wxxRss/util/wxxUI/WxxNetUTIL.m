//
//  WxxNetUTIL.m
//  ZWYPopKeyWords
//
//  Created by weng xiangxun on 14/12/27.
//  Copyright (c) 2014年 ZWY. All rights reserved.
//

#import "WxxNetUTIL.h"
#import "Reachability.h"
#import "WxxNetTBXMLUtil.h"
@interface WxxNetUTIL()
@end

@implementation WxxNetUTIL
static WxxNetUTIL *_sharedutil = nil;

+ (WxxNetUTIL *)sharedWxxNetUTIL{
    if (!_sharedutil) {
        _sharedutil = [[self alloc] init];
    }
    return _sharedutil;
}

/**
 *  获取某两个时间间隔内的新闻，   用处： 用户下拉到底部刷新的时候，最后一条数据的时间－－－－ （将要获取的数据） －－－－－－－－本地数据库离最后一条数据最近的时间
 *
 *  @param rssclassData 指定消息
 *  @param callback     回调
 */
-(void)getBeforNewForClassId:(RssClassData*)rssclassData rssdata:(RssData *)rssdata  callback:(WxxNetUTILLoadCallback)callback{
    
    //根据类别id  和 最后更新的时间获取最新数据
    NSString *righttime = [[PenSoundDao sharedPenSoundDao]selectRssLastTime4ClassIdandafterTime:rssclassData.rrcId rsstime:rssdata.rrpublished];
    NSString *lefttime = [[PenSoundDao sharedPenSoundDao]selectTime4Id:rssclassData.rrcId rsslink:rssdata.rrlink];
    NSLog(@"--%@",righttime);
    NSLog(@"--%@",lefttime);
    NSLog(@"--%@",rssclassData.rrcId);
    [SVHTTPRequest POST:httpurl(@"?c=newsapi&a=getprevnewlist4time")
             parameters:[NSDictionary dictionaryWithObjectsAndKeys:
                         rssclassData.rrcId,@"littleclassId",
                         lefttime,@"lefttime",   //左边时间
                         righttime,@"righttime",            //右边时间
                         nil]
             completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *errors) {
                 NSLog(@"%@",response);
                 NSArray *arr = response;
//                 rssclassData.rrcImage = @"";
                 if (arr) {
                     
                 }
                 if (arr.count>0) {
                     for (int i=0; i<arr.count; i++) {
                         RssData *rss = [[RssData alloc]init];
                         NSDictionary *dic = [arr objectAtIndex:i];
                         rss.rrtitle = [dic objectForKey:@"title"];
                         rss.rrid = [dic objectForKey:@"id"];
                         rss.rrauthor = [dic objectForKey:@"author"];
                         rss.rrcontent = [dic objectForKey:@"description"];
                         rss.rrlink = [dic objectForKey:@"link"];
                         rss.rrpublished = [dic objectForKey:@"pubdate"];
                         rss.rrclassid = rssclassData.rrcId;
                         //            rss.rrsummary = [TBXML textForElement:summary];
                         rss.rrupdated = [WxxTimeUtil getNowTimeInterval];
                         rss.rrimage = [[WxxNetTBXMLUtil shared]getImage:rss.rrcontent];//[dic objectForKey:@""];
//                         if ([rss.rrimage length]<=0 && [rss.rrimage length]>10) {
//                             rssclassData.rrcImage = rss.rrimage;
//                         }
                         [rss saveSelfToDB];
                     }
//                     [rssclassData updateSelf];
                     if (callback) {
                         callback(WXXSUCCESS);
                     }
                 }else{
                     if (callback) {
                         callback(WXXERROR);
                     }
                 }
                 // if we found a description
                 
             }];
}

-(void)getNewForClassId:(RssClassData*)rssclassData  callback:(WxxNetUTILLoadCallback)callback{
    
    //根据类别id  和 最后更新的时间获取最新数据
    NSString *lasttime = [[PenSoundDao sharedPenSoundDao]selectRssLastTime4ClassId:rssclassData.rrcId];
    [SVHTTPRequest POST:httpurl(@"?c=newsapi&a=getnewlist4classid")
            parameters:[NSDictionary dictionaryWithObjectsAndKeys:
                        rssclassData.rrcId,@"littleclassId",
                        lasttime,@"time",
                        nil]
            completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *errors) {
                NSLog(@"%@",response);
                NSArray *arr = response;
                
                if (arr.count>0) {
                    rssclassData.rrcImage = @"";
                    for (int i=0; i<arr.count; i++) {
                        RssData *rss = [[RssData alloc]init];
                        NSDictionary *dic = [arr objectAtIndex:i];
                        rss.rrtitle = [dic objectForKey:@"title"];
                        rss.rrid = [dic objectForKey:@"id"];
                        rss.rrauthor = [dic objectForKey:@"author"];
                        rss.rrcontent = [dic objectForKey:@"description"];
                        rss.rrlink = [dic objectForKey:@"link"];
                        rss.rrpublished = [dic objectForKey:@"pubdate"];
                        rss.rrclassid = rssclassData.rrcId;
                        //            rss.rrsummary = [TBXML textForElement:summary];
                        rss.rrupdated = [WxxTimeUtil getNowTimeInterval];
                        rss.rrimage = [[WxxNetTBXMLUtil shared]getImage:rss.rrcontent];//[dic objectForKey:@""];
                        if ([rssclassData.rrcImage length]<=0 && [rss.rrimage length]>10) {
                            rssclassData.rrcImage = rss.rrimage;
                        }
                        [rss saveSelfToDB];
                    }
                    if ([rssclassData.rrcImage length]>0) {
                        [rssclassData updateSelf];
                    }
                }
                if (callback) {
                    callback(@"");
                }
            }];
}


-(void)getTimelineNewForLastTimecallback:(WxxNetUTILLoadCallback)callback{
    
    //根据类别id  和 最后更新的时间获取最新数据
    NSString *lasttime = @"0";// [[PenSoundDao sharedPenSoundDao]selectRssLastTime4ClassId:rssclassData.rrcId];
    [SVHTTPRequest POST:httpurl(@"?c=newsapi&a=gettimelinenewlist4time")
             parameters:[NSDictionary dictionaryWithObjectsAndKeys:
                         lasttime,@"time",
                         nil]
             completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *errors) {
                 NSLog(@"%@",response);
                 NSArray *arr = response;
                 
                 if (arr.count>0) {
                     
                     for (int i=0; i<arr.count; i++) {
                         RssData *rss = [[RssData alloc]init];
                         NSDictionary *dic = [arr objectAtIndex:i];
                         rss.rrtitle = [dic objectForKey:@"title"];
                         rss.rrid = [dic objectForKey:@"id"];
                         rss.rrauthor = [dic objectForKey:@"author"];
                         rss.rrcontent = [dic objectForKey:@"description"];
                         rss.rrlink = [dic objectForKey:@"link"];
                         rss.rrpublished = [dic objectForKey:@"pubdate"];
//                         rss.rrclassid = rssclassData.rrcId;
                         //            rss.rrsummary = [TBXML textForElement:summary];
                         rss.rrupdated = [WxxTimeUtil getNowTimeInterval];
                         rss.rrimage = [[WxxNetTBXMLUtil shared]getImage:rss.rrcontent];//[dic objectForKey:@""];
                         
                         [rss saveSelfToDB];
                     }
                     
                 }
                 if (callback) {
                     callback(@"");
                 }
             }];
}


-(void)getBigClass:(WxxNetUTILLoadCallback)callback{
    [SVHTTPRequest GET:httpurl(@"?c=appapi&a=getBigClass")
            parameters:nil
            completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *errors) {
                NSLog(@"%@",response);
                for (int i=0; i<[response count]; i++) {
                    
                    NSDictionary *dic = [response objectAtIndex:i];
                    
                    RssBigClassData *rbData = [[RssBigClassData alloc]init];
                    rbData.rrbId = [dic objectForKey:@"id"];
                    rbData.rrbName = [dic objectForKey:@"name"];
                    rbData.rrbr = [dic objectForKey:@"r"];
                    rbData.rrbg = [dic objectForKey:@"g"];
                    rbData.rrbb = [dic objectForKey:@"b"];
                    [rbData saveSelfToDB];
                }
                if (callback) {
                    callback(@"");
                }
            }];
}

-(void)getLittleClass:(WxxNetUTILLoadCallback)callback{
//    getLittleClass / getLittleClassnewapi
    [SVHTTPRequest GET:httpurl(@"?c=appapi&a=getLittleClass")
            parameters:nil
            completion:^(id response, NSHTTPURLResponse *urlResponse, NSError *errors) {
                NSLog(@"%@",response);
                if (!response) {
                    return;
                }
                for (int i=0; i<[response count]; i++) {
                    
                    NSDictionary *dic = [response objectAtIndex:i];
                    if ([[dic objectForKey:@"ynapi"] intValue]==1) {
                        NSLog(@"adf");
                    }
                    RssClassData *rbData = [[RssClassData alloc]init];
                    rbData.rrcId = [dic objectForKey:@"id"];
                    rbData.rrcbigId = [dic objectForKey:@"bigClassId"];
                    rbData.rrcLink = [dic objectForKey:@"link"];
                    rbData.rrcName = [dic objectForKey:@"name"];
                    rbData.rrccheckselect = [dic objectForKey:@"checkselect"];
                    rbData.rrctime = [dic objectForKey:@"time"];
                    rbData.rrr = [[dic objectForKey:@"r"] length]>0?[dic objectForKey:@"r"]:@"1";
                    rbData.rrg = [[dic objectForKey:@"g"] length]>0?[dic objectForKey:@"r"]:@"1";
                    rbData.rrb = [[dic objectForKey:@"b"] length]>0?[dic objectForKey:@"r"]:@"1";
                    rbData.rrcynapi = [dic objectForKey:@"ynapi"];
                    if ([rbData.rrccheckselect isEqualToString:WXXYES]) { //如果分类是首页上架的为它加个排名 (首页的分类模块位置排名)
                        rbData.rrcrank = [NSString stringWithFormat:@"%d",([[PenSoundDao sharedPenSoundDao]selectMaxRssclassRank]+1)];//最大排名加1
                    }
                    [rbData saveSelfToDB];
                }
                if (callback) {
                    callback(@"");
                }
            }];
}

-(BOOL)isOpen3g
{
    BOOL isExistenceNetwork = TRUE;
    Reachability *r = [ Reachability reachabilityForInternetConnection];
    //    Reachability *r = [Reachability reachabilityWithHostName:@"http://www.baidu.com/"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork=TRUE;
            break;
        case ReachableViaWWAN:
            if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"3g"] boolValue]) {
                isExistenceNetwork=TRUE;
            }else{
                isExistenceNetwork = FALSE;//当前网络为流量网络，且关闭了流量下载
                
            }
            
            //   NSLog(@"正在使用3G网络");
            break;
        case ReachableViaWiFi:
            isExistenceNetwork=TRUE;
            //  NSLog(@"正在使用wifi网络");
            break;
    }
    if (!isExistenceNetwork) {
        //        UIAlertView *myalert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"网络不存在" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
        //        [myalert show];
        //        [myalert release];
    }
    return isExistenceNetwork;
}

@end
