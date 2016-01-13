//
//  TimelineViewController.h
//  wxxRss
//
//  Created by linxiaolong on 16/1/12.
//  Copyright © 2016年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimelineViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic)UICollectionView *collectionView;
-(void)reloadInfo;
@end
