//
//  BigCollectionViewCell.m
//  wxxRss
//
//  Created by weng xiangxun on 15/5/19.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "BigCollectionViewCell.h"

@interface BigCollectionViewCell()
@property (nonatomic,strong)RssBigClassData *rbData;
@property (nonatomic,strong)WxxLabel *title;
@property (nonatomic,strong)UIImageView *arrowImgv;
@end
@implementation BigCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) [self setCellView];
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

#pragma mark - Setup Method
- (void)setCellView
{
    self.backgroundColor = WXXCOLOR(255, 255, 255, 1);
//    self.layer.cornerRadius = 2;
    self.layer.borderColor = WXXCOLOR(0, 0, 0, 0.2).CGColor;
    self.layer.borderWidth = 0.5;
//    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:2].CGPath;
//    self.layer.shadowOffset = CGSizeMake(0, 1);
//    self.layer.shadowRadius = 1;
//    self.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.layer.shadowOpacity = 0.1;
    
    
    //
    //    self.imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    //    [vvv addSubview:self.imgV];
    //
    
    
    self.title = [[WxxLabel alloc]initWithFrame:CGRectMake(16, 0, self.frame.size.width-32,self.frame.size.height) color:WXXCOLOR(0, 0, 0, 1) font:18];
    //    self.title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.title];
    
    UIImage *image = [UIImage imageNamed:@"rightArrowgray"];
    self.arrowImgv = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width-image.size.width-16, (self.frame.size.height-image.size.height)/2, image.size.width, image.size.height)];
    self.arrowImgv.image = image;
    [self addSubview:self.arrowImgv];
}

-(void)setInfo:(RssBigClassData*)rssClassData{
    self.rbData= rssClassData;
    //    [self.imgV sd_setImageWithURL:[NSURL URLWithString:@"http://i0.sinaimg.cn/ty/nba/2015-04-23/U4933P6T12D7584864F44DT20150423112206.jpg"]];
    self.title.text = rssClassData.rrbName;
    self.title.textColor = WXXCOLOR([self.rbData.rrbr intValue], [self.rbData.rrbg intValue], [self.rbData.rrbb intValue], 1);
    
}
@end
