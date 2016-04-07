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

@import GoogleMobileAds;
#import "MobClick.h"
#import "ViewController.h"
#import "WxxTimeUtil.h"
#import "LeftHbgView.h" //左边栏
#import "NewListViewController.h" //收藏列表
#import "WxxWebViewController.h"  //网页
#import <ShareSDK/ShareSDK.h> //分享sdk
//以下是腾讯QQ和QQ空间
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/ISSQZoneApp.h>

@interface SMAppDelegate()<GADInterstitialDelegate>
@property(nonatomic, strong) GADInterstitial *interstitial;
@end

@implementation SMAppDelegate
@synthesize splash = _splash;
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
                             redirectUri:@"http://www.weibo.com"];
    
    [ShareSDK connectQZoneWithAppKey:qqKey
                           appSecret:qqSecret
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];
    [ShareSDK connectQQWithQZoneAppKey:qqKey
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
//    [self createAndLoadInterstitial];
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
    
    //开屏广告初始化并展示代码
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        //        GDTSplashAd *splashAd = [[GDTSplashAd alloc] initWithAppkey:@"1101508191" placementId:@"1020003690642397"];
//        GDTSplashAd *splashAd = [[GDTSplashAd alloc] initWithAppkey:@"1105052784" placementId:@"9040109739804145"];
//        splashAd.delegate = self;//设置代理1ez        //针对不同设备尺寸设置不同的默认图片，拉取广告等待时间会展示该默认图片。
// 
//        splashAd.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[SMAppDelegate getLaunchImageName]]];
//        //设置开屏拉取时长限制，若超时则不再展示广告
//        splashAd.fetchDelay = 4;
//        //拉取并展示
//        [splashAd loadAdAndShowInWindow:self.window];
//        self.splash = splashAd;
//    }
    
    
    return YES;
}


- (void)createAndLoadInterstitial {
    self.interstitial =
    [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-5914587552835750/3251372825"];
    self.interstitial.delegate = self;
    
    GADRequest *request = [GADRequest request];
    // Request test ads on devices you specify. Your test device ID is printed to the console when
    // an ad request is made. GADInterstitial automatically returns test ads when running on a
    // simulator.
    //    request.testDevices = @[@"4158af5e5bd6da102df22d01a366a05a"];
    [self.interstitial loadRequest:request];
}


#pragma mark GADInterstitialDelegate implementation

- (void)interstitial:(GADInterstitial *)interstitial
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"interstitialDidFailToReceiveAdWithError: %@", [error localizedDescription]);
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    NSLog(@"interstitialDidDismissScreen");
}

- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
    [interstitial presentFromRootViewController:self.window.rootViewController];
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
        case setAds:
            [self createAndLoadInterstitial];
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
    self.oldTime = [WxxTimeUtil getNowTimeInterval]; //进入后台记录时间点
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    NSLog(@"后台返回");
    NSString *nowTime = [WxxTimeUtil getNowTimeInterval];
    //后台返回的时候判断现在和上次进入后台的时候时间差， 如果大于一个小时就弹出开屏广告
//    if (([nowTime longLongValue] - [self.oldTime longLongValue])>3600) {
//        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//            //        GDTSplashAd *splashAd = [[GDTSplashAd alloc] initWithAppkey:@"1101508191" placementId:@"1020003690642397"];
//            GDTSplashAd *splashAd = [[GDTSplashAd alloc] initWithAppkey:@"1105052784" placementId:@"9040109739804145"];
//            splashAd.delegate = self;//设置代理1ez        //针对不同设备尺寸设置不同的默认图片，拉取广告等待时间会展示该默认图片。
//            
//            splashAd.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:[SMAppDelegate getLaunchImageName]]];
//            //设置开屏拉取时长限制，若超时则不再展示广告
//            splashAd.fetchDelay = 4;
//            //拉取并展示
//            [splashAd loadAdAndShowInWindow:self.window];
//            self.splash = splashAd;
//        }
//    }
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
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//
//    // Required
////    [APService handleRemoteNotification:userInfo];
//}


-(void)splashAdSuccessPresentScreen:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}

-(void)splashAdFailToPresent:(GDTSplashAd *)splashAd withError:(NSError *)error
{
    NSLog(@"%s%@",__FUNCTION__,error);
}
-(void)splashAdApplicationWillEnterBackground:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}
-(void)splashAdClicked:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}
-(void)splashAdClosed:(GDTSplashAd *)splashAd
{
    NSLog(@"%s",__FUNCTION__);
}



+(NSString*)getLaunchImageName
{
    NSArray* images= @[@"LaunchImage.png", @"LaunchImage@2x.png",@"LaunchImage-700@2x.png",@"LaunchImage-568h@2x.png",@"LaunchImage-700-568h@2x.png",@"LaunchImage-700-Portrait@2x~ipad.png",@"LaunchImage-Portrait@2x~ipad.png",@"LaunchImage-700-Portrait~ipad.png",@"LaunchImage-Portrait~ipad.png",@"LaunchImage-Landscape@2x~ipad.png",@"LaunchImage-700-Landscape@2x~ipad.png",@"LaunchImage-Landscape~ipad.png",@"LaunchImage-700-Landscape~ipad.png"];
    
    
    
    UIImage *splashImage;
    
    if([self isDeviceiPhone])
        
    {
        
        if ([self isDeviceiPhone4] && [self isDeviceRetina])
            
        {
            
            splashImage = [UIImage imageNamed:images[1]];
            
            if (splashImage.size.width!=0)
                
                return images[1];
            
            else
                
                return images[2];
            
        }
        
        else if ([self isDeviceiPhone5])
            
        {
            
            splashImage = [UIImage imageNamed:images[1]];
            
            if (splashImage.size.width!=0)
                
                return images[3];
            
            else
                
                return images[4];
            
        }
        
        else
            
            return images[0]; //Non-retina iPhone
        
    }
    
    else if ([[UIDevice currentDevice] orientation]==UIDeviceOrientationPortrait || [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown)//iPad Portrait
        
    {
        if ([self isDeviceRetina])
        {
            splashImage = [UIImage imageNamed:images[5]];
            if (splashImage.size.width!=0)
                return images[5];
            else
                return images[6];
        }
        else
        {
            splashImage = [UIImage imageNamed:images[7]];
            if (splashImage.size.width!=0)
                return images[7];
            else
                return images[8];
        }
        
    }
    else
    {
        if ([self isDeviceRetina])
        {
            splashImage = [UIImage imageNamed:images[9]];
            if (splashImage.size.width!=0)
                return images[9];
            else
                return images[10];
        }
        else
        {
            splashImage = [UIImage imageNamed:images[11]];
            if (splashImage.size.width!=0)
                return images[11];
            else
                return images[12];
        }
    }
}


+(BOOL)isDeviceiPhone{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        return TRUE;
    }
    return FALSE;
}

+(BOOL)isDeviceiPhone4{
    if ([[UIScreen mainScreen] bounds].size.height==480)
        return TRUE;
    return FALSE;
}


+(BOOL)isDeviceRetina
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] &&
        ([UIScreen mainScreen].scale == 2.0))        // Retina display
    {
        return TRUE;
    }
    else                                          // non-Retina display
    {
        return FALSE;
    }
}

+(BOOL)isDeviceiPhone5{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && [[UIScreen mainScreen] bounds].size.height>480){
        return TRUE;
    }
    return FALSE;
    
}
@end
