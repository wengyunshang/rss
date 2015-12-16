//
//  NewListCollectionViewCell.h
//  wxxRss
//
//  Created by weng xiangxun on 15/5/14.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLLabel.h"
@interface NewListCollectionViewCell : UICollectionViewCell
@property (nonatomic,strong)UIImageView *imgV;
@property (nonatomic,strong)YLLabel *titleLb;
@property (nonatomic,strong)WxxLabel *timeLb;
//@property (nonatomic,strong)WxxLabel *author
-(void)setInfo:(RssData*)rsdata;
-(void)refreshInfo:(RssData*)rsdata;
@end
