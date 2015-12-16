//
//  AddClassViewController.h
//  wxxRss
//
//  Created by weng xiangxun on 15/5/16.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddClassViewController : WxxBaseViewController<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic)UICollectionView *collectionView;
@property (nonatomic,strong)NSString* bigId;
@property (nonatomic , copy) void (^refreshCallback)();
-(void)showAddBtn;
@end
