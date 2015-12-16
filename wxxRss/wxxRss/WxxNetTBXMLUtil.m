//
//  WxxNetTBXMLUtil.m
//  wxxRss
//
//  Created by weng xiangxun on 15/5/12.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "WxxNetTBXMLUtil.h"
#import "TBXML.h"
#import "TBXML+HTTP.h"
@implementation NSString(StringRegular)


-(NSMutableArray *)substringByRegular:(NSString *)regular{
    
    NSString * reg=regular;
    
    NSRange r= [self rangeOfString:reg options:NSRegularExpressionSearch];
    
    NSMutableArray *arr=[NSMutableArray array];
    
    if (r.length != NSNotFound &&r.length != 0) {
        
//        int i=0;
        
        while (r.length != NSNotFound &&r.length != 0) {
            
            //            FCLOG(@"index = %i regIndex = %d loc = %d",(++i),r.length,r.location);
            
            NSString* substr = [self substringWithRange:r];
            
            //            FCLOG(@"substr = %@",substr);
            
            [arr addObject:substr];
            
            NSRange startr=NSMakeRange(r.location+r.length, [self length]-r.location-r.length);
            
            r=[self rangeOfString:reg options:NSRegularExpressionSearch range:startr];
        }
    }
    return arr;
}
@end
@interface WxxNetTBXMLUtil ()
//@property (nonatomic,strong)RssClassData *rssClassData;
@property (nonatomic,strong)NSString *img;
@end

@implementation WxxNetTBXMLUtil



static WxxNetTBXMLUtil *_sharedWxxNetTBXMLUtil = nil;
/**
 数据库采用单例模式: 不必每个地方去管理
 */
+ (WxxNetTBXMLUtil *)shared{
    if (!_sharedWxxNetTBXMLUtil) {
        _sharedWxxNetTBXMLUtil = [[self alloc]init];
    }
    return _sharedWxxNetTBXMLUtil;
}


