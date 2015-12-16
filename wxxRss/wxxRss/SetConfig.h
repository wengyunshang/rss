//
//  SetConfig.h
//  DontTry
//
//  Created by weng xiangxun on 13-1-15.
//  Copyright (c) 2013年 weng xiangxun. All rights reserved.
//

#import <Foundation/Foundation.h> 
//*************加密*******************
#import "SecurityUtil.h"
#import "WxxNetUTIL.h"
#define ENCODEBase64String(str) [SecurityUtil encodeBase64String:str]
#define DECODEBase64String(str) [SecurityUtil decodeBase64String:str]
typedef enum{
    setColorWhite,
    setColorBlack,
    setColorGreen,
    setColorSepia,
    setFontLittle,
    setFontMillLittle,
    setFontBig,
    setFontMaxBig,
    setFontFamilyMis,
    setFontFamilySong,
    setHelveticaNeueThin,
}setType;

#define tabHeight 100
#define HEADRUL @"headurl"
#define WXXYES @"1"
#define WXXNO @"0"
#define showAlert(atitle,amessage) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:atitle message:amessage delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];[alert show];
#define WXXNETUTIL [WxxNetUTIL sharedWxxNetUTIL] //网络http接口单例
#define WXXNSLOG(str)  NSLog(str)

//*************加密*******************
#define ENCODEBase64String(str) [SecurityUtil encodeBase64String:str]
#define DECODEBase64String(str) [SecurityUtil decodeBase64String:str]


//****************返回值判定**************************************//
#define WXXERROR @"error"
#define WXXSUCCESS @"success"
#define WXXBACKSUCCESS(dic) [[dic objectForKey:@"back"] isEqualToString:SUCCESS] //返回值正确判断
#define WXXBACKERROR(dic) [[dic objectForKey:@"back"] isEqualToString:ERROR]  //返回值错误判断

#define USERDATA [UserData sharedUserData]  //用户
#define WXXCOLOR(r,g,b,alp) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:alp]
#define fontTTFToSize(sizes) [UIFont fontWithName:@"STHeitiSC-Light" size:sizes]
#define fontTTFBOLDToSize(sizes) [UIFont fontWithName:@"STHeitiSC-Light" size:sizes]
#define fontToSize(sizes) [UIFont fontWithName:@"STHeitiSC-Light" size:sizes]
#define fontboldToSize(size) [UIFont fontWithName:@"STHeitiSC-Light" size:size]


//颜色
#define fontColor [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]
#define yearColor [UIColor colorWithRed:78/255.0 green:130/255.0 blue:90/255.0 alpha:1]
#define monthColor [UIColor colorWithRed:79/255.0 green:133/255.0 blue:194/255.0 alpha:1]
#define dayColor [UIColor colorWithRed:97/255.0 green:162/255.0 blue:195/255.0 alpha:1]


//*************url***************************************//
#define httpurl(str) [NSString stringWithFormat:@"http://huuuaapp.duapp.com/api.php%@",str]
#define wxxbaseURL [NSString stringWithFormat:@"%@%@",httpurl,@"index.php"]



#define ShowLocali(str) NSLocalizedString(str,nil) //国际化

#define enumToObj(enum) [NSNumber numberWithInt:enum] //枚举转num

#define UIBounds [[UIScreen mainScreen] bounds] //window外框大小

#define kWxxErrorDomain @"网络错误"



