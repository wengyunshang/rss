//
//  ViewController.h
//  wxxRss
//
//  Created by weng xiangxun on 15/5/11.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleMobileAds/GADBannerView.h"
#import "GDTMobBannerView.h" //导入GDTMobBannerView.h头文件
@interface ViewController : UIViewController<GDTMobBannerViewDelegate,GADBannerViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{

    GADBannerView *bannerView_;
    GDTMobBannerView *_bannerView;//声明一个GDTMobBannerView的实例
}
@property (strong, nonatomic)UICollectionView *collectionView;
-(void)loadInfo;
-(void)deleteCell;
-(void)doQueueLoadRss;
@end

