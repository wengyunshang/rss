//
//  UIView+Blur.h
//  zhouzhe
//
//  Created by libohao on 14-10-16.
//  Copyright (c) 2014年 zhouzhe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Blur)

-(void)blurScreen:(BOOL)enable;
-(void)blurBlueScreen:(BOOL)enable;
-(void)blurScreenBlackToSearch:(BOOL)enable;
-(void)blurScreen:(BOOL)enable alp:(float)alp;
-(UIImage*)image:(UIImage*)image;
@end