-(void)initClass{
    //--资讯
//    http://wallstreetcn.com/rss.xml  华尔街见闻
//    http://rss.cnbeta.com/rss cnbeta
//    每日鲜果精选：http://xianguo.com/service/dailyshare
//网易新闻·有态度专栏：http://news.163.com/special/00011K6L/rss_newsattitude.xml
//    http://e.dili360.com/rss/rss.xml
    
    //－－科技
//   人人都是产品经理 http://www.woshipm.com/feed
//    http://www.zhihu.com/rss  知乎每日精选
//    科学松鼠会（科普）：http://songshuhui.net/feed
//    科学公园（分析各种误区）：http://www.scipark.net/feed/
//    泛科学（台湾的科普资讯）：http://pansci.tw/feed
//    Matrix67（数学爱好者）：http://www.matrix67.com/blog/feed.asp
//    月光博客：http://feed.williamlong.info/
//    微软亚洲研究院：http://blog.sina.com.cn/rss/1286528122.xml
//    善用佳软：http://feed.xbeta.info
//    锋客网：http://www.phonekr.com/feed/
//    极客公园：http://feeds.geekpark.net/
//    同步控：http://www.syncoo.com/feed
//    爱范儿：http://www.ifanr.com/feed
//    极客范：http://www.geekfan.net/feed/
//    九点科技 http://9.douban.com/rss/technology
    
    //--生活
//    美文日赏：http://meiwenrishang.com/rss
//    什么值得买：http://feed.smzdm.com
//    红酒世界网-精品文章 http://www.wine-world.com/articlerss/rss.aspx

    //---艺术设计
//    爱午茶：http://iwucha.com/feed/
//    Cinephilia迷影：http://cinephilia.net/feed
//    优设：http://www.uisdc.com/feed
    
    //阅读
//    一个：http://onehd.herokuapp.com/
//    读写人：http://www.duxieren.com/duxieren.xml
    
    RssClassData *sinaNBAdata = [[RssClassData alloc]init];
    sinaNBAdata.rrcLink = @"http://bleacherreport.com/articles/feed?tag_id=19";
    sinaNBAdata.rrcName = @"NBA";
    sinaNBAdata.rrr = @"0";
    sinaNBAdata.rrg = @"0";
    sinaNBAdata.rrb = @"0";
    sinaNBAdata.rrccheckselect = WXXYES;
    [sinaNBAdata saveSelfToDB];
    
    
    RssClassData *liaohai = [[RssClassData alloc]init];
    liaohai.rrcLink = @"http://cnpolitics.org/feed/";
    liaohai.rrcName = @"政见";
    liaohai.rrr = @"41";
    liaohai.rrg = @"127";
    liaohai.rrb = @"183";
    liaohai.rrccheckselect = WXXYES;
    [liaohai saveSelfToDB];
    
    RssClassData *sportsv = [[RssClassData alloc]init];
    sportsv.rrcLink = @"http://huuuaapp.duapp.com/index.php?c=comment&a=getCommentList";
    sportsv.rrcName = @"36kr";
    sportsv.rrr = @"0";
    sportsv.rrg = @"0";
    sportsv.rrb = @"0";
    sportsv.rrccheckselect = WXXYES;
    [sportsv saveSelfToDB];
    
    RssClassData *rcdata = [[RssClassData alloc]init];
    rcdata.rrcLink = @"http://www.guokr.com/rss/";
    rcdata.rrcName = @"果壳网";
    rcdata.rrr = @"0";
    rcdata.rrg = @"170";
    rcdata.rrb = @"238";
    rcdata.rrccheckselect = WXXYES;
    [rcdata saveSelfToDB];
//
   
    
    RssClassData *rcdata3 = [[RssClassData alloc]init];
    rcdata3.rrcLink = @"http://www.huxiu.com/rss/0.xml";
    rcdata3.rrcName = @"虎嗅";
    rcdata3.rrr = @"255";
    rcdata3.rrg = @"87";
    rcdata3.rrb = @"35";
    rcdata3.rrccheckselect = WXXYES;
    [rcdata3 saveSelfToDB];
    
//    RssClassData *dajia = [[RssClassData alloc]init];
//    dajia.rrcLink = @"http://hanhanone.sinaapp.com/feed/dajia";
//    dajia.rrcName = @"腾讯· 大家";
//    dajia.rrr = @"255";
//    dajia.rrg = @"87";
//    dajia.rrb = @"35";
//    [dajia saveSelfToDB];
    
    RssClassData *dajia2 = [[RssClassData alloc]init];
    dajia2.rrcLink = @"http://dajia.qq.com/api/rss/rssRender.php";
    dajia2.rrcName = @"腾讯· 大家";
    dajia2.rrr = @"255";
    dajia2.rrg = @"87";
    dajia2.rrb = @"35";
    dajia2.rrccheckselect = WXXYES;
    [dajia2 saveSelfToDB];
    
    
    
}


- (void)loadURL:(RssClassData *)rssClassData callback:(netCallBack)callback{
//    self.rssClassData = rssClassData;
    //请求成功回调
    TBXMLSuccessBlock successBlock = ^(TBXML *tbxmlDocument) {
        NSLog(@"....请求RSS成功....");
        if (tbxmlDocument.rootXMLElement)
            [self traverseElementrss:tbxmlDocument.rootXMLElement rcData:tbxmlDocument.rcData];
        
        if (callback) {
            callback(WXXSUCCESS);
        }
    };
    
    //请求失败回调
    TBXMLFailureBlock failureBlock = ^(TBXML *tbxmlDocument, NSError * error) {
        NSLog(@"....错误：! %@ %@", [error localizedDescription], [error userInfo]);
        if (callback) {
            callback(WXXERROR);
        }
    };
    
    //请求xml
    TBXML* tbxml = [[TBXML alloc] initWithURL:[NSURL URLWithString:rssClassData.rrcLink]
                                      success:successBlock
                                      failure:failureBlock];
    tbxml.rcData = rssClassData;
    
}

