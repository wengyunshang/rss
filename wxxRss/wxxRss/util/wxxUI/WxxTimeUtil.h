//
//  WxxTimeUtil.h
//  WxxAccount
//
//  Created by weng xiangxun on 15/4/27.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    wxxyear, //年
    wxxmonth,//月
    wxxday,  //日
    wxxhour, //时
    wxxmin,  //分
    wxxsec,  //秒
}WxxTimeType; //侧栏
//hour = [comps hour];
//min = [comps minute];
//sec = [comps second];
@interface WxxTimeUtil : NSObject
+(NSString*)getNowTimeInterval;
//
+(NSString *)getTimeForTimeintercal:(NSString *)interval;
//时间字符串转时间戳
+(NSString *)getTimeintervalForStringDate:(NSString *)dateString;
//几小时前
+ (NSString *)timeInfoWithDateString:(NSString *)dateString;
//字符串时间格式转换成时间date
+(NSDate *)getDate4String:(NSString *)string;
//时间戳转时间
+(NSString*)getTimeintervalToDate:(NSString*)timeInterval;
//date转时间戳
+(NSString *)getDateTimeInterval:(NSDate*)date;
//当前时间
+(NSDate*)getNow;
//获取指定时间的年月日
+(int)getYMDToType:(WxxTimeType)type date:(NSDate*)date;
//距离现在是否大于1小时
+(BOOL)beforeOneHoursForTimeintercal:(NSString *)interval;
@end
