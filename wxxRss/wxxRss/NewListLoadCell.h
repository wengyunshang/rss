//
//  NewListLoadCell.h
//  wxxRss
//
//  Created by weng xiangxun on 15/6/5.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewListLoadCell : UICollectionViewCell
@property (nonatomic,strong)WxxLabel *titleLb;
@property (nonatomic,assign)BOOL ynEnd;
-(void)loadIngView;
-(void)loadingOver;
-(void)loadend;
@end