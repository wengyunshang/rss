//
//  BigClassViewController.h
//  wxxRss
//
//  Created by weng xiangxun on 15/5/19.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WxxBaseViewController.h"
@interface BigClassViewController : WxxBaseViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic)UICollectionView *collectionView;
@property (nonatomic , copy) void (^refreshCallback)();
@end
