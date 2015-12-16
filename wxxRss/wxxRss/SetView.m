//
//  SetView.m
//  wxxRss
//
//  Created by weng xiangxun on 15/5/15.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "SetView.h"
#import "POPSpringAnimation.h"
@interface SetView()
@property (nonatomic,strong)UIView *toolView;
@property (nonatomic,strong)UIView *blackView;
@property (nonatomic,strong) UISegmentedControl *segmentedControl;
@end
@implementation SetView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.blackView = [[UIView alloc]initWithFrame:frame];
        self.blackView.backgroundColor = [UIColor blackColor];
        self.blackView.alpha = 0.0;
        [self addSubview:self.blackView];
        
        
        self.toolView = [[UIView alloc]initWithFrame:CGRectMake(0, UIBounds.size.height, UIBounds.size.width, 44+165)];
        self.toolView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.toolView];
        self.hidden = YES;
        
        
        [self initColorBtn];
        [self initFontView];
        [self initSegmentedControl];
        
        [self initTouch];
    }
    return self;
}

//********************************* 颜色 ************************************************//
-(void)initColorBtn{

    WxxLabel *lb1 = [[WxxLabel alloc]initWithFrame:CGRectMake(16, 0, 30, 55) color:WXXCOLOR(0, 0, 0, 1) font:15];
    lb1.text = @"背景";
    [self.toolView addSubview:lb1];
    
    //黑色
//    UIImage *blackImg = [UIImage imageNamed:@"reading_background_night.png"];
    WxxButton *blackBtn = [[WxxButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb1.frame)+15, 5, 45, 45)];
    blackBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reading_background_night.png"]];
    blackBtn.layer.cornerRadius = 45/2;
    blackBtn.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:blackBtn.bounds cornerRadius:45/2].CGPath;
    blackBtn.layer.shadowOffset = CGSizeMake(0, 0);
    blackBtn.layer.shadowRadius = 1;
    blackBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    blackBtn.layer.shadowOpacity = 0.5;
    [self.toolView addSubview:blackBtn];
    blackBtn.btnTouch = ^(){
        if (self.setCallBack) {
            self.setCallBack(setColorBlack);
        }
    };
    
    //绿色
//    UIImage *greenImg = [UIImage imageNamed:@"reading_background_green.png"];
    WxxButton *greenBtn = [[WxxButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(blackBtn.frame)+15, 5, 45, 45)];
    greenBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reading_background_green.png"]];
    greenBtn.layer.cornerRadius = 45/2;
    greenBtn.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:blackBtn.bounds cornerRadius:45/2].CGPath;
    greenBtn.layer.shadowOffset = CGSizeMake(0, 0);
    greenBtn.layer.shadowRadius = 1;
    greenBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    greenBtn.layer.shadowOpacity = 0.5;
    [self.toolView addSubview:greenBtn];
    greenBtn.btnTouch = ^(){
        if (self.setCallBack) {
            self.setCallBack(setColorGreen);
        }
    };
    //褐色
//    UIImage *sepiaImg = [UIImage imageNamed:@"reading_background_sepia"];
    WxxButton *sepiaBtn = [[WxxButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(greenBtn.frame)+15, 5, 45, 45)];
    sepiaBtn.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reading_background_sepia"]];
    sepiaBtn.layer.cornerRadius = 45/2;
//    sepiaBtn.layer.masksToBounds = YES;
    sepiaBtn.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:blackBtn.bounds cornerRadius:45/2].CGPath;
    sepiaBtn.layer.shadowOffset = CGSizeMake(0, 0);
    sepiaBtn.layer.shadowRadius = 1;
    sepiaBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    sepiaBtn.layer.shadowOpacity = 0.5;
    [self.toolView addSubview:sepiaBtn];
    sepiaBtn.btnTouch = ^(){
        if (self.setCallBack) {
            self.setCallBack(setColorSepia);
        }
    };
    //白色

    WxxButton *whiteBtn = [[WxxButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(sepiaBtn.frame)+15, 5, 45, 45)];
    whiteBtn.layer.cornerRadius = 45/2;
    whiteBtn.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:blackBtn.bounds cornerRadius:45/2].CGPath;
    whiteBtn.layer.shadowOffset = CGSizeMake(0, 0);
    whiteBtn.layer.shadowRadius = 1;
    whiteBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    greenBtn.layer.shadowOpacity = 0.5;
    whiteBtn.layer.borderColor = WXXCOLOR(0, 0, 0, 0.54).CGColor;
    whiteBtn.layer.borderWidth = 0.5;
    [self.toolView addSubview:whiteBtn];
    whiteBtn.btnTouch = ^(){
        if (self.setCallBack) {
            self.setCallBack(setColorWhite);
        }
    };
}

