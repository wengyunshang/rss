//
//  LeftTableViewCell.m
//  zouzhe2.2
//
//  Created by weng xiangxun on 15/3/17.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "LeftTableViewCell.h"
@interface LeftTableViewCell()

@property (nonatomic,strong)UIImageView *headImgv;
@property (nonatomic,strong)WxxLabel *titleLb;

@end
@implementation LeftTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _headImgv = [[UIImageView alloc]initWithFrame:CGRectMake(16, (48-20)/2, 20, 20)];
        [self.contentView addSubview:_headImgv];
        
        _titleLb = [[WxxLabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImgv.frame)+16, (48-14)/2, 200, 14)
                                            color:[UIColor blackColor] font:14];
        _titleLb.text = @"意见反馈";
        [self.contentView addSubview:_titleLb];
    }
    return self;
}

-(void)setheadimage:(NSString*)img title:(NSString*)title{
    _headImgv.image = [UIImage imageNamed:img];
//    禁点时按钮字体透明度为26％
//    if ([USERDATA isLogin]) {
//        self.titleLb.alpha = 1;
//    }else{
//        self.titleLb.alpha = 0.26;
//    }
    self.titleLb.text = title;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
