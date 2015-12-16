//
//  BigCollectionViewCell.h
//  wxxRss
//
//  Created by weng xiangxun on 15/5/19.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RssBigClassData;
@interface BigCollectionViewCell : UICollectionViewCell
-(void)setInfo:(RssBigClassData*)rssClassData;
@end