//********************************* 字体 ************************************************//
-(void)initFontView{

    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 55, UIBounds.size.width, 0.5)];
    line1.backgroundColor = WXXCOLOR(0, 0, 0, 0.2);
    [self.toolView addSubview:line1];
    WxxLabel *lb3 = [[WxxLabel alloc]initWithFrame:CGRectMake(16, 110, 30, 55) color:WXXCOLOR(0, 0, 0, 1) font:15];
    lb3.text = @"字体";
    [self.toolView addSubview:lb3];
    
    WxxButton *oneFtBtn = [[WxxButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lb3.frame)+15, 115, 45, 45) title:@"字" textColor:WXXCOLOR(0, 0, 0, 1) font:18];
    oneFtBtn.layer.cornerRadius = 45/2;
    oneFtBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18];;;
    oneFtBtn.layer.masksToBounds = YES;
    oneFtBtn.layer.borderColor = WXXCOLOR(0, 0, 0, 1).CGColor;
    oneFtBtn.layer.borderWidth = 1;
    [self.toolView addSubview:oneFtBtn];
    oneFtBtn.btnTouch = ^(){
        if (self.setCallBack) {
            self.setCallBack(setFontFamilyMis);
        }
    };
    
    
    WxxButton *twoFtBtn = [[WxxButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(oneFtBtn.frame)+15, 115, 45, 45) title:@"字" textColor:WXXCOLOR(0, 0, 0, 1) font:18];
    twoFtBtn.layer.cornerRadius = 45/2;
    twoFtBtn.titleLabel.font = [UIFont fontWithName:@"Roboto-Light" size:18];;;
    twoFtBtn.layer.masksToBounds = YES;
    twoFtBtn.layer.borderColor = WXXCOLOR(0, 0, 0, 1).CGColor;
    twoFtBtn.layer.borderWidth = 1;
    [self.toolView addSubview:twoFtBtn];
    twoFtBtn.btnTouch = ^(){
        if (self.setCallBack) {
            self.setCallBack(setFontFamilySong);
        }
    };
    
    WxxButton *threeFtBtn = [[WxxButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(twoFtBtn.frame)+15, 115, 45, 45) title:@"字" textColor:WXXCOLOR(0, 0, 0, 1) font:18];
    threeFtBtn.layer.cornerRadius = 45/2;
    threeFtBtn.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:18];;;
    threeFtBtn.layer.masksToBounds = YES;
    threeFtBtn.layer.borderColor = WXXCOLOR(0, 0, 0, 1).CGColor;
    threeFtBtn.layer.borderWidth = 1;
    [self.toolView addSubview:threeFtBtn];
    threeFtBtn.btnTouch = ^(){
        if (self.setCallBack) {
            self.setCallBack(setHelveticaNeueThin);
        }
    };
    
}


//********************************* 大小 ************************************************//
- (void)initSegmentedControl
{
    WxxLabel *lb2 = [[WxxLabel alloc]initWithFrame:CGRectMake(16, 55, 30, 55) color:WXXCOLOR(0, 0, 0, 1) font:15];
    lb2.text = @"字号";
    [self.toolView addSubview:lb2];
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 110, UIBounds.size.width, 0.5)];
    line2.backgroundColor = WXXCOLOR(0, 0, 0, 0.2);
    [self.toolView addSubview:line2];
    
    NSArray *segmentedData = [[NSArray alloc]initWithObjects:@"小",@"中",@"大",@"超大",nil];
    self.segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedData];
    self.segmentedControl.frame = CGRectMake(CGRectGetMaxX(lb2.frame)+15, 67.5,UIBounds.size.width-CGRectGetMaxX(lb2.frame)-15-16, 30.0);
    
    /*
     这个是设置按下按钮时的颜色
     */
    self.segmentedControl.tintColor = [UIColor colorWithRed:49.0 / 256.0 green:148.0 / 256.0 blue:208.0 / 256.0 alpha:1];
