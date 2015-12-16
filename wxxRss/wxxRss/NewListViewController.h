//
//  NewListViewController.h
//  wxxRss
//
//  Created by weng xiangxun on 15/5/12.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewListViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,assign)BOOL ynCollect;//是否加载收藏列表
@property (strong, nonatomic)UICollectionView *collectionView;
@property (nonatomic,strong)RssClassData *rssClassData;
@end
