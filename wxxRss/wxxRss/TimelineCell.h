//
//  TimelineCell.h
//  wxxRss
//
//  Created by linxiaolong on 16/1/13.
//  Copyright © 2016年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YLLabel.h"
@interface TimelineCell : UICollectionViewCell
@property (nonatomic,strong)UIImageView *imgV;
@property (nonatomic,strong)YLLabel *titleLb;
@property (nonatomic,strong)WxxLabel *timeLb;
//@property (nonatomic,strong)WxxLabel *author
-(void)setInfo:(RssData*)rsdata;
-(void)refreshInfo:(RssData*)rsdata;
@end
