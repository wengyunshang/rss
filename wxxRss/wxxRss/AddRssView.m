//
//  AddRssView.m
//  wxxRss
//
//  Created by weng xiangxun on 15/5/21.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "AddRssView.h"
#import "POPSpringAnimation.h"
@interface AddRssView()
@property (nonatomic,strong)WxxTextField *nameFld;
@property (nonatomic,strong)WxxTextField *urlFld;
@property (nonatomic,strong)WxxButton *saveBtn;
@property (nonatomic,strong)UIView *blackView;
@property (nonatomic,strong)UIView *addView;
@end
@implementation AddRssView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = WXXCOLOR(0, 0, 0, 0.2).CGColor;
        
        self.blackView = [[UIView alloc]initWithFrame:UIBounds];
        self.blackView.backgroundColor = WXXCOLOR(0, 0, 0, 1);
        self.blackView.alpha = 0.5;
        [self addSubview:self.blackView];
        
        self.addView = [[UIView alloc]initWithFrame:CGRectMake(0, -180, UIBounds.size.width, 180)];
        self.addView.backgroundColor = [UIColor whiteColor];
        self.addView.layer.cornerRadius = 2;
        [self addSubview:self.addView];
        
        [self initNameFd];
        [self initurlFd];
//        [self initColorBtns];
        [self initSaveBtn];
        
    }
    return self;
}

-(void)initColorBtns{
    
    WxxButton *blackBtn = [[WxxButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.urlFld.frame)+5, 40, 40)];
    blackBtn.backgroundColor = WXXCOLOR(0, 0, 0, 1);
    blackBtn.layer.cornerRadius = blackBtn.frame.size.width/2;
    blackBtn.layer.borderWidth = 0.5;
    blackBtn.layer.borderColor = WXXCOLOR(0, 0, 0, 0.2).CGColor;
    [self.addView addSubview:blackBtn];
}

-(void)initSaveBtn{
    self.saveBtn = [[WxxButton alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.addView.frame)-70)/2, CGRectGetMaxY(self.urlFld.frame)+15, 70, 38) title:@"添加" textColor:WXXCOLOR(0, 0, 0, 0.87) font:18];
    self.saveBtn.backgroundColor = WXXCOLOR(255, 255, 255, 1);
    self.saveBtn.layer.borderColor = WXXCOLOR(0, 0, 0, 0.2).CGColor;
    self.saveBtn.layer.borderWidth = 1;
    self.saveBtn.layer.cornerRadius = 2;
//    self.saveBtn.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.saveBtn.bounds cornerRadius:2].CGPath;
//    self.saveBtn.layer.shadowOffset = CGSizeMake(0, 0);
//    self.saveBtn.layer.shadowRadius = 1;
//    self.saveBtn.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.saveBtn.layer.shadowOpacity = 0.3;
    [self.addView addSubview:self.saveBtn];
    [self.saveBtn addTarget:self action:@selector(saveNewRss) forControlEvents:UIControlEventTouchUpInside];
}

-(void)saveNewRss{
    if ([self.nameFld.text length]<=0) {
        [[WxxPopView sharedWxxPopView]showPopText:@"请输入rss名称"];
    }
    if ([self.urlFld.text length]<=0) {
        [[WxxPopView sharedWxxPopView]showPopText:@"请输入rss网址"];
    }
    
    NSURL *ss = [self smartURLForString:self.urlFld.text];
    if (ss) {
        RssClassData *sinaNBAdata = [[RssClassData alloc]init];
        sinaNBAdata.rrcLink = self.urlFld.text;
        sinaNBAdata.rrcName = self.nameFld.text;
        sinaNBAdata.rrr = @"0";
        sinaNBAdata.rrg = @"0";
        sinaNBAdata.rrb = @"0";
        sinaNBAdata.rrcbigId = @"0";
        sinaNBAdata.rrccheckselect = WXXYES;
        sinaNBAdata.rrcId = [NSString stringWithFormat:@"%d",[[PenSoundDao sharedPenSoundDao]selectMaxRssclassId]+1];  //最大ID加1
        [sinaNBAdata saveSelfToDB];
        [self resignFirstRespond];
        
        
        //    [self checkUrl:@"asdfasfhttsp://www.baidu.com/"];
        [self hideSelf];
        if (self.setCallBack) {
            self.setCallBack();
        }
    }
    
   
}

-(void)initNameFd{

    self.nameFld = [[WxxTextField alloc]initWithFrame:CGRectMake(12,10,CGRectGetWidth(self.addView.frame)-24,50)];
    self.nameFld.placeholder = @"rss名称";
            self.nameFld.keyboardType = UIKeyboardTypeASCIICapable;
    self.nameFld.keyboardAppearance = UIKeyboardAppearanceDark;
    //        self.phoneFld.alpha = 0.4;
    //        self.nameFld.text = @"你好";
    self.nameFld.delegate = self;
    self.nameFld.returnKeyType = UIReturnKeyDone;
    self.nameFld.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0];
    self.nameFld.textColor = WXXCOLOR(0, 0, 0, 0.87);
