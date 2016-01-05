//
//  MJCollectionViewCell.m
//  RCCPeakableImageSample
//
//  Created by Mayur on 4/1/14.
//  Copyright (c) 2014 RCCBox. All rights reserved.
//

#import "RssCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "WxxTipView.h"
@interface RssCollectionViewCell()
@property (nonatomic,strong)WxxLabel *title;
@property (nonatomic,strong)WxxLabel *maxLb;
@property (nonatomic,strong)RssClassData *rsClassData;
@property (nonatomic,strong)UIImageView *imgV;
@property (nonatomic,strong)WxxLabel *tipNumV;

@property (nonatomic,strong)UIView *addBtn;
@property (nonatomic,strong)UIView *closeBtn;
@property (nonatomic,strong)UIView *vvv;
@property (nonatomic,strong)UIActivityIndicatorView *activityIndicator;
@end

@implementation RssCollectionViewCell

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
    self.backgroundColor = WXXCOLOR(0, 0, 0, 1);
    self.layer.cornerRadius = 1;
//    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:3].CGPath;
//    self.layer.shadowOffset = CGSizeMake(0, 1);
//    self.layer.shadowRadius = 1;
//    self.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.layer.shadowOpacity = 0.5;
    self.layer.borderColor = WXXCOLOR(0, 0, 0, 0.2).CGColor;
    self.layer.borderWidth = 0.5;
    
    self.vvv = [[UIView alloc]init];
    self.vvv.layer.cornerRadius = 1;
    self.vvv.layer.masksToBounds = YES;
    [self addSubview:self.vvv];
    self.vvv.backgroundColor = [UIColor clearColor];
    self.vvv.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_vvv]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_vvv)]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_vvv]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_vvv)]];
    
    
//    self.maxLb = [[WxxLabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height-25) color:WXXCOLOR(0, 0, 0, 1) font:40];
//    self.maxLb.textAlignment = NSTextAlignmentCenter;
//    [self.vvv addSubview:self.maxLb];
    
    self.imgV = [[UIImageView alloc]init];
    [self.vvv addSubview:self.imgV];
    self.imgV.translatesAutoresizingMaskIntoConstraints = NO;
    [self.vvv addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_imgV]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imgV)]];
    [self.vvv addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_imgV]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imgV)]];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];  // 设置渐变效果
    gradientLayer.bounds = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    gradientLayer.position = CGPointMake(self.bounds.size.width / 2,self.bounds.size.height * 0.5);
    gradientLayer.colors = [NSArray arrayWithObjects:
                            (id)[[UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.8] CGColor],
                            (id)[[UIColor clearColor] CGColor],
                            (id)[[UIColor clearColor] CGColor],nil];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1.0);
    [self.vvv.layer addSublayer:gradientLayer];
    
    self.title = [[WxxLabel alloc]init];
    self.title.textColor = WXXCOLOR(255, 255, 255, 1);
    [self.title setLineBreakMode:NSLineBreakByWordWrapping];
    self.title.numberOfLines = 0;
    self.title.insets = UIEdgeInsetsMake(5, 10, 5, 5);
    self.title.backgroundColor = WXXCOLOR(0, 0, 0, 0.0);
    self.title.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
    [self.vvv addSubview:self.title];
    self.title.translatesAutoresizingMaskIntoConstraints = NO;
    [self.vvv addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_title]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_title)]];
    [self.vvv addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_title]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_title)]];
    
    self.tipNumV = [[WxxLabel alloc]init];
//    self.tipNumV.backgroundColor = WXXCOLOR(0, 0, 0, 0.5);
    self.tipNumV.layer.cornerRadius = 2;
    self.tipNumV.textColor = WXXCOLOR(255, 255, 255, 1);
    self.tipNumV.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:15];
//    self.tipNumV.alpha = 0;
    self.tipNumV.textAlignment = NSTextAlignmentCenter;
    [self.vvv addSubview:self.tipNumV];
    self.tipNumV.translatesAutoresizingMaskIntoConstraints = NO;
    [self.vvv addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_tipNumV]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tipNumV)]];
    [self.vvv addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_tipNumV]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tipNumV)]];
    
    
    
    self.addBtn = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.addBtn.backgroundColor = [UIColor whiteColor];
    [self.vvv addSubview:self.addBtn];
    self.addBtn.layer.borderColor = WXXCOLOR(0, 0, 0, 0.2).CGColor;
    self.addBtn.layer.borderWidth = 0.5;
    UIView *shuLine = [[UIView alloc]initWithFrame:CGRectMake((self.frame.size.width-10)/2,  (self.frame.size.height-50)/2, 10, 50)];
    shuLine.backgroundColor = WXXCOLOR(0, 0, 0, 1);
    [self.addBtn addSubview:shuLine];
    
    UIView *hengline = [[UIView alloc]initWithFrame:CGRectMake((self.frame.size.width-50)/2,  (self.frame.size.height-10)/2, 50, 10)];
    hengline.backgroundColor = WXXCOLOR(0, 0, 0, 1);
    [self.addBtn addSubview:hengline];
    
    
    //加载旋转的风火轮
    self.activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.activityIndicator.frame = CGRectMake(self.frame.size.width-30, self.frame.size.height-30, 30, 30);
    [self addSubview:self.activityIndicator];
    
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_activityIndicator]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_activityIndicator)]];
//    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_activityIndicator]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_activityIndicator)]];
    
    
//    UIView *blackModel = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//    blackModel.backgroundColor = WXXCOLOR(0, 0, 0, 0.05);
//    [self addSubview:blackModel];
}


