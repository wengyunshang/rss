//
//  AppDelegate.m
//  wxxRss
//
//  Created by weng xiangxun on 15/5/11.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "SMAppDelegate.h"

@interface SMAppDelegate ()

@end


#import "MobClick.h"
#import "ViewController.h"
#import "LeftHbgView.h"
//#import "APService.h"
#import "NewListViewController.h"
//#import "SMFeedParserWrapper.h"
#import "WxxWebViewController.h"
#import "TBXML.h"
#import "WxxNetTBXMLUtil.h"
#import "TBXML+HTTP.h"
#import <ShareSDK/ShareSDK.h>
#import "WeiboApi.h"
//以下是腾讯QQ和QQ空间
#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import <QZoneConnection/ISSQZoneApp.h>
@implementation SMAppDelegate
//{
//    SMViewController *_smViewController;
//}

-(void)fonename{
    
    NSArray *familyNames =[[NSArray alloc]initWithArray:[UIFont familyNames]];
    
    NSArray *fontNames;
    
    NSInteger indFamily, indFont;
    for(indFamily=0;indFamily<[familyNames count];++indFamily)
    {
        //        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames =[[NSArray alloc]initWithArray:[UIFont fontNamesForFamilyName:[familyNames objectAtIndex:indFamily]]];
        for(indFont=0; indFont<[fontNames count]; ++indFont)
        {
                        NSLog(@"    Font name: %@",[fontNames objectAtIndex:indFont]);
        }
    }
}

- (void)umengTrack {
    [MobClick startWithAppkey:@"" reportPolicy:(ReportPolicy) REALTIME channelId:nil];
    [MobClick updateOnlineConfig];  //在线参数配置
}
#define qqKey @"1104691508"             //QQ
#define qqSecret @"e1CYi5HztJEhnJQK"    //QQ
-(void)sharesdk{
    [ShareSDK registerApp:@"7f58286dee1b"];
    
    //添加新浪微博应用
    [ShareSDK connectSinaWeiboWithAppKey:@"3182153118"
                               appSecret:@"ad81692e78165c8afedfb41736fd9ccc"
                             redirectUri:@"http://www.sharesdk.cn"];
    
    //添加腾讯微博应用
//    [ShareSDK connectTencentWeiboWithAppKey:@"1104691508"
//                                  appSecret:@"ae36f4ee3946e1cbb98d6965b0b2ff5c"
//                                redirectUri:@"http://www.sharesdk.cn"
//                                   wbApiCls:[WeiboApi class]];
//    [ShareSDK connectQQWithQZoneAppKey:@"1104691508"
//                         qqApiInterfaceCls:[QQApiInterface class]
//                           tencentOAuthCls:[TencentOAuth class]];
    [ShareSDK connectQZoneWithAppKey:qqKey
                           appSecret:qqSecret
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
//    [ShareSDK connectQQWithQZoneAppKey:qqKey
//                     qqApiInterfaceCls:[QQApiInterface class]
//                       tencentOAuthCls:[TencentOAuth class]];
//    //        [ShareSDK connectWeChatWithAppId:@"wx0e7d7ea2e49f70c3" wechatCls:[WXApi class]];
//    id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
//    [app setIsAllowWebAuthorize:YES];
//    [ShareSDK connectWeChatWithAppId:@"wx4868b35061f87885"
//                           appSecret:@"64020361b8ec4c99936c0e3999a9f249"
//                           wechatCls:[WXApi class]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    [self fonename];
//    [self umengTrack];
    [self sharesdk];

    self.indexVC = [[ViewController alloc]init];
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.linenv = [[UINavigationController alloc] initWithRootViewController:self.indexVC];
    [_window setRootViewController:self.linenv];
    [_window makeKeyAndVisible];
    [self.indexVC.view addSubview:[LeftHbgView sharedLeftHbgView]];
    [self.window addSubview:[WxxLoadView sharedWxxLoadView]];
    [self.window addSubview:[WxxPopView sharedWxxPopView]];

    [self.indexVC loadInfo];
    [WXXNETUTIL getBigClass:^(id response) {
        [WXXNETUTIL getLittleClass:^(id response) {
            [self.indexVC loadInfo];
            [self.indexVC doQueueLoadRss];//队列刷新
        }];
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showSetType:) name:@"showSetType" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateIndexList) name:@"updateIndexList" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showweburl:) name:@"showweburl" object:nil];
    return YES;
}

-(void)updateIndexList{
    
    [self.indexVC deleteCell];
}

-(void)showweburl:(NSNotification *) noti
{
    //获取参数
    NSString* temp=[noti object];
    
    WxxWebViewController *webVC = [[WxxWebViewController alloc]init];
    [webVC initWebWithUrl:temp title:@"原文"];
    [self.indexVC presentViewController:webVC animated:YES completion:^{
         [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    }];
}
-(void)showSetType:(NSNotification *) noti
{
    //获取参数
    NSString* temp=[noti object];
    switch ([temp intValue]) {
        case setCollect:
            [self showCollectVC];
            break;
        case setWebView:
            [self showWebView];
            break;
        default:
            break;
    }
}

//玩家反馈列表
-(void)showWebView{
    WxxWebViewController *webVC = [[WxxWebViewController alloc]init];
    [webVC initWebWithUrl:@"http://www.huuua.com/index.php?c=comment&a=getCommentList" title:@"关于我们"];
//    [self.indexVC.navigationController pushViewController:webVC animated:YES];
    [self.indexVC presentViewController:webVC animated:YES completion:^{
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    }];
}

//收藏列表
-(void)showCollectVC{
    NewListViewController *liVC = [[NewListViewController alloc]init];
    RssClassData *rcdata = [[RssClassData alloc]init];
    rcdata.rrcName = @"我的收藏";
    rcdata.rrr = @"0";
    rcdata.rrg = @"0";
    rcdata.rrb = @"0";
    liVC.rssClassData = rcdata;
    liVC.ynCollect = YES;
    [self.indexVC.navigationController pushViewController:liVC animated:YES];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [UIApplication sharedApplication].applicationIconBadgeNumber =0;
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
//    [self saveContext];
}

#pragma mark - background mode
-(void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
}


#pragma mark - push
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
//    [APService registerDeviceToken:deviceToken];
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url wxDelegate:nil];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url sourceApplication:sourceApplication annotation:annotation wxDelegate:nil];
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required
//    [APService handleRemoteNotification:userInfo];
}
@end
