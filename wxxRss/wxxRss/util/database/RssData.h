//
//  BillData.h
//  WxxAccount
//
//  Created by weng xiangxun on 15/4/27.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "WxxBaseData.h"

//TBXMLElement * title = [TBXML childElementNamed:@"title" parentElement:entry];
//TBXMLElement * enId = [TBXML childElementNamed:@"id" parentElement:entry];
//TBXMLElement * updated = [TBXML childElementNamed:@"updated" parentElement:entry];
//TBXMLElement * published = [TBXML childElementNamed:@"published" parentElement:entry];
//TBXMLElement * link = [TBXML childElementNamed:@"link" parentElement:entry];
//TBXMLElement * author = [TBXML childElementNamed:@"author" parentElement:entry];
//TBXMLElement * summary = [TBXML childElementNamed:@"summary" parentElement:entry];
//TBXMLElement * content = [TBXML childElementNamed:@"content" parentElement:entry];

#define rtitle     @"title"      //标题
#define rid        @"id"         // id
#define rclassid   @"rcid"       //分类id
#define rupdated   @"updated"    // 跟新时间，
#define rpublished @"published"  // 文章发布时间
#define rlink      @"link"       // 网址
#define rauthor    @"author"     //作者
#define rsummary   @"summary"    //简介
#define rcontent   @"content"    //内容
#define rread      @"read"       //是否已读 0未读 ／ 1已读
#define rimage     @"image"      //图片
#define rynread     @"ynread"      //是否已读
#define ryncollect     @"yncollect"      //是否收藏
@interface RssData : WxxBaseData
@property (nonatomic,strong)NSString *rrtitle;
@property (nonatomic,strong)NSString *rrid;
@property (nonatomic,strong)NSString *rrimage;
@property (nonatomic,strong)NSString *rrread;
@property (nonatomic,strong)NSString *rrclassid;
@property (nonatomic,strong)NSString *rrupdated;
@property (nonatomic,strong)NSString *rrpublished;
@property (nonatomic,strong)NSString *rrlink;
@property (nonatomic,strong)NSString *rrauthor;
@property (nonatomic,strong)NSString *rrsummary;
@property (nonatomic,strong)NSString *rrcontent;
@property (nonatomic,strong)NSString *rrynread;
@property (nonatomic,strong)NSString *rryncollect;

-(void)updateRead;
-(void)updateCollect;
-(BOOL)ynCollect;
@end
