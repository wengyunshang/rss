//
//  WxxTimeUtil.m
//  WxxAccount
//
//  Created by weng xiangxun on 15/4/27.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "WxxTimeUtil.h"
#import "NSDate+InternetDateTime.h"
@implementation WxxTimeUtil

+(NSDate *)getDate4String:(NSString *)string{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSDate *localDate = [dateFormatter dateFromString:string];
    return localDate;
}
+(NSString *)getDateTimeInterval:(NSDate*)date{
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}


+(NSString *)getTimeintervalForStringDate:(NSString *)dateString{
    
    NSDate *date = [NSDate dateFromInternetDateTimeString:dateString formatHint:DateFormatHintRFC3339];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}

+(NSString*)getTimeintervalToDate:(NSString*)timeInterval{
    
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[timeInterval longLongValue]];
    int hour = [self getYMDToType:wxxhour date:confromTimesp];
    int min  = [self getYMDToType:wxxmin date:confromTimesp];
    
    NSString *time = [NSString stringWithFormat:@"%d:%d",hour,min];
    if (min<10) {
        time = [NSString stringWithFormat:@"%d:0%d",hour,min];
    }
    return time;
}

+(NSDate*)getNow{
    return [NSDate date];
}

+(NSString*)getString4Date:(NSDate *)date{
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSString *currentDateStr1 = [dateFormatter1 stringFromDate:date];
    return currentDateStr1;
}

//获取指定时间的年月日
+(int)getYMDToType:(WxxTimeType)type date:(NSDate*)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    
    
    if (type == wxxyear) {
        NSInteger iCurYear = [components year];  // 年
        return (int)iCurYear;
    }else if (type == wxxmonth) {
        NSInteger iCurMonth = [components month];// 月
        return (int)iCurMonth;
    }else if (type == wxxday) {
        NSInteger iCurDay = [components day];    // 号
        return (int)iCurDay;
    }else if (type == wxxhour){
        NSInteger iCurDay = [components hour];    // 时
        return (int)iCurDay;
    }else if (type == wxxmin){
        NSInteger iCurDay = [components minute];    // 分
        return (int)iCurDay;
    }else if (type == wxxsec){
        NSInteger iCurDay = [components second];    // 秒
        return (int)iCurDay;
    }
    return 0;
}

+(NSDate *)getNowDate{
    NSDate *curDate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: curDate];
    NSDate *localeDate = [curDate  dateByAddingTimeInterval: interval];
    return localeDate;
}

+(NSString*)getNowTimeInterval{
    NSDate *date = [self getNowDate];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}

+(NSString*)getHHMM4Date:(NSDate *)date{
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"HH:mm"];
    NSString *currentDateStr1 = [dateFormatter1 stringFromDate:date];
    return currentDateStr1;
}

+(NSDate*)dateToLocalDate:(NSDate*)date{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}

+(NSString *)getTimeForTimeintercal:(NSString *)interval{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[interval longLongValue]];
    date = [self dateToLocalDate:date];
    
    NSDate *curDate = [self getNowDate];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
         NSTimeInterval retTime = 1.0;
    // 小于一小时
    if (time < 3600) {
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    }
    // 小于一天，也就是今天
    else if (time < 3600 * 24) {
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    }
    // 昨天
    else if (time < 3600 * 24 * 2) {
        return [NSString stringWithFormat:@"昨天 %@",[self getHHMM4Date:date]];
    }
   
    return [self getString4Date:date];
}


+(BOOL)beforeOneHoursForTimeintercal:(NSString *)interval{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[interval longLongValue]];
    NSDate *curDate = [self getNowDate];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    NSTimeInterval retTime = 1.0;
    // 小于一小时
    if (time < 3600) {
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return NO;
    }

    
    return YES;
}


+ (NSString *)timeInfoWithDateString:(NSString *)dateString {
    // 把日期字符串格式化为日期对象
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [NSDate dateFromInternetDateTimeString:dateString formatHint:DateFormatHintRFC3339];
    
    NSDate *curDate = [self getNowDate];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
//    NSDateComponents *components = [calendar components:unitFlags fromDate:date];
    
    
//    int month = (int)([curDate getMonth] - [date getMonth]);
//    int year = (int)([curDate getYear] - [date getYear]);
//    int day = (int)([curDate getDay] - [date getDay]);
    
    NSTimeInterval retTime = 1.0;
    // 小于一小时
    if (time < 3600) {
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    }
    // 小于一天，也就是今天
    else if (time < 3600 * 24) {
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    }
    // 昨天
    else if (time < 3600 * 24 * 2) {
        return [NSString stringWithFormat:@"昨天 %@",[self getHHMM4Date:date]];
    }
//    // 第一个条件是同年，且相隔时间在一个月内
//    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
//    else if ((abs(year) == 0 && abs(month) <= 1)
//             || (abs(year) == 1 && [curDate getMonth] == 1 && [date getMonth] == 12)) {
//        int retDay = 0;
//        // 同年
//        if (year == 0) {
//            // 同月
//            if (month == 0) {
//                retDay = day;
//            }
//        }
//        
//        if (retDay <= 0) {
//            // 这里按月最大值来计算
//            // 获取发布日期中，该月总共有多少天
//            int totalDays = [NSDate daysInMonth:(int)[date getMonth] year:(int)[date getYear]];
//            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
//            retDay = (int)[curDate getDay] + (totalDays - (int)[date getDay]);
//            
//            if (retDay >= totalDays) {
//                return [NSString stringWithFormat:@"%d个月前", (abs)(MAX(retDay / 31, 1))];
//            }
//        }
//        
//        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
//    } else  {
//        if (abs(year) <= 1) {
//            if (year == 0) { // 同年
//                return [NSString stringWithFormat:@"%d个月前", abs(month)];
//            }
//            
//            // 相差一年
//            int month = (int)[curDate getMonth];
//            int preMonth = (int)[date getMonth];
//            
//            // 隔年，但同月，就作为满一年来计算
//            if (month == 12 && preMonth == 12) {
//                return @"1年前";
//            }  
//            
//            // 也不看，但非同月  
//            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];  
//        }  
//        
//        return [NSString stringWithFormat:@"%d年前", abs(year)];  
//    }  
    
    return [self getString4Date:date];
}


@end
