//
//  SMDetailViewController.m
//  RSSRead
//
//  Created by ming on 14-3-21.
//  Copyright (c) 2014年 starming. All rights reserved.
//

#import "SMDetailViewController.h"
#import "SetView.h"
#define textSizeRule @"TextSizeRule"
#define bodyFont @"bodyFont"
#define bodyColor @"bodyColor"
#define bodyFammly @"bodyfammly"
#import <Comment/Comment.h>
#import <Comment/Comment+Base.h>
#define selectTypeKey @"selectType"
#define  SHEET @"var mySheet = document.styleSheets[0];"
#define  ADDCSSRULE @"function addCSSRule(selector, newRule) {if (mySheet.addRule) {mySheet.addRule(selector, newRule);} else {ruleIndex = mySheet.cssRules.length;mySheet.insertRule(selector + '{' + newRule + ';}', ruleIndex);}}"
#define deffont 14
@interface SMDetailViewController ()
@property (nonatomic,retain)NSString *setTextSizeRule;
@property(nonatomic,strong)NSString *showContent;
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,strong)SetView *setView;
@property(nonatomic,strong)UIView *statusView;
@property(nonatomic,strong)WxxButton *saveBtn;
@property(nonatomic,strong)WxxButton *talkBtn;
@property(nonatomic,strong)WxxLabel *talkNumLb;
@property int currentTextSize;//字体大小
@end

@implementation SMDetailViewController

