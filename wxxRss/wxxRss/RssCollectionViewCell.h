//
//  MJCollectionViewCell.h
//  RCCPeakableImageSample
//
//  Created by Mayur on 4/1/14.
//  Copyright (c) 2014 RCCBox. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RssClassData;
@interface RssCollectionViewCell : UICollectionViewCell
-(void)setInfo:(RssClassData*)rssClassData;
-(void)setAddbtn;
-(void)refreshImageV;
-(void)startLoading;
-(void)stoptLoading;
-(void)showChangeBtn;
-(void)hideChangeBtn;
-(void)refreshTipNumV;
@end