-(void)showChangeBtn{
    if (self.addBtn.hidden == NO) {
        return;//添加按钮不显示
    }
    if (!self.closeBtn) {
        self.closeBtn = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
//        [self.closeBtn setImage:[UIImage imageNamed:@"icon-times-circle"] forState:UIControlStateNormal];
        UIImage *image = [UIImage imageNamed:@"icon-times-circle"];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake((self.closeBtn.frame.size.width-image.size.width)/2, (self.closeBtn.frame.size.height-image.size.height)/2, image.size.width, image.size.height)];
        img.image = image;
        [self.closeBtn addSubview:img];
        self.closeBtn.backgroundColor = WXXCOLOR(0, 0, 0, 0.5);
        [self.vvv addSubview:self.closeBtn];
        self.closeBtn.layer.borderColor = WXXCOLOR(0, 0, 0, 0.2).CGColor;
        self.closeBtn.layer.borderWidth = 0.5;
        self.closeBtn.alpha = 0;
    }else{
        self.closeBtn.hidden = NO;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.closeBtn.alpha = 1;
    }];
}

//删除Rss
//-(void)removeRss{
//    [self.rsClassData deleteSelf];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateIndexList" object:nil];
//}

-(void)hideChangeBtn{
    
    if (self.closeBtn) {
        [UIView animateWithDuration:0.5 animations:^{
            self.closeBtn.alpha = 0;
        }completion:^(BOOL finished) {
            self.closeBtn.hidden = YES;
        }];

    }
}

-(void)setInfo:(RssClassData*)rssClassData{
    self.rsClassData = rssClassData;
    
//    [WXXNETUTIL getNewForClassId:self.rsClassData callback:^(id response) {
//        NSLog(@"加载完成");
//        [self performSelectorOnMainThread:@selector(refreshImageV) withObject:nil waitUntilDone:NO];
//    }];
    
    self.addBtn.hidden = YES;
    if ([self.rsClassData.rrcImage length]>0) {
        self.imgV.alpha = 1;
        
        NSString*sUrl = self.rsClassData.rrcImage;
        for(int i=0; i< [sUrl length];i++){
            int a = [sUrl characterAtIndex:i];
            if( a > 0x4e00 && a < 0x9fff)
                sUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)sUrl, nil, nil, kCFStringEncodingUTF8));
        }
        [self.imgV sd_setImageWithURL:[NSURL URLWithString:sUrl] placeholderImage:[UIImage imageNamed:@"IMG_0978.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
        }];
        
    }else{
        self.imgV.alpha = 0;
    }
    self.title.text = rssClassData.rrcName;
    [self.tipNumV setText:[[PenSoundDao sharedPenSoundDao]selectNewMessageCountForRcid:self.rsClassData.rrcId time:self.rsClassData.rrctime]];

}

-(void)refreshTipNumV{
    [self.tipNumV setText:[[PenSoundDao sharedPenSoundDao]selectNewMessageCountForRcid:self.rsClassData.rrcId time:self.rsClassData.rrctime]];
}

-(void)refreshImageV{
    [self.rsClassData refreshSelf];
    if ([self.rsClassData.rrcImage length]>0) {
        NSString*sUrl = self.rsClassData.rrcImage;
        for(int i=0; i< [sUrl length];i++){
            int a = [sUrl characterAtIndex:i];
            if( a > 0x4e00 && a < 0x9fff)
                sUrl = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)sUrl, nil, nil, kCFStringEncodingUTF8));
        }
        [self.imgV sd_setImageWithURL:[NSURL URLWithString:sUrl] placeholderImage:[UIImage imageNamed:@"IMG_0978.jpg"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [UIView animateWithDuration:1 animations:^{
                self.imgV.alpha = 1;
            }];
        }];
        
    }else{
        self.imgV.alpha = 0;
    }
//    NSLog(@"%@",self.rsClassData.rrcImage);
   [self.tipNumV setText:[[PenSoundDao sharedPenSoundDao]selectNewMessageCountForRcid:self.rsClassData.rrcId time:self.rsClassData.rrctime]];
}

-(void)startLoading{
    self.tipNumV.hidden = YES;
    [self.activityIndicator startAnimating];
}
-(void)stoptLoading{
    self.tipNumV.hidden = NO;
    self.activityIndicator.hidden = YES;
        [self.activityIndicator stopAnimating];
}

-(void)setAddbtn{
    self.closeBtn.hidden = YES;
    self.addBtn.hidden = NO;
}

@end
