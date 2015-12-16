//
//  BillData.m
//  WxxAccount
//
//  Created by weng xiangxun on 15/4/27.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "RssData.h"

@implementation RssData
//+ (id)initWithDictionary:(NSDictionary*)dic{
//    RssData *dbbdata = [[RssData alloc] initWithDictionary:dic];
//    return dbbdata;
//}


//
//- (id)initWithDictionary:(NSDictionary*)dic
//{
//    self = [super init];
//    if (self) {
//        self.bbday      = [dic objectForKey:bday];
//        self.bbid = [dic objectForKey:bid];
//        
//        self.bbtype = [dic objectForKey:btype];
//        self.bbmoney   = [dic objectForKey:bmoney];
//        self.bbmonth   = [dic objectForKey:bmonth];
//        self.bbtime  = [dic objectForKey:btime];
//        self.bbtitle = [dic objectForKey:btitle];
//        self.bbyear     = [dic objectForKey:byear];
//        self.bblocalid =  [dic objectForKey:blocalid];
//    }
//    return self;
//}



-(void)updateRead{
    
    [[PenSoundDao sharedPenSoundDao] updateRssRead:self];
}
-(void)updateCollect{
    
    [[PenSoundDao sharedPenSoundDao] updateRssCollect:self];
}

-(BOOL)ynCollect{
    return [[PenSoundDao sharedPenSoundDao] ynCollect:self.rrlink];
}

//保存本实体到本地
-(void)saveSelfToDB{
    
   return [[PenSoundDao sharedPenSoundDao]saveRss:self];
}
@end