-(void)doBack {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadView {
    [super loadView];
//    UISwipeGestureRecognizer *recognizer;
//    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(doBack)];
//    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
//    [[self view]addGestureRecognizer:recognizer];
//    recognizer = nil;
    //设置默认样式
    [self setViewBackGroundColor:[[[NSUserDefaults standardUserDefaults] objectForKey:selectTypeKey] intValue]];
    //    [self initWebView];
    [self initSetView];  //设置界面
    [self initBottomBar]; //底部工具
    //    [self renderDetailViewFromRSS];
    //显示工具栏
    //    [self showCommentToolbarWithContentId:@"123456" title:@"文章标题"];
//    [self refreshComment];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    [self refreshComment];
    //
    //    [self renderDetailViewFromRSS];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //    [_webView loadHTMLString:@"" baseURL:nil];
}

-(void)initWebView{
    if (!_webView) {
        CGRect rect = self.view.bounds;
        rect.size.height = rect.size.height-44;
        rect.size.width = rect.size.width;
        _webView = [[UIWebView alloc]initWithFrame:rect];
        [_webView setBackgroundColor:[UIColor clearColor]];
        //    _webView.scalesPageToFit = YES;
        _webView.delegate = self;
        _webView.opaque = NO;
        [(UIScrollView *)[[_webView subviews] objectAtIndex:0] setBounces:NO];
        _webView.scrollView.directionalLockEnabled = YES;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        [self.view insertSubview:self.webView belowSubview:self.setView];
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    
    
}

-(void)refreshComment{
    id<ISSCCommentList> ll =[Comment commentListWithContentId:_rss.rrlink title:_rss.rrtitle order:nil];
    if ([[ll data] count] == 0)
    {
        
        [ll update:^(SSResponseState state, NSError *error) {
            if (state != SSResponseStateSuccess){
                return;
            }
            NSArray *arr = [ll data];
            self.talkNumLb.text = [NSString stringWithFormat:@"%ld",arr.count];
        }];
    }
    //
    
}



//******************************************工具栏设置web字体，颜色等******************************************//
-(void)initSetView{
    if (!self.setView) {
        self.setView = [[SetView alloc]initWithFrame:UIBounds];
        [self.view addSubview:self.setView];
        __block SMDetailViewController *blockself = self;
        self.setView.setCallBack = ^(setType type){
            [blockself setViewBackGroundColor:type];
        };
    }
}

-(void)setViewBackGroundColor:(setType)type{
    UIColor *color = [UIColor whiteColor];
    switch (type) {
            
        case setFontFamilySong:
            [self setHtmlFammly:@"STHeitiSC-Light"];
            break;
        case setFontFamilyMis:
            [self setHtmlFammly:@"HelveticaNeue-Light"];
            break;
        case setHelveticaNeueThin:
            [self setHtmlFammly:@"HelveticaNeue-Thin"];
            break;
            
        case setFontLittle:
            [self setHtmlTextFont:fontlitte];
            break;
        case setFontMillLittle:
            [self setHtmlTextFont:fontmilllitte];
            break;
        case setFontBig:
            [self setHtmlTextFont:fontbig];
            break;
        case setFontMaxBig:
            [self setHtmlTextFont:fontmaxbig];
            break;
            
        case setColorWhite:
            color = [UIColor whiteColor];
            [self setHtmlTextRule:@"#000"];  //字体颜色 先
            [self setBackViewEvrything:color]; //背景  后
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",type] forKey:selectTypeKey];
            break;
        case setColorSepia:
            color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reading_background_sepia"]];
            [self setHtmlTextRule:@"#000"];  //字体颜色 先
            [self setBackViewEvrything:color]; //背景  后
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",type] forKey:selectTypeKey];
            break;
        case setColorGreen:
            
            color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reading_background_green"]];
            [self setHtmlTextRule:@"#000"];  //字体颜色 先
            [self setBackViewEvrything:color]; //背景  后
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",type] forKey:selectTypeKey];
            break;
        case setColorBlack:
            
            color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"reading_background_night"]];
            [self setHtmlTextRule:@"#a0a064"];  //字体颜色 先
            [self setBackViewEvrything:color]; //背景  后
            [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",type] forKey:selectTypeKey];
            break;
        default:
            break;
    }
}

-(void)setHtmlFammly:(NSString *)fammly{
    [[NSUserDefaults standardUserDefaults]setObject:fammly forKey:bodyFammly];
    [self setTextSizeRuleValue];
    //设置html的字体颜色，大小
    [self.webView stringByEvaluatingJavaScriptFromString:self.setTextSizeRule];
}
//设置文本颜色和大小
-(void)setHtmlTextRule:(NSString *)colorStr{
    if (!colorStr) {colorStr = @"#000";}
    [[NSUserDefaults standardUserDefaults]setObject:colorStr forKey:bodyColor];
}
-(void)setHtmlTextFont:(int)textFont{
    if (!textFont) {textFont = deffont;}
    [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%d",textFont] forKey:bodyFont];
    [self setTextSizeRuleValue];
    //设置html的字体颜色，大小
    [self.webView stringByEvaluatingJavaScriptFromString:self.setTextSizeRule];
    
    //    [self setTextSizeRuleValue];
}
//设置body的 字体，颜色
-(void)setTextSizeRuleValue{
    NSString *colorStr = [[NSUserDefaults standardUserDefaults]objectForKey:bodyColor];
    _currentTextSize = [[[NSUserDefaults standardUserDefaults]objectForKey:bodyFont] intValue];
    NSString *fammly = [[NSUserDefaults standardUserDefaults]objectForKey:bodyFammly];
    if (!fammly) {
        fammly = @"HelveticaNeue-Light";
    }
    if (!colorStr) {colorStr = @"#000";}
    if (_currentTextSize <= 0) {_currentTextSize = deffont;}
    NSString *string = [NSString stringWithFormat:@"addCSSRule('body', 'color:%@;font-size:%dpt;font-family:\"%@\"')",colorStr,_currentTextSize,fammly];
    self.setTextSizeRule = string;
}
-(void)setBackViewEvrything:(UIColor *)backColor{
    
    [self setTextSizeRuleValue];
    //设置html的字体颜色，大小
    [self.webView stringByEvaluatingJavaScriptFromString:self.setTextSizeRule];
    
    NSString *string = [NSString stringWithFormat:@"addCSSRule('*', 'max-width:100%%;')"];
    [self.webView stringByEvaluatingJavaScriptFromString:string];
    
    //设置背景色
    //    UIImageView *img = [[UIImageView alloc]initWithImage:[ResourceHelper loadImageByTheme:@"background"]];
    //    img.frame = CGRectMake(0, 0, img.image.size.width, img.image.size.height);
    //    [self.backView insertSubview:img atIndex:1];
    self.view.backgroundColor = backColor;
    if (!self.statusView) {
        self.statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, 20)];
        [self.view addSubview:self.statusView];
    }
    self.statusView.backgroundColor = backColor;
}

/**
 *  显示评论
 */
