//
//  TimelineLoadCell.m
//  wxxRss
//
//  Created by linxiaolong on 16/1/13.
//  Copyright © 2016年 wxx. All rights reserved.
//

#import "TimelineLoadCell.h"

@implementation TimelineLoadCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) [self setCellView];
    return self;
}

#pragma mark - Setup Method
- (void)setCellView
{
    self.layer.borderColor = WXXCOLOR(0, 0, 0, 0.2).CGColor;
    self.layer.borderWidth = 0.2;
    self.layer.cornerRadius = 5;
    self.ynEnd = NO;
    self.backgroundColor = WXXCOLOR(255, 255, 255, 0.6);
    self.titleLb = [[WxxLabel alloc]init];
    self.titleLb.textAlignment = NSTextAlignmentCenter;
    self.titleLb.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.titleLb];
    self.titleLb.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_titleLb]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLb)]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_titleLb]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_titleLb)]];
    
    self.titleLb.text = @"显示更多";
    
}

-(void)loadIngView{
    self.titleLb.text = @"加载中...";
}

-(void)loadingOver{
    self.titleLb.text = @"显示更多";
}
-(void)loadend{
    self.ynEnd = YES;
    self.titleLb.text = @"无更多旧新闻";
}
@end