//    self.segmentedControl.selectedSegmentIndex = 0;//默认选中的按钮索引
    [self segmentSelect];
    
    /*
     下面的代码实同正常状态和按下状态的属性控制,比如字体的大小和颜色等
     */
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:12],NSFontAttributeName,[UIColor redColor], NSForegroundColorAttributeName, nil];
    
    
    [self.segmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    
    
    NSDictionary *highlightedAttributes = [NSDictionary dictionaryWithObject:[UIColor redColor] forKey:NSForegroundColorAttributeName];
    
    [self.segmentedControl setTitleTextAttributes:highlightedAttributes forState:UIControlStateHighlighted];
    
    //设置分段控件点击相应事件
    [self.segmentedControl addTarget:self action:@selector(doSomethingInSegment:)forControlEvents:UIControlEventValueChanged];
    
    [self.toolView addSubview:self.segmentedControl];
}

-(void)segmentSelect{
    
    int _currentTextSize = [[[NSUserDefaults standardUserDefaults]objectForKey:@"bodyFont"] intValue];
    switch (_currentTextSize) {
        case fontlitte:
            self.segmentedControl.selectedSegmentIndex = 0;
            break;
        case fontmilllitte:
            self.segmentedControl.selectedSegmentIndex = 1;
            break;
        case fontbig:
            self.segmentedControl.selectedSegmentIndex = 2;
            break;
        case fontmaxbig:
            self.segmentedControl.selectedSegmentIndex = 3;
            break;
        default:
            break;
    }
    
}

-(void)doSomethingInSegment:(UISegmentedControl *)Seg
{
    
    NSInteger Index = Seg.selectedSegmentIndex;
    setType type = setFontLittle;
    switch (Index)
    {
        case 0:
            type = setFontLittle;
            break;
        case 1:
            type = setFontMillLittle;
            break;
        case 2:
            type = setFontBig;
            break;
        case 3:
            type = setFontMaxBig;
            break;
        default:
            break;
    }
    
    if (self.setCallBack) {
        self.setCallBack(type);
    }
}

-(void)initTouch{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.delegate = self;
    [self addGestureRecognizer:singleTap];
}
- (void)handleSingleTap:(UITapGestureRecognizer *)gestureRecognizer {
    CGPoint location = [gestureRecognizer locationInView:self];
    
    if (location.y > CGRectGetMinY(_toolView.frame)) {
        return;//如果点击在tablview内，不做隐藏动画
    }
    [self hideSelf];
}

-(void)showSelf{
    if (self.hidden) {
        [self PopToy:UIBounds.size.height-CGRectGetHeight(self.toolView.frame)/2];
    }else{
        [self PopToy:UIBounds.size.height+CGRectGetHeight(self.toolView.frame)/2];
    }
}
-(void)hideSelf{
    if (!self.hidden) {
        
        [self PopToy:UIBounds.size.height+CGRectGetHeight(self.toolView.frame)/2];
    }
}


-(void)PopToy:(float)orgx{
    
    if (_blackView.alpha >= 0.5) {
        [UIView animateWithDuration:1.0 animations:^{
            
            _blackView.alpha = 0;
        }completion:^(BOOL finished) {
            self.hidden = YES;
        }];
    }else{
        self.hidden = NO;
        [UIView animateWithDuration:1.0 animations:^{
            
            _blackView.alpha = 0.5;
        }completion:^(BOOL finished) {
            
        }];
    }
    
    POPSpringAnimation *onscreenAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    onscreenAnimation.toValue = @(orgx);
    onscreenAnimation.springBounciness =0;  //反弹
    onscreenAnimation.springSpeed = 20;//[0, 20] 速度
    onscreenAnimation.dynamicsTension = 3000; //动态张力
    onscreenAnimation.dynamicsFriction = 500;//摩擦
    onscreenAnimation.dynamicsMass = 20;//质量
    [onscreenAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        
    }];
    [self.toolView.layer pop_addAnimation:onscreenAnimation forKey:@"onscreenAnimation"];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
