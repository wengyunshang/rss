//
//  WxxBaseViewController.m
//  WxxAccount
//
//  Created by weng xiangxun on 15/4/22.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "WxxBaseViewController.h"
@interface WxxBaseViewController ()

@end

@implementation WxxBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


-(void)backColor{
    CAGradientLayer *_gradientLayer = [CAGradientLayer layer];  // 设置渐变效果
    _gradientLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    _gradientLayer.colors = [NSArray arrayWithObjects:
                             (id)[WXXCOLOR(144, 200, 208, 1) CGColor],
                             (id)[WXXCOLOR(199, 225, 215, 1) CGColor],
                             (id)[WXXCOLOR(195, 223, 205, 1) CGColor], nil];
    _gradientLayer.startPoint = CGPointMake(0, 0);
    _gradientLayer.endPoint = CGPointMake(0, 1.0);
    //    _gradientLayer.hidden = YES;
    [self.view.layer addSublayer:_gradientLayer];
}


-(UIBarButtonItem*) createTitlebtn:(NSString*)title action:(SEL)action
{
//    UIImage *img = [UIImage imageNamed:imgstr];
    
    CGRect backframe= CGRectMake(0, 0, 36, 24);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    //    backButton.backgroundColor = WXXCOLOR(255, 255, 255, 1);
    //    [backButton setImage:img forState:UIControlStateNormal];
//    [backButton setBackgroundImage:img forState:UIControlStateNormal];
        [backButton setTitle:title forState:UIControlStateNormal];
        [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font=[UIFont systemFontOfSize:18];
    [backButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    //定制自己的风格的 UIBarButtonItem
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return someBarButtonItem;
}

//shoucanglight
-(UIBarButtonItem*) createRightbarbtn:(NSString*)imgstr action:(SEL)action
{
    UIImage *img = [UIImage imageNamed:imgstr];
    
    CGRect backframe= CGRectMake(0, 0, 24, 24);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    //    backButton.backgroundColor = WXXCOLOR(255, 255, 255, 1);
    //    [backButton setImage:img forState:UIControlStateNormal];
    [backButton setBackgroundImage:img forState:UIControlStateNormal];
    //    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    //    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    backButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [backButton addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    //定制自己的风格的 UIBarButtonItem
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return someBarButtonItem;
}

-(void)whiteBack{
    self.navigationItem.leftBarButtonItem = [self createRightbarbtn:@"backwhite" action:@selector(back)];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(UIBarButtonItem*) createHeadBbarbtn

{
    UIImage *img = [UIImage imageNamed:@"whitehead"];
    
    CGRect backframe= CGRectMake(0, 0, img.size.width, img.size.height);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    //    backButton.backgroundColor = WXXCOLOR(255, 255, 255, 1);
    [backButton setImage:img forState:UIControlStateNormal];
    //    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    //    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [backButton addTarget:self action:@selector(showLeftView) forControlEvents:UIControlEventTouchUpInside];
    //定制自己的风格的 UIBarButtonItem
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return someBarButtonItem;
}

-(void)showLeftView{
//    [[LeftHbgView sharedLeftHbgView]showSelf];
}


-(UIBarButtonItem*) createBackButton

{
    UIImage *img = [UIImage imageNamed:@"whiteback"];
    
    CGRect backframe= CGRectMake(0, 0, img.size.width, img.size.height);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    //    backButton.backgroundColor = WXXCOLOR(255, 255, 255, 1);
    [backButton setImage:img forState:UIControlStateNormal];
    //    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    //    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font=[UIFont systemFontOfSize:12];
    [backButton addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    //定制自己的风格的 UIBarButtonItem
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return someBarButtonItem;
    
    // return [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleBordered target:self action:@selector(popself)];
    
}

-(void)popself{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
