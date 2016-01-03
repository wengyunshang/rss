//
//  NewListCollectionViewCell.m
//  wxxRss
//
//  Created by weng xiangxun on 15/5/14.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "NewListCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation NewListCollectionViewCell
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
    self.backgroundColor = [UIColor whiteColor];
//    self.layer.cornerRadius = 3;
    
    
//    UIView *vvv = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
////    vvv.layer.cornerRadius = 3;
//    vvv.layer.masksToBounds = YES;
//    [self addSubview:vvv];
    
    self.imgV = [[UIImageView alloc]initWithFrame:CGRectMake(16, 10, 60, 60)];
    //        [self.imgV sd_setImageWithURL:[NSURL URLWithString:@"http://i0.sinaimg.cn/ty/nba/2015-04-23/U4933P6T12D7584864F44DT20150423112206.jpg"]];
    
    [self.contentView addSubview:self.imgV];
    //        [self.bookImgV.layer setBorderColor:[[UIColor colorWithRed:205/255.f green:200/255.f blue:190/255.f alpha:1] CGColor]];
    //        [self.bookImgV.layer setBorderWidth:0.3f];
//    self.imgV.layer.cornerRadius = 3;
    self.imgV.layer.masksToBounds = YES;
    self.imgV.backgroundColor = WXXCOLOR(0, 0, 0, 0.3);
    self.imgV.layer.borderColor = WXXCOLOR(0, 0, 0, 0.2).CGColor;
    self.imgV.layer.borderWidth = 0.5;
    
    
    //        self.titleLb = [[WxxLabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imgV.frame)+10, 10, UIBounds.size.width-CGRectGetMaxX(self.imgV.frame)-10-16, 50)
    //                                                 color:WXXCOLOR(0, 0, 0, 1) font:15];
    //        [self.contentView addSubview:self.titleLb];
    //       [self.titleLb setNumberOfLines:2];
    
    
    self.titleLb = [[YLLabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imgV.frame)+10,10,
                                                            self.frame.size.width-CGRectGetMaxX(self.imgV.frame)-10-16,15)];
//    self.titleLb.backgroundColor = [UIColor redColor];
    [self.titleLb setTextColor:WXXCOLOR(0, 0, 0, 1)];
    [self.titleLb setFont:[UIFont fontWithName:@"STHeitiSC-Light" size:15]];
    [self.contentView addSubview:self.titleLb];
    //        [self.contextLb setText:[NSString stringWithFormat:@"        %@",self.bookdata.bpbcontent]];//
    //        [self.contextLb resetFrame:headV.frame.size.width-30];
//    self.titleLb.backgroundColor = [UIColor redColor];
    
    
    
    self.timeLb = [[WxxLabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.timeLb.frame), CGRectGetMaxY(self.timeLb.frame), CGRectGetWidth(self.titleLb.frame), 12) color:WXXCOLOR(0, 0, 0, 1) font:12];
    [self.contentView addSubview:self.timeLb];
    self.layer.borderColor = WXXCOLOR(0, 0, 0, 0.2).CGColor;
    self.layer.borderWidth = 0.5;
}
-(void)setInfo:(RssData*)rsdata{
    
    if ([rsdata.rrimage length]>0) {
        self.imgV.hidden = NO;
        if ([WXXNETUTIL isOpen3g]) {
//            [self.imgV sd_setImageWithURL:[NSURL URLWithString:rsdata.rrimage]];
            [self.imgV sd_setImageWithURL:[NSURL URLWithString:rsdata.rrimage]];
        }else{
//            self.imgV.image = [UIImage imageNamed:@"CheckCircle-orange"];
        }
        
    }else{
        self.imgV.hidden = YES;
    }
    if ([rsdata.rrynread isEqualToString:WXXYES]) {
        self.imgV.alpha = 0.4;
        [self.titleLb setTextColor:WXXCOLOR(0, 0, 0, 0.3)];
        self.timeLb.textColor = WXXCOLOR(0, 0, 0, 0.3);
        self.backgroundColor = WXXCOLOR(255, 255, 255, 0.5);
    }else{
        self.imgV.alpha = 1;
        [self.titleLb setTextColor:WXXCOLOR(0, 0, 0, 1)];
        self.timeLb.textColor = WXXCOLOR(0, 0, 0, 0.6);
        self.backgroundColor = WXXCOLOR(255, 255, 255, 1);
    }
    if (self.imgV.hidden) {
        
        CGRect rect = self.titleLb.frame;
        rect.origin.x = 16;
        rect.size.width = self.frame.size.width - 32 ;
        self.titleLb.frame = rect;
        [self.titleLb setText:[NSString stringWithFormat:@"%@",rsdata.rrtitle]];//
        [self.titleLb resetFrame];
    }else{
        
        CGRect rect = self.titleLb.frame;
        rect.origin.x = CGRectGetMaxX(self.imgV.frame)+10;
        rect.size.width = self.frame.size.width-CGRectGetMaxX(self.imgV.frame)-10-16 ;
        self.titleLb.frame = rect;
        [self.titleLb setText:[NSString stringWithFormat:@"%@",rsdata.rrtitle]];//
        [self.titleLb resetFrame];
    }
    
    self.timeLb.text = rsdata.rrpublished;
    CGRect rect = self.timeLb.frame;
    rect.origin.y = CGRectGetMaxY(self.titleLb.frame);
    rect.origin.x = CGRectGetMinX(self.titleLb.frame);
    self.timeLb.frame = rect;
    
//    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:3].CGPath;
//    self.layer.shadowOffset = CGSizeMake(0, 0);
//    self.layer.shadowRadius = 1;
//    self.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.layer.shadowOpacity = 0.1;
    
//    self.timeLb.hidden = YES;
}

-(void)refreshInfo:(RssData*)rsdata{
    if ([rsdata.rrynread isEqualToString:WXXYES]) {
        self.imgV.alpha = 0.7;
        [self.titleLb setTextColor:WXXCOLOR(0, 0, 0, 0.54)];
        self.timeLb.textColor = WXXCOLOR(0, 0, 0, 0.54);
    }else{
        self.imgV.alpha = 1;
        [self.titleLb setTextColor:WXXCOLOR(0, 0, 0, 1)];
        self.timeLb.textColor = WXXCOLOR(0, 0, 0, 1);
    }
}
@end
