//
//  LeftHeadView.m
//  zouzhe2.2
//
//  Created by weng xiangxun on 15/3/23.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "LeftHeadView.h"
#import "SDImageCache.h"
@interface LeftHeadView()
@property (nonatomic,strong)UIImageView *headV;
@property (nonatomic,strong)WxxLabel *nameLb;
@end
@implementation LeftHeadView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
//        UIImage *imgpng = [UIImage imageNamed:@"LeftHead.png"];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        img.image = [UIImage imageNamed:@"LeftHead.jpg"];
        [self addSubview:img];
        
        _headV = [[UIImageView alloc]initWithFrame:CGRectMake(16, 40, 56, 56)];
        [self addSubview:_headV];
        _headV.image = [UIImage imageNamed:@"headnologin"];
        _headV.layer.cornerRadius = 56/2;
        _headV.layer.masksToBounds = YES;
        _nameLb = [[WxxLabel alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(_headV.frame)+42, 200, 15) color:[UIColor whiteColor] font:15];
        _nameLb.text = @"未登录";
        [self addSubview:_nameLb];
        [self addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
//        if ([USERDATA isLogin]) {
//            _nameLb.text = USERDATA.ufullname;
//        }
    }
    return self;
}

-(void)reflashInfo{
    _nameLb.text = @"name";//USERDATA.ufullname;
    
//     [_headV setImageWithURL:[NSURL URLWithString:@""] refreshCache:NO placeholderImage:[UIImage imageNamed:@"headnologin"] tag:-1];

}

-(void)login{
//    if (![USERDATA isLogin]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"showLogin" object:@"3"];
//    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
