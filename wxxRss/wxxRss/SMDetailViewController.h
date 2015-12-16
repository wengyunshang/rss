//
//  SMDetailViewController.h
//  RSSRead
//
//  Created by ming on 14-3-21.
//  Copyright (c) 2014年 starming. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SMDetailViewControllerDelegate

@optional
-(void)unFav;
-(void)faved;

@end

@interface SMDetailViewController : UIViewController<UIWebViewDelegate>
@property(nonatomic,strong)RssData *rss;
@property(nonatomic,strong)RssClassData *rclassData;
@property(nonatomic,assign)id<SMDetailViewControllerDelegate>delegate;
-(void)renderDetailViewFromRSS;
@end
