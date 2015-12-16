//
//  ViewController.h
//  wxxRss
//
//  Created by weng xiangxun on 15/5/11.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleMobileAds/GADBannerView.h"
@interface ViewController : UIViewController<GADBannerViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{

    GADBannerView *bannerView_;
}
@property (strong, nonatomic)UICollectionView *collectionView;
-(void)loadInfo;
-(void)deleteCell;
-(void)doQueueLoadRss;
@end

