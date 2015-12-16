//
//  WxxButton.h
//  DontTry
//
//  Created by weng xiangxun on 13-1-17.
//  Copyright (c) 2013年 weng xiangxun. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WxxButton : UIButton

@property (nonatomic,copy)void (^btnTouch)();
- (id)initWithFrame:(CGRect)frame title:(NSString*)title textColor:(UIColor *)textColor font:(int)font touchSize:(float)size;
- (id)initWithPoint:(CGPoint)point imageName:(NSString*)imgname;
- (id)initWithFrame:(CGRect)frame title:(NSString*)title border:(BOOL)ynborder borderColor:(UIColor*)bordercolor textColor:(UIColor *)textColor font:(int)font;
- (id)initWithFrame:(CGRect)frame image:(UIImage*)image;
- (id)initWithFrame:(CGRect)frame title:(NSString*)title textColor:(UIColor *)textColor font:(int)font;
- (id)initWithPoint:(CGPoint)point image:(NSString*)imageName touchSize:(float)size;

- (id)initWithFrame:(CGRect)frame title:(NSString*)title textColor:(UIColor *)textColor uifont:(UIFont*)uifont;

-(void)setBottomLine;
@end
