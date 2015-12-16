//
//  WxxLabel.m
//  WxxAccount
//
//  Created by weng xiangxun on 15/4/22.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "WxxLabel.h"
#import "NSString+wxx.h"
@implementation WxxLabel
@synthesize insets=_insets;
/**
 *  frame
 *  color
 *  font
 *
 */
- (id)initWithFrame:(CGRect)frame color:(UIColor*)color font:(float)fontnum
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.textColor = color;
        self.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:fontnum];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}




-(void)resetFrame{
    [self setLineBreakMode:NSLineBreakByWordWrapping];
    self.numberOfLines = 0;
    NSLog(@"%@",self.text);
    float www = [self.text calculateTextWidth:self.text font:self.font];
    float hhh = [self.text calculateTextHeight:www Content:self.text font:self.font];
    self.backgroundColor = [UIColor clearColor];
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            www<self.frame.size.width?hhh:(www/self.frame.size.width)*hhh);
}

//多行
-(void)resetMoreLineFrame{
    [self setLineBreakMode:NSLineBreakByWordWrapping];
    self.numberOfLines = 0;
    CGSize labelsize = [self.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame),2000)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName : self.font}
                                               context:nil].size;
    self.frame = CGRectMake(CGRectGetMinX(self.frame),CGRectGetMinY(self.frame), labelsize.width, labelsize.height);
}
//单行
-(void)resetOneFrame{
    float www = [self.text calculateTextWidth:self.text font:self.font];
    float hhh = [self.text calculateTextHeight:www Content:self.text font:self.font];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,www,hhh);
}

//单行
-(void)resetOneFrameToMoreWidth:(float)moreWidth moreHeight:(float)moreHeight{
    float www = [self.text calculateTextWidth:self.text font:self.font];
    float hhh = [self.text calculateTextHeight:www Content:self.text font:self.font];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y,www+moreWidth,hhh+moreHeight);
}



-(void)resetFrameToMaxHeight:(float)maxheight{
    
    float www = [self.text calculateTextWidth:self.text font:self.font];
    float hhh = [self.text calculateTextHeight:www Content:self.text font:self.font];
    self.backgroundColor = [UIColor clearColor];
    
    float height = www<self.frame.size.width?hhh:(www/self.frame.size.width)*hhh;
    
    
    if (height> maxheight) {
        height = maxheight;
    }
    self.frame = CGRectMake(self.frame.origin.x,
                            self.frame.origin.y,
                            self.frame.size.width,
                            maxheight);
    //    NSLog(@">>>>>>>>>%f",self.frame.size.width);
    //    NSLog(@"%f>>>>>%f>>>>%f",www,self.frame.size.width,hhh);
    //    NSLog(@">>>>>>>>>%f",self.frame.size.height);
    //    self.lineBreakMode = UILineBreakModeCharacterWrap;
    [self setLineBreakMode:NSLineBreakByWordWrapping];
    self.numberOfLines = 0;
}



//计算不换行的frame 居右
-(void)resetLineFrameWithRight:(float)maxWidth rightOrg:(float)rightOrgx{
    float www = [self.text calculateTextWidth:self.text font:self.font];
    float hhh = [self.text calculateTextHeight:www Content:self.text font:self.font];
    self.frame = CGRectMake(maxWidth-rightOrgx-www, self.frame.origin.y,www,hhh);
}

-(void)reset2FrameWIthRight:(float)maxWidth rightOrg:(float)rightOrgx{
    [self setLineBreakMode:NSLineBreakByWordWrapping];
    self.numberOfLines = 0;
    //设置一个行高上限
    //计算实际frame大小，并将label的frame变成实际大小
    CGSize labelsize = [self.text boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame),2000)
                                               options:NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName : self.font}
                                               context:nil].size;
    
    if (labelsize.width < maxWidth) {
        self.frame = CGRectMake(maxWidth-rightOrgx-labelsize.width,CGRectGetMinY(self.frame), labelsize.width, labelsize.height);
    }else{
        self.frame = CGRectMake(CGRectGetMinX(self.frame),CGRectGetMinY(self.frame), labelsize.width, labelsize.height);
    }
    
}


//不计算换行， 剧中
-(void)resetLineFrame:(float)parentWidth  height:(float)parentHeight{
    float www = [self.text calculateTextWidth:self.text font:self.font];
    float hhh = [self.text calculateTextHeight:www Content:self.text font:self.font];
    if (parentHeight == 0) {
        parentHeight = self.frame.origin.y;
    }else{
        parentHeight = (parentHeight-hhh)/2;
    }
    
    self.frame = CGRectMake((parentWidth-www)/2, parentHeight,www,hhh);
}

-(id) initWithFrame:(CGRect)frame andInsets:(UIEdgeInsets)insets {
    self = [super initWithFrame:frame];
    if(self){
        self.insets = insets;
    }
    return self;
}

-(id) initWithInsets:(UIEdgeInsets)insets {
    self = [super init];
    if(self){
        self.insets = insets;
    }
    return self;
}

-(void) drawTextInRect:(CGRect)rect {
//    if (self.insets==nil) {
//        self.insets = UIEdgeInsetsMake(0, 0, 0, 0);
//    }
    return [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.insets)];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