-(void) traverseElementrss:(TBXMLElement*)rootelement rcData:(RssClassData*)rcData{
    
    NSString *rootName = [TBXML elementName:rootelement];
    if ([rootName isEqualToString:@"feed"]) {
        
        TBXMLElement *entry = [TBXML childElementNamed:@"entry" parentElement:rootelement];
        [self rssXML:entry rcData:rcData];
        
    }else if([rootName isEqualToString:@"rss"]){
        TBXMLElement *entry = [TBXML childElementNamed:@"item" parentElement:[TBXML childElementNamed:@"channel" parentElement:rootelement]];

        [self rssXML:entry rcData:rcData];
    }
    
    NSLog(@"结束");
}

-(void)rssXML:(TBXMLElement*)entry rcData:(RssClassData *)rcData{
     rcData.rrcImage = @"";
    while (entry != nil) {
        
        TBXMLElement * title = [TBXML childElementNamed:@"title" parentElement:entry];
        TBXMLElement * enId = [TBXML childElementNamed:@"guid" parentElement:entry];
        TBXMLElement * published = [TBXML childElementNamed:@"pubDate" parentElement:entry];
        TBXMLElement * link = [TBXML childElementNamed:@"link" parentElement:entry];
        TBXMLElement * author = [TBXML childElementNamed:@"author" parentElement:entry];
        //        TBXMLElement * summary = [TBXML childElementNamed:@"summary" parentElement:entry];
        
        
        TBXMLElement * content = [TBXML childElementNamed:@"content:encoded" parentElement:entry];
        if (!content) {
            content = [TBXML childElementNamed:@"description" parentElement:entry];
        }

        // if we found a description
        
        if (title != nil) {
            // obtain the text from the description element
            NSLog(@"%@",[TBXML textForElement:title]);
            RssData *rss = [[RssData alloc]init];
            rss.rrtitle = [TBXML textForElement:title];
            rss.rrid = [TBXML textForElement:enId];
            rss.rrauthor = [TBXML textForElement:author];
            rss.rrcontent = [self htmlEntityDecode:[TBXML textForElement:content]];
            rss.rrlink = [TBXML textForElement:link];
            rss.rrpublished = [WxxTimeUtil getTimeintervalForStringDate:[TBXML textForElement:published]];
            rss.rrclassid = rcData.rrcId; //分类id
            //            rss.rrsummary = [TBXML textForElement:summary];
            rss.rrupdated = [WxxTimeUtil getNowTimeInterval];
            rss.rrimage = [self getImage:rss.rrcontent];
            [rss saveSelfToDB];
            
            entry = [TBXML nextSiblingNamed:@"item" searchFromElement:entry];
//            if (entry==nil) {
            //**********************把获取到的文章图片拷贝一个给本分类，用于主界面分类展示************************//
            if ([rcData.rrcImage length]<=0 && [rss.rrimage length]>10) {
                rcData.rrcImage = rss.rrimage;
            }
//            }
        }
        
        [rcData updateSelf];
    }
}
-(NSString *)htmlEntityDecode:(NSString *)string
{
    string = [string stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    string = [string stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    string = [string stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    string = [string stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    string = [string stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    
    //    <ol style="display:none;"
    string = [string stringByReplacingOccurrencesOfString:@"<ol" withString:@"<ol style=\"display:none; \""];
    
    return string;
}




-(NSString*)getImage:(NSString *)htmlString{
//    NSError *error = NULL;
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(<img\\s[\\s\\S]*?src\\s*?=\\s*?['\"](.*?)['\"][\\s\\S]*?>)+?"
//                                                                           options:NSRegularExpressionCaseInsensitive
//                                                                             error:&error];
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(<img\\s[\\s\\S]*?src\\s*?=\\s*?['\"](.*?)['\"][\\s\\S]*?>)+?"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSString *img = @"";
    if (htmlString) {
        NSArray *matches = [regex matchesInString:htmlString options:0 range:NSMakeRange(0, [htmlString length])];
        if ([matches count]>=2) {
            NSTextCheckingResult *match = [matches objectAtIndex:1];
            img = [htmlString substringWithRange:[match rangeAtIndex:2]] ;
        }else{
            NSTextCheckingResult *matche = [regex firstMatchInString:htmlString options:0 range:NSMakeRange(0, [htmlString length])];
            img = [htmlString substringWithRange:[matche rangeAtIndex:2]] ;
            if ([img length]>4) {
                NSString *s = [img substringFromIndex:[img length]-2];
                //        NSLog(@"%@",s);
                if (![s isEqualToString:@"/0"] ) {
                    
                }else{
                    img = @"";
                }
            }

        }
        
//        if ([img length]>4) {
//            NSString *s = [img substringFromIndex:[img length]-3];
//            //        NSLog(@"%@",s);
//            if ([s isEqualToString:@"jpg"] || [s isEqualToString:@"png"] ) {
//                
//            }else{
//                img = @"";
//            }
//        }
    }
  
    
//        for (NSTextCheckingResult *match in matches) {
//            
//            //        if ([img length]>4) {
//            //            NSString *s = [img substringFromIndex:[img length]-3];
//            //            //        NSLog(@"%@",s);
//            //            if ([s isEqualToString:@"jpg"] || [s isEqualToString:@"png"] ) {
//            //
//            //            }else{
//            //                img = @"";
//            //            }
//            //        }
//        }
    
    
    return img;
}

//-(void)feedXML:(TBXMLElement*)rootelement{
//    
//    TBXMLElement *entry = [TBXML childElementNamed:@"entry" parentElement:rootelement];
//    
//    while (entry != nil) {
//        
//        TBXMLElement * title = [TBXML childElementNamed:@"title" parentElement:entry];
//        TBXMLElement * enId = [TBXML childElementNamed:@"id" parentElement:entry];
//        TBXMLElement * updated = [TBXML childElementNamed:@"updated" parentElement:entry];
//        TBXMLElement * published = [TBXML childElementNamed:@"published" parentElement:entry];
//        TBXMLElement * link = [TBXML childElementNamed:@"link" parentElement:entry];
//        TBXMLElement * author = [TBXML childElementNamed:@"author" parentElement:entry];
//        TBXMLElement * summary = [TBXML childElementNamed:@"summary" parentElement:entry];
//        TBXMLElement * content = [TBXML childElementNamed:@"content" parentElement:entry];
//        // if we found a description
//        //        NSLog(@"%@",title);
//        if (title != nil) {
//            NSLog(@"%@",[TBXML textForElement:title]);
//            // obtain the text from the description element
//            RssData *rss = [[RssData alloc]init];
//            rss.rrtitle = [TBXML textForElement:title];
//            rss.rrid = [TBXML textForElement:enId];
//            rss.rrauthor = [TBXML textForElement:author];
//            rss.rrcontent = [self htmlEntityDecode:[TBXML textForElement:content]];
//            rss.rrlink = [TBXML valueOfAttributeNamed:@"href" forElement:link];
//            rss.rrpublished = [TBXML textForElement:published];
//            rss.rrsummary = [TBXML textForElement:summary];
//            rss.rrclassid = self.rssClassData.rrcId; //分类id
//            rss.rrupdated = [TBXML textForElement:updated];
//            rss.rrimage = [self getImage:rss.rrcontent];
//            [rss saveSelfToDB];
//            
//            self.rssClassData.rrcImage = rss.rrimage;
//            [self.rssClassData updateSelf];
//        }
//        entry = [TBXML nextSiblingNamed:@"entry" searchFromElement:entry];
//    }
//}
@end




