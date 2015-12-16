//
//  AddCollectionViewCell.h
//  wxxRss
//
//  Created by weng xiangxun on 15/5/18.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RssClassData;
@interface AddCollectionViewCell : UICollectionViewCell
-(void)setInfo:(RssClassData*)rssClassData;
-(void)setCheck;
@end