-(void)showCommentVC{
    [self presentCommentListViewControllerWithContentId:_rss.rrlink title:_rss.rrtitle animated:YES];
}
//***************************************底部***********************************************//
-(void)initBottomBar{
    
    UIView *bottomBar = [[UIView alloc]initWithFrame:CGRectMake(0, UIBounds.size.height-44, UIBounds.size.width, 44)];
    bottomBar.backgroundColor = [UIColor whiteColor];
    bottomBar.layer.borderWidth = 0.5;
    bottomBar.layer.borderColor = WXXCOLOR(0, 0, 0, 0.2).CGColor;
    //    bottomBar.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:bottomBar.bounds cornerRadius:3].CGPath;
    //    bottomBar.layer.shadowOffset = CGSizeMake(0, 0);
    //    bottomBar.layer.shadowRadius = 1;
    //    bottomBar.layer.shadowColor = [UIColor blackColor].CGColor;
    //    bottomBar.layer.shadowOpacity = 0.3;
    [self.view addSubview:bottomBar];
    
    //返回
    UIImage *img = [UIImage imageNamed:@"common_icon_return"];
    WxxButton *backBtn = [[WxxButton alloc]initWithFrame:CGRectMake(10, (CGRectGetHeight(bottomBar.frame)-img.size.height)/2, img.size.width, img.size.height) image:img];
    [backBtn addTarget:self action:@selector(doBack) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:backBtn];
    
    //评论
    self.talkBtn = [[WxxButton alloc]init];
    [self.talkBtn setImage:[UIImage imageNamed:@"talk.png"] forState:UIControlStateNormal];
    [bottomBar addSubview:self.talkBtn];
    [self.talkBtn addTarget:self action:@selector(showCommentVC) forControlEvents:UIControlEventTouchUpInside];
    
    self.talkNumLb = [[WxxLabel alloc]init];
    //    self.talkNumLb.text = @"22";
    self.talkNumLb.textColor = [UIColor whiteColor];
    self.talkNumLb.backgroundColor = [UIColor redColor];
    self.talkNumLb.layer.cornerRadius = 5;
    self.talkNumLb.font = [UIFont systemFontOfSize:10];
    self.talkNumLb.layer.masksToBounds = YES;
    self.talkNumLb.textAlignment = NSTextAlignmentCenter;
    [self.talkBtn addSubview:self.talkNumLb];
    self.talkNumLb.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *talkmet = @{@"orgx":@-5,@"orgy":@30};
    [self.talkBtn addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_talkNumLb(>=18)]-orgx-|" options:0 metrics:talkmet views:NSDictionaryOfVariableBindings(_talkNumLb,_talkBtn)]];
    [self.talkBtn addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_talkNumLb]" options:0 metrics:talkmet views:NSDictionaryOfVariableBindings(_talkNumLb,_talkBtn)]];
    
    //收藏
    UIImage *saveimg = [UIImage imageNamed:@"common_icon_heart_outline"];
    if ([self.rss ynCollect]) {
        saveimg = [UIImage imageNamed:@"common_icon_heart_orange"];
    }
    self.saveBtn = [[WxxButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(bottomBar.frame)-46-32-saveimg.size.width, (CGRectGetHeight(bottomBar.frame)-saveimg.size.height)/2, saveimg.size.width, saveimg.size.height) image:saveimg];
    [bottomBar addSubview:self.saveBtn];
    [self.saveBtn addTarget:self action:@selector(doCollect) forControlEvents:UIControlEventTouchUpInside];
    
    //设置
    UIImage *refimg = [UIImage imageNamed:@"bottomSet"];
    WxxButton *refreshBtn = [[WxxButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(bottomBar.frame)-16-img.size.width, (CGRectGetHeight(bottomBar.frame)-refimg.size.height)/2, refimg.size.width, refimg.size.height) image:refimg];
    [bottomBar addSubview:refreshBtn];
    [refreshBtn addTarget:self action:@selector(showSetView) forControlEvents:UIControlEventTouchUpInside];
    refreshBtn.alpha = 0.6;
    
    self.talkBtn.translatesAutoresizingMaskIntoConstraints = NO;
    self.saveBtn.translatesAutoresizingMaskIntoConstraints = NO;
    refreshBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(_talkBtn,_saveBtn,refreshBtn);
    NSString *width = [NSString stringWithFormat:@"%f",refimg.size.width];
    NSDictionary *met = @{@"width":width,@"padding":@30};
    [bottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_talkBtn(==30)]-padding-[_saveBtn(==width)]-padding-[refreshBtn(==width)]-20-|" options:0 metrics:met views:views]];
    //    self.shareBtn.hidden = YES;
    self.talkBtn.alpha = 0.7;
    //    //end
    [bottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-9-[_talkBtn(==30)]-|" options:NSLayoutFormatAlignAllCenterY metrics:met views:views]];
    [bottomBar addConstraint:[NSLayoutConstraint constraintWithItem:_talkBtn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:bottomBar attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    [bottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[_saveBtn(==width)]-|" options:0 metrics:met views:views]];
    [bottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[refreshBtn(==width)]-|" options:0 metrics:met views:views]];
}
-(void)doCollect{
    [self.saveBtn setImage:[UIImage imageNamed:@"common_icon_heart_orange"] forState:UIControlStateNormal];
    self.rss.rryncollect = WXXYES;
    [self.rss updateCollect];
    [[WxxPopView sharedWxxPopView]showPopText:@"收藏成功"];
}
-(void)showSetView{
    [self.setView showSelf];
}

- (NSString *)replaceImageHtml:(NSString *)oldHtml {
    NSString *regex = @"(<img.*?/>)"; NSRange r;
    NSMutableString *newHtml = [NSMutableString stringWithString:oldHtml];
    BOOL flag = false;
    while (flag == false) {
        r = [newHtml rangeOfString:regex options:NSRegularExpressionSearch];
        if (r.location != NSNotFound) {
            [newHtml replaceCharactersInRange:r withString:@"<img src=\"\" alt=\"Smiley face\" height=\"320\" width=\"200\">"];
        } else {
            flag = true;
        }
    };
    return newHtml;
}
-(void)renderDetailViewFromRSS {
    [self initWebView];
    
    _showContent = _rss.rrcontent;
    if ([_rss.rrcontent isEqualToString:@"无内容"]) {
        _showContent = _rss.rrsummary;
    }
    //是否开启3G 下载图片
    if (![WXXNETUTIL isOpen3g]) {
    
        _showContent = [self replaceImageHtml:_showContent];
    }
    
    //    NSString *filePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"js.html"];
    //    NSError *err=nil;
    //    NSString *mTxt=[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&err];
    //颜色
    //    NSString *rgbstr = [NSString stringWithFormat:@"rgb(%@,%@,%@)",self.rclassData.rrr,self.rclassData.rrg,self.rclassData.rrb];
    //  NSString *rgbstr = [NSString stringWithFormat:@"rgb(%@,%@,%@)",@"255",@"255",@"255"];
    //字体
    NSString *fammly = [[NSUserDefaults standardUserDefaults]objectForKey:bodyFammly];
    if (!fammly) {
        fammly = @"HelveticaNeue-Light";
    }
    if ([self.rss.rrauthor length]<=0) {
        self.rss.rrauthor = self.rclassData.rrcName; //无作者名就用频道名代替
    }
    //.mydiv{filter:progid:DXImageTransform.Microsoft.Shadow(color=#909090,direction=120,strength=3);-webkit-box-shadow: 0px 2px 4px #909090;/*safari或chrome*/}
    NSString *htmlStr = [NSString stringWithFormat:@"<!DOCTYPE html><html lang=\"zh-CN\"><head><style>a{text-decoration:none;outline:0none;pointer-events:none;color:#afafaf;cursor:default}html{font-family:\"%@\";}body{margin:0;border:0;padding:0;font-size:%dpt;max-width:100%%;}*{max-width:100%%;}img{MAX-WIDTH: 100%%!important;HEIGHT: auto!important;width:expression(this.width > 600 ? \"600px\" : this.width)!important;}a{max-width:100%%;}img{width:expression(this.width>600&&this.width>this.height?450:auto);height:expresion(this.height>450?450:auto);}</style></head><body><div style=\"position:fixed;z-index:3;height:20px;width:100%%;\"></div><div class=\"mydiv\" style=\"z-index:2;position:relative;height:150px;height:auto !important;color:#000;\"><h3 style=\"margin:0;border:0;padding-right:16px;padding-top:50px;padding-left:16px;padding-bottom:10px;\">%@</h3><h6 style=\"margin:0;border:0;padding:0;padding-top:5px;padding-left:16px;padding-bottom:20px;\">%@&nbsp&nbsp%@</h6></div><div style=\"margin-left:16px;margin-right:16px;margin-top:30px;\">%@</div><a  href=\"%@\" style=\"pointer-events:auto\"><button style=\"border:1px solid #fff ; background:#fff;color:#007979;font-size:15pt;margin-top:50px;margin-bottom:30px;width:100%%;height:50px;\" type=\"button\">原文</button></a></body></html>",fammly,_currentTextSize,_rss.rrtitle,_rss.rrauthor,_rss.rrpublished,_showContent,_rss.rrlink];
    
    
    [_webView loadHTMLString:htmlStr baseURL:nil];
    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *requestURL =[request URL];
    if (([[requestURL scheme] isEqualToString: @"http"] || [[requestURL scheme] isEqualToString:@"https"] || [[requestURL scheme] isEqualToString: @"mailto" ])
        && (navigationType == UIWebViewNavigationTypeLinkClicked)) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"showweburl" object:[requestURL absoluteString]];
        //        return ![[UIApplication sharedApplication] openURL:requestURL];
        return NO;
    }
    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    
}
- (void)webViewDidFinishLoad:(UIWebView *)theWebView{
    [_webView stringByEvaluatingJavaScriptFromString:SHEET];
    [_webView stringByEvaluatingJavaScriptFromString:ADDCSSRULE];
    //    if (!self.setTextSizeRule) { //避免多次设置，节省性能啦。
    //        [self setTextSizeRuleValue];
    //    }
    //    [self.webView stringByEvaluatingJavaScriptFromString:self.setTextSizeRule];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