//    [self.nameFld setValue:WXXCOLOR(0, 0, 0, 0.4) forKeyPath:@"_placeholderLabel.textColor"];
    [self.nameFld setValue:[UIFont fontWithName:@"STHeitiSC-Light" size:15.0] forKeyPath:@"_placeholderLabel.font"];
    [self.addView addSubview:self.nameFld];

    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.nameFld.frame)-0.5, CGRectGetWidth(self.nameFld.frame), 0.5)];
    line.backgroundColor = WXXCOLOR(0, 0, 0, 0.25);
    [self.nameFld addSubview:line];
}

-(void)initurlFd{
    
    self.urlFld = [[WxxTextField alloc]initWithFrame:CGRectMake(12,CGRectGetMaxY(self.nameFld.frame)+5,CGRectGetWidth(self.addView.frame)-24,50)];
    self.urlFld.placeholder = @"rss网址(http://...)";
            self.nameFld.keyboardType = UIKeyboardTypeURL;
    self.urlFld.keyboardAppearance = UIKeyboardAppearanceDark;
    //        self.phoneFld.alpha = 0.4;
    //        self.nameFld.text = @"你好";
    self.urlFld.delegate = self;
    self.urlFld.returnKeyType = UIReturnKeyDone;
    self.urlFld.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15.0];
    self.urlFld.textColor = WXXCOLOR(0, 0, 0, 0.87);
//    [self.urlFld setValue:WXXCOLOR(0, 0, 0, 0.4) forKeyPath:@"_placeholderLabel.textColor"];
    [self.urlFld setValue:[UIFont fontWithName:@"STHeitiSC-Light" size:15.0] forKeyPath:@"_placeholderLabel.font"];
    [self.addView addSubview:self.urlFld];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.urlFld.frame)-0.5, CGRectGetWidth(self.urlFld.frame), 0.5)];
    line.backgroundColor = WXXCOLOR(0, 0, 0, 0.25);
    [self.urlFld addSubview:line];
}


-(void)showSelf{
    self.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        self.blackView.alpha = 0.7;
    }completion:^(BOOL finished) {
    }];
    [self showPopToy:CGRectGetHeight(self.addView.frame)/2+20 view:self.addView];
}

-(void)hideSelf{
    [UIView animateWithDuration:0.5 animations:^{
        
        self.blackView.alpha = 0;
    }completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    [self showPopToy:-CGRectGetHeight(self.addView.frame)/2 view:self.addView];
}

-(void)showPopToy:(float)orgy view:(UIView *)view{
    
    POPSpringAnimation *onscreenAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    onscreenAnimation.toValue = @(orgy);
    onscreenAnimation.springBounciness =0;  //反弹
    onscreenAnimation.springSpeed = 20;//[0, 20] 速度
    onscreenAnimation.dynamicsTension = 4000; //动态张力
    onscreenAnimation.dynamicsFriction = 500;//摩擦
    onscreenAnimation.dynamicsMass = 20;//质量
//        [self.onscreenAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
//    
//        }];
    [view.layer pop_addAnimation:onscreenAnimation  forKey:@"myKey"];
}

-(void)resignFirstRespond{
    [self.nameFld resignFirstResponder];
    [self.urlFld resignFirstResponder];
}


- (NSURL *)smartURLForString:(NSString *)str
{
    NSURL *     result;
    NSString *  trimmedStr;
    NSRange     schemeMarkerRange;
    NSString *  scheme;
    
    assert(str != nil);
    
    result = nil;
    
    trimmedStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if ( (trimmedStr != nil) && (trimmedStr.length != 0) ) {
        schemeMarkerRange = [trimmedStr rangeOfString:@"://"];
        
        if (schemeMarkerRange.location == NSNotFound) {
//            result = [NSURL URLWithString:[NSString stringWithFormat:@"http://%@", trimmedStr]];
            [[WxxPopView sharedWxxPopView]showPopText:@"url好像不正确（http://）"];
        } else {
            scheme = [trimmedStr substringWithRange:NSMakeRange(0, schemeMarkerRange.location)];
            assert(scheme != nil);
            
            if ( ([scheme compare:@"http"  options:NSCaseInsensitiveSearch] == NSOrderedSame)
                || ([scheme compare:@"https" options:NSCaseInsensitiveSearch] == NSOrderedSame) ) {
                result = [NSURL URLWithString:trimmedStr];
            } else {
                // It looks like this is some unsupported URL scheme.
            }
        }
    }
    
    return result;
}
-(void)checkUrl:(NSString *)urlString{
    //    NSError *error = NULL;
    //    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(<img\\s[\\s\\S]*?src\\s*?=\\s*?['\"](.*?)['\"][\\s\\S]*?>)+?"
    //                                                                           options:NSRegularExpressionCaseInsensitive
    //                                                                             error:&error];
    
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"http+:[^\\s]*" options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch = [regex firstMatchInString:urlString options:0 range:NSMakeRange(0, [urlString length])];
        
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            //从urlString中截取数据
            NSString *result = [urlString substringWithRange:resultRange];
            NSLog(@"%@",result);
        }else{
            showAlert(@"当", @"我书读的少，你可别骗我，你填写的是url吗？");
//            [[WxxPopView sharedWxxPopView]showPopText:@"我书读的少，你可别骗我，你填写的是url吗？"];
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
