//
//  WxxWebViewController.m
//  wxxRss
//
//  Created by weng xiangxun on 15/5/18.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "WxxWebViewController.h"
#import "NJKWebViewProgressView.h"
@interface WxxWebViewController ()
@property (nonatomic, strong)UIWebView *webView;
@property (nonatomic,strong)UIView *titlV;
@end

@implementation WxxWebViewController{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
   
}

-(void)initWebWithUrl:(NSString *)url title:(NSString *)title{

    [self initTitleBar:title];
    [self initWebView:url];
}

//标题
-(void)initTitleBar:(NSString *)title{
    UIView *titlV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.height, 64)];
    titlV.backgroundColor = WXXCOLOR(0, 0, 0, 1);
    titlV.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:titlV.bounds cornerRadius:3].CGPath;
    titlV.layer.shadowOffset = CGSizeMake(0, 0);
    titlV.layer.shadowRadius = 1;
    titlV.layer.shadowColor = [UIColor blackColor].CGColor;
    titlV.layer.shadowOpacity = 0.5;
    [self.view addSubview:titlV];
    self.titlV = titlV;
    WxxLabel *titlLb = [[WxxLabel alloc]initWithFrame:CGRectMake(0, 30, UIBounds.size.width, 18)
                                                color:WXXCOLOR(255,255,255, 1)
                                                 font:18];
    titlLb.textAlignment = NSTextAlignmentCenter;
    titlLb.text = title;
    [titlV addSubview:titlLb];
    
    UIImage *img = [UIImage imageNamed:@"close"];
    WxxButton *closeBtn = [[WxxButton alloc]initWithFrame:CGRectMake(16, 20+(44-img.size.height)/2, img.size.width, img.size.height) image:img];
    [titlV addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
}
-(void)close{
[[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];

}


-(void)initWebView:(NSString *)urlstr{
//    [[WxxLoadView sharedWxxLoadView]showself];
    self.webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 64, UIBounds.size.width, UIBounds.size.height-64)];
    self.webView.delegate=self;
    [self.view addSubview:self.webView];
    self.webView.backgroundColor = [UIColor whiteColor];
    self.webView.scalesPageToFit = YES;
    //1.创建网络请求
    NSURL *url=[NSURL URLWithString:urlstr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    //加载网络请求
    [self.webView loadRequest:request];
    
    
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webView.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect barFrame = CGRectMake(0, self.titlV.frame.size.height- progressBarHeight, self.titlV.frame.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    

}
#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
- (void)webViewDidFinishLoad:(UIWebView *)theWebView{
//    [[WxxLoadView sharedWxxLoadView]hideSelf];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.titlV addSubview:_progressView];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [_progressView removeFromSuperview];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
