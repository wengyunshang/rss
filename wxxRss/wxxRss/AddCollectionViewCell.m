//
//  AddCollectionViewCell.m
//  wxxRss
//
//  Created by weng xiangxun on 15/5/18.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "AddCollectionViewCell.h"
@interface AddCollectionViewCell()
@property (nonatomic,strong)RssClassData *rcData;
@property (nonatomic,strong)WxxLabel *title;
@property (nonatomic,strong)UIView *checkView;
@end
@implementation AddCollectionViewCell
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
//    self.layer.cornerRadius = 3;
    self.layer.borderColor = WXXCOLOR(0, 0, 0, 0.2).CGColor;
    self.layer.borderWidth = 0.5;
//    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:3].CGPath;
//    self.layer.shadowOffset = CGSizeMake(0, 1);
//    self.layer.shadowRadius = 1;
//    self.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.layer.shadowOpacity = 0.3;
    
    
//    
//    self.imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    [vvv addSubview:self.imgV];
//    
    
    
    self.title = [[WxxLabel alloc]initWithFrame:CGRectMake(16, 0, self.frame.size.width-32,self.frame.size.height) color:WXXCOLOR(0, 0, 0, 1) font:18];
//    self.title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.title];
    
    float width = 20;
    self.checkView = [[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width-16-width, (self.frame.size.height-width)/2, width, width)];
    self.checkView.backgroundColor = WXXCOLOR(0, 0, 0, 0.05);
    self.checkView.layer.borderColor = WXXCOLOR(0, 0, 0, 0.3).CGColor;
    self.checkView.layer.borderWidth = 0.5;
//    self.checkView.layer.cornerRadius = width/2;
    [self addSubview:self.checkView];
}

-(void)setCheck{
    
    if ([self.rcData.rrccheckselect isEqualToString:WXXYES]) {
        self.rcData.rrccheckselect = WXXNO;
        self.checkView.layer.backgroundColor = WXXCOLOR(0, 0, 0, 0.05).CGColor;
    }else{
        self.rcData.rrccheckselect = WXXYES;
        self.checkView.layer.backgroundColor = WXXCOLOR([self.rcData.rrr intValue],[self.rcData.rrg intValue], [self.rcData.rrb intValue], 1).CGColor;
    }
    self.rcData.rrctime = [WxxTimeUtil getNowTimeInterval];
    [self.rcData updateCheck];//更新选择
}

-(void)setInfo:(RssClassData*)rssClassData{
    self.rcData = rssClassData;
//    [self.imgV sd_setImageWithURL:[NSURL URLWithString:@"http://i0.sinaimg.cn/ty/nba/2015-04-23/U4933P6T12D7584864F44DT20150423112206.jpg"]];
    self.title.text = rssClassData.rrcName;
    if ([self.rcData.rrccheckselect isEqualToString:WXXNO]) {
        self.checkView.layer.backgroundColor = WXXCOLOR(0, 0, 0, 0.05).CGColor;
    }else{
        self.checkView.layer.backgroundColor = WXXCOLOR([self.rcData.rrr intValue],[self.rcData.rrg intValue], [self.rcData.rrb intValue], 1).CGColor;
    }
}
@end
