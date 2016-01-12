//
//  ViewController.h
//  wxxRss
//
//  Created by weng xiangxun on 15/5/11.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimelineViewController.h"
#import "NYSegmentedControl.h"
@interface ViewController : UIViewController<NYSegmentedControlDelegate,UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    
}
@property (strong, nonatomic)NYSegmentedControl *foursquareSegmentedControl;
@property (strong, nonatomic)UICollectionView *collectionView;
@property (strong, nonatomic)TimelineViewController *timelineVC;
@property (strong, nonatomic) UIScrollView *scrollView;
-(void)loadInfo;
-(void)deleteCell;
-(void)doQueueLoadRss;
@end

