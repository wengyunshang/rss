//
//  TimelineLoadCell.h
//  wxxRss
//
//  Created by linxiaolong on 16/1/13.
//  Copyright © 2016年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimelineLoadCell : UICollectionViewCell
@property (nonatomic,strong)WxxLabel *titleLb;
@property (nonatomic,assign)BOOL ynEnd;
-(void)loadIngView;
-(void)loadingOver;
-(void)loadend;
@end
