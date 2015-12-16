//
//  WxxLoadView.m
//  ZWYPopKeyWords
//
//  Created by weng xiangxun on 14/12/27.
//  Copyright (c) 2014年 ZWY. All rights reserved.
//

#import "WxxLoadView.h"
#import "DRPLoadingSpinner.h"
#import "UIView+Blur.h"
@interface WxxLoadView ()

@property (strong) DRPLoadingSpinner *spinner;
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)WxxButton *closeBtn;
//@property (nonatomic,strong)UIActivityIndicatorView *activityIndicator;
@end
@implementation WxxLoadView

static WxxLoadView *_sharedWxxLoadView = nil;
/**
 数据库采用单例模式: 不必每个地方去管理
 */
+ (WxxLoadView *)sharedWxxLoadView{
    if (!_sharedWxxLoadView) {
        _sharedWxxLoadView = [[self alloc]initWithFrame:UIBounds];
        //[[[[UIApplication sharedApplication] delegate] window] insertSubview:_sharedLoginPopView belowSubview:[WxxPopView sharedInstance]];
        [[[[UIApplication sharedApplication] delegate] window] addSubview:_sharedWxxLoadView];
    }
    return _sharedWxxLoadView;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width , [[UIScreen mainScreen] bounds].size.height)];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        _backView = [[UIView alloc]initWithFrame:CGRectMake((self.frame.size.width-80)/2, (self.frame.size.height-80)/2, 80, 80)];
//        [_backView blurScreen:YES alp:0.99];
        _backView.backgroundColor = [UIColor blackColor];
        
        _backView.layer.cornerRadius = 3;
        _backView.layer.masksToBounds = YES;
        self.backView.alpha = 0.0;
        [self addSubview:_backView];
        
//        self.layer.masksToBounds = YES;
//        self.backgroundColor = [UIColor blackColor];
//        self.layer.cornerRadius = 3.0;
//        [self blurScreen:YES];
        
        //加载旋转的风火轮
//        _activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.frame)-37)/2, (CGRectGetHeight(self.frame)-37)/2, 37, 37)];
//        _activityIndicator.hidesWhenStopped = NO;
////        _activityIndicator.frame = CGRectMake(0, 0, 50, 50);
//        _activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
////        _activityIndicator.center =self.center;
//        _activityIndicator.color = [UIColor blackColor];
//        _activityIndicator.alpha = 0;
//        [self addSubview:_activityIndicator];
        self.spinner = [[DRPLoadingSpinner alloc] initWithFrame:CGRectMake((CGRectGetWidth(self.frame)-40)/2, (CGRectGetHeight(self.frame)-40)/2, 40, 40) color:[UIColor whiteColor]];
        
//        self.spinner.center = self.center;
        self.spinner.rotationCycleDuration = 1;
        self.spinner.minimumArcLength = M_PI / 4;
        self.spinner.drawCycleDuration = 1;
        [self addSubview:self.spinner];
        self.alpha = 0;
        
//        UIImage *image = [UIImage imageNamed:@"close"];
        self.closeBtn = [[WxxButton alloc]initWithPoint:CGPointMake(CGRectGetMinX(_backView.frame), CGRectGetMinY(_backView.frame)) image:@"close" touchSize:20];
//        self.closeBtn.backgroundColor = [UIColor blackColor];
        [self addSubview:self.closeBtn];
        [self.closeBtn addTarget:self action:@selector(hideSelf) forControlEvents:UIControlEventTouchUpInside];
//         [self.spinner startAnimating];
    }
    return self;
}
-(void)showself{
//    [self.activityIndicator startAnimating];
//    self.activityIndicator.alpha = 0;
    self.alpha = 1.0;
    [UIView animateWithDuration:0.5 animations:^{
        
        self.backView.alpha = 0.6;
//        self.activityIndicator.alpha = 1.0;
        
    }completion:^(BOOL finished) {
//       self.activityIndicator.alpha = 1.0;;
    }];
    [self.spinner startAnimating];
//    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    scaleAnimation.springBounciness = 15;
//    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.2, 1.2)];
//    scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
//    [self.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    
//    [self performSelector:@selector(hideSelf) withObject:nil afterDelay:2.0];
}

-(void)hideSelf{
    if (self.alpha > 0) {
        [UIView animateWithDuration:0.5 animations:^{
            self.alpha = 0.0;
            self.backView.alpha = 0.0;
            //        self.activityIndicator.alpha = 0.0;
            [self.spinner stopAnimating];
        }completion:^(BOOL finished) {
            
        }];
    }
//    POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
//    scaleAnimation.springBounciness = 15;
//    scaleAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
//    scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.4, 0.4)];
//    [self.layer pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
//
}
@end
