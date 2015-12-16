//
//  LeftHbgView.m
//  zouzhe2.2
//
//  Created by weng xiangxun on 15/3/17.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "LeftHbgView.h"
#import "LeftTableViewCell.h"
#import "POPSpringAnimation.h"
#import "LeftHeadView.h"
//#import "WxxIapStore.h"
//#import "SDHeadImg+SDWebCache.h"


@interface LeftHbgView()
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UIView *leftView;
@property (nonatomic,strong)UIView *blackView;
@property (nonatomic,strong)LeftHeadView *headView;
@property (assign, nonatomic) float lastContentOffset;

@property (nonatomic,strong)WxxButton *loginBtn;
@property (nonatomic,strong)WxxButton *logoutBtn;
@property (nonatomic,strong)WxxButton *setBtn;


@property (nonatomic,strong)NSMutableArray *listArr;
@end

@implementation LeftHbgView
static LeftHbgView *_sharedLeftHbgView = nil;
/**
 数据库采用单例模式: 不必每个地方去管理
 */
+ (LeftHbgView *)sharedLeftHbgView{
    if (!_sharedLeftHbgView) {
        _sharedLeftHbgView = [[self alloc]initWithFrame:UIBounds];
//        [[[[UIApplication sharedApplication] delegate] window] addSubview:_sharedLeftHbgView];
    }
    return _sharedLeftHbgView;
}


- (id)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(0, 0, UIBounds.size.width, UIBounds.size.height);
    self = [super initWithFrame:frame];
    if (self) {
        //刷新界面
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reflashInfo) name:@"reflashInfo" object:nil];
        _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, UIBounds.size.height)];
        _blackView.backgroundColor = [UIColor blackColor];
        _blackView.alpha = 0.0;
        self.hidden = YES;
        [self addSubview:_blackView];
        
        
        
        
        
        self.leftView = [[UIView alloc]initWithFrame:CGRectMake(-264,0, 264, UIBounds.size.height)];
        [self addSubview:self.leftView];
        [self inittableView];
        
        
        
        
        [self initBtn];
        
        
//        self.setBtn = [[WxxButton alloc]initWithFrame:CGRectMake(0, UIBounds.size.height-56, 264, 56)];
//        //        self.setBtn.backgroundColor = [UIColor whiteColor];
//        //        [self.setBtn setImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
//        [self.leftView addSubview:self.setBtn];
//        
//        UIImageView *imgv2 = [[UIImageView alloc]initWithFrame:CGRectMake(16, (CGRectGetHeight(self.setBtn.frame)-24)/2, 24, 24)];
//        //        imgv2.backgroundColor = [UIColor blackColor];
//        imgv2.image = [UIImage imageNamed:@"set"];
//        [self.setBtn addSubview:imgv2];
//        
//        WxxLabel *lb2 = [[WxxLabel alloc]initWithFrame:CGRectMake(72, (CGRectGetHeight(self.setBtn.frame)-14)/2, 200, 14) color:WXXCOLOR(0, 0, 0, 0.87) font:14 alpha:1];
//        lb2.text = @"设置";
//        [self.setBtn addSubview:lb2];
//        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.loginBtn.frame.size.width, 0.5)];
//        line.backgroundColor = WXXCOLOR(0, 0, 0, 0.2);
//        [self.setBtn addSubview:line];
        
    }
    return self;
}


-(void)initBtn{
//    if (![USERDATA isLogin]) {
        if (self.logoutBtn) {
            self.logoutBtn.hidden = YES;
        }
        
        if (!self.loginBtn) {
            self.loginBtn = [[WxxButton alloc]initWithFrame:CGRectMake(0, UIBounds.size.height-56, 264, 56)];
            self.loginBtn.backgroundColor = [UIColor whiteColor];
            
            [self.leftView addSubview:self.loginBtn];
            [self.loginBtn addTarget:self action:@selector(backsss) forControlEvents:UIControlEventTouchUpInside];
            UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(16, (CGRectGetHeight(self.loginBtn.frame)-24)/2, 24, 24)];
            //        imgv.backgroundColor = [UIColor redColor];
            imgv.image = [UIImage imageNamed:@"left"];
            [self.loginBtn addSubview:imgv];
            
            WxxLabel *lb = [[WxxLabel alloc]initWithFrame:CGRectMake(72, (CGRectGetHeight(self.loginBtn.frame)-14)/2, 200, 14) color:WXXCOLOR(0, 0, 0, 0.87) font:14];
            lb.text =  @"";;
            [self.loginBtn addSubview:lb];
            
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.loginBtn.frame.size.width, 0.5)];
            line.backgroundColor = WXXCOLOR(0, 0, 0, 0.2);
            [self.loginBtn addSubview:line];
        }
        self.loginBtn.hidden = NO;
//    }else{
//        
//        if (self.loginBtn) {
//            self.loginBtn.hidden = YES;
//        }
//        
//        if (!self.logoutBtn) {
//            self.logoutBtn = [[WxxButton alloc]initWithFrame:CGRectMake(0, UIBounds.size.height-56, 264, 56)];
//            self.logoutBtn.backgroundColor = [UIColor whiteColor];
//            
//            [self.leftView addSubview:self.logoutBtn];
//            [self.logoutBtn addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
//            UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(16, (CGRectGetHeight(self.logoutBtn.frame)-24)/2, 24, 24)];
//            //        imgv.backgroundColor = [UIColor redColor];
//            imgv.image = [UIImage imageNamed:@"loginregister"];
//            [self.logoutBtn addSubview:imgv];
//            
//            WxxLabel *lb = [[WxxLabel alloc]initWithFrame:CGRectMake(72, (CGRectGetHeight(self.logoutBtn.frame)-14)/2, 200, 14) color:WXXCOLOR(0, 0, 0, 0.87) font:14 alpha:1];
//            lb.text = @"退出";
//            [self.logoutBtn addSubview:lb];
//            
//            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.logoutBtn.frame.size.width, 0.5)];
//            line.backgroundColor = WXXCOLOR(0, 0, 0, 0.2);
//            [self.logoutBtn addSubview:line];
//        }
//       self.logoutBtn.hidden = NO;
//    }
}

-(void)backsss{
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    CGRect rect = _tableView.frame;
    [self tablePopTox:- rect.size.width/2];
}
-(void)logout{
//    UIActionSheet *actionSheet = [[UIActionSheet alloc]initWithTitle:nil
//                                  
//                                                            delegate:self
//                                  
//                                                   cancelButtonTitle:@"取消"
//                                  
//                                              destructiveButtonTitle:nil
//                                  
//                                                   otherButtonTitles:@"退出",nil];
//    
//    actionSheet.actionSheetStyle =UIActionSheetStyleAutomatic;
//    
//    // [actionSheet showInView:[UIApplication sharedApplication].keyWindow];
//    
//    [actionSheet showInView:self];
    
}
-(void)login{
 
}

-(void)reflashInfo{
//    if ([USERDATA isLogin]) {
//        self.loginBtn.hidden = YES;
//    }else{
        self.loginBtn.hidden = NO;
//    }
    [self initBtn];
    [self.headView reflashInfo];
    [self initData];
    [self.tableView reloadData];
}

-(void)initData{
    [self.listArr removeAllObjects];
    self.listArr = nil;
    if (!self.listArr) {
        self.listArr = [[NSMutableArray alloc]init];
    }
    [self.listArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          @"收藏",@"text",
                                                          @"shoucanglight",@"image",
                                                          [NSString stringWithFormat:@"%d",setCollect],@"leftType",nil]];
    [self.listArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                             @"团队简介",@"text",
                             @"pcarred",@"image",
                             [NSString stringWithFormat:@"%d",setWebView],@"leftType",nil]];
    [self.listArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                             @"建议和评论",@"text",
                             @"zang",@"image",
                             [NSString stringWithFormat:@"%d",setComment],@"leftType",nil]];
    
    BOOL lockedread = [[[NSUserDefaults standardUserDefaults] objectForKey:@"hideread"] boolValue];
    NSString *str = @"隐藏已读";
    if (lockedread) {
        str = @"显示已读";
    }
    [self.listArr addObject:[NSDictionary dictionaryWithObjectsAndKeys:
                             str,@"text",
                             @"Eye-icon",@"image",
                             [NSString stringWithFormat:@"%d",setHideRead],@"leftType",nil]];
}

-(void)inittableView{
    [self initData];
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, 264, UIBounds.size.height) style:UITableViewStylePlain];
        _tableView.backgroundColor = WXXCOLOR(255, 255, 255, 1);
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self.leftView addSubview:_tableView];
//        [_tableView setTableHeaderView:[self inittableHeadView]];
        _tableView.separatorStyle = YES;
        UIEdgeInsets inset;
        inset.left = 50;
        [_tableView setSeparatorInset:inset]; //分割线长度
        [self setExtraCellLineHidden:_tableView]; //隐藏多余分割线
        [self initTouch];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 64;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 64)];
    headV.backgroundColor = WXXCOLOR(0, 0, 0, 1);
    WxxLabel *titleLb = [[WxxLabel alloc]initWithFrame:CGRectMake(0, 20, self.tableView.frame.size.width, 44)];
    titleLb.text = @"设置";
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.textColor = WXXCOLOR(255, 255, 255, 1);
    [headV addSubview:titleLb];
    return headV;
}

-(void)initTouch{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.delegate = self;
    [self addGestureRecognizer:singleTap];
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
//    [swipeLeft setNumberOfTouchesRequired:1];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
//    [swipeRight setNumberOfTouchesRequired:1];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    
    [self addGestureRecognizer:swipeLeft];
    [self addGestureRecognizer:swipeRight];
}
- (void)handleSingleTap:(UITapGestureRecognizer *)gestureRecognizer {
    CGPoint location = [gestureRecognizer locationInView:self];

    if (location.x < CGRectGetMaxX(_tableView.frame)) {
        return;//如果点击在tablview内，不做隐藏动画
    }
    [self backsss];
//    CGRect rect = _tableView.frame;
//    [self tablePopTox:- rect.size.width/2];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
    NSLog(@"%@", NSStringFromClass([touch.view class]));
    
    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}
/* 识别侧滑 */
- (void)handleSwipe:(UISwipeGestureRecognizer *)gestureRecognizer {
    CGPoint location = [gestureRecognizer locationInView:self];
    //	[self drawImageForGestureRecognizer:gestureRecognizer atPoint:location underAdditionalSituation:nil];
//    CGRect rect = _tableView.frame;
    if (gestureRecognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
         [self backsss];
//        [self tablePopTox:- rect.size.width/2];
    }
    else if (gestureRecognizer.direction == UISwipeGestureRecognizerDirectionUp) {
        location.x -= 220.0;
    }
    else if (gestureRecognizer.direction == UISwipeGestureRecognizerDirectionDown) {
        location.x -= 220.0;
    }
    else{
         [self backsss];
//        [self tablePopTox: rect.size.width/2];
    }
}

-(void)showSelf{
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    [self reflashInfo];
    [self tablePopTox: CGRectGetWidth(_tableView.frame)/2];
}

- (void)handlePan:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint location = [gestureRecognizer locationInView:self];
//    [self drawImageForGestureRecognizer:gestureRecognizer atPoint:location underAdditionalSituation:nil];
    float delta = self.lastContentOffset - location.x;
    self.lastContentOffset = location.x;
    if (delta<0) {
        CGRect rect = _tableView.frame;
        rect.origin.x = rect.origin.x +5;
        if (rect.origin.x > 0) {
            rect.origin.x = 0;
        }
        _tableView.frame = rect;
    }
    if (delta > 0) {
        CGRect rect = _tableView.frame;
        rect.origin.x = rect.origin.x -5;
        if (rect.origin.x < -rect.size.width) {
            rect.origin.x = -rect.size.width;
        }
        _tableView.frame = rect;
    }
    if ([gestureRecognizer state] == UIGestureRecognizerStateEnded) {
        // Reset the nav bar if the scroll is partial
        self.lastContentOffset = 0;
        CGRect rect = _tableView.frame;
        if (rect.origin.x< - rect.size.width/2) {
            [self tablePopTox:- rect.size.width/2];
        }else{
            [self tablePopTox: rect.size.width/2];
        }
        _tableView.frame = rect;
    }
}

-(void)tablePopTox:(float)orgx{
    
    NSLog(@"123123");
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
    
    POPSpringAnimation *onscreenAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    onscreenAnimation.toValue = @(orgx);
    onscreenAnimation.springBounciness =0;  //反弹
    onscreenAnimation.springSpeed = 20;//[0, 20] 速度
    onscreenAnimation.dynamicsTension = 4000; //动态张力
    onscreenAnimation.dynamicsFriction = 500;//摩擦
    onscreenAnimation.dynamicsMass = 20;//质量
    [onscreenAnimation setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        
    }];
    [self.leftView.layer pop_addAnimation:onscreenAnimation forKey:@"onscreenAnimation"];
}
- (void)setExtraCellLineHidden: (UITableView *)tableView{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
//    [view release];
}
-(UIView*)inittableHeadView{
    UIView *headV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 64)];
    headV.backgroundColor = WXXCOLOR(41, 43, 57, 1);
    WxxLabel *titleLb = [[WxxLabel alloc]initWithFrame:CGRectMake(0, 20, self.tableView.frame.size.width, 44)];
    titleLb.text = @"";
    titleLb.textAlignment = NSTextAlignmentCenter;
    titleLb.textColor = WXXCOLOR(255, 255, 255, 1);
    [headV addSubview:titleLb];
    return headV;
//    self.headView = [[LeftHeadView alloc]initWithFrame:CGRectMake(0, 0, 264, 176)];
//    self.headView.backgroundColor = [UIColor blackColor];
//    return _headView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArr.count;//行
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50; //行高
}
-(void)tableView:(UITableView*)tableView  willDisplayCell:(UITableViewCell*)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        static NSString *CellIdentifier = @"cate_cell";
        LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[LeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:CellIdentifier];
            //            cell.backgroundColor = [UIColor whiteColor];
                        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
    [cell setheadimage:[[self.listArr objectAtIndex:indexPath.row] objectForKey:@"image"] title:[[self.listArr objectAtIndex:indexPath.row] objectForKey:@"text"]] ;
        return cell; 
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([USERDATA isLogin]) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"showOrderList" object:@"3"];
//        
        NSString *type = [[self.listArr objectAtIndex:indexPath.row] objectForKey:@"leftType"];
        switch ([type intValue]) {
            case setCollect:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"showSetType" object:[NSString stringWithFormat:@"%d",setCollect]];
                break;
            case setWebView:
                [[NSNotificationCenter defaultCenter] postNotificationName:@"showSetType" object:[NSString stringWithFormat:@"%d",setWebView]];
                break;
            case setComment:
               
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@?at=10l6dK", @"995781549"]]];
                break;
            case setHideRead:
                [self hidereadset];
                break;
            case setReStore:
                [self restore];
                break;
            default:
                break;
        }
//    }
}

-(void)hidereadset{
    BOOL lockedread = [[[NSUserDefaults standardUserDefaults] objectForKey:@"hideread"] boolValue];
    if (lockedread) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"hideread"];
    }else{
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hideread"];
    }

    [self initData];
    [self.tableView reloadData];
}


-(void)restore{
    
    BOOL locked = [[[NSUserDefaults standardUserDefaults] objectForKey:@"restore"] boolValue];
    if (!locked) {
        
        
    }
//    [[WxxIapStore sharedWxxIapStore]receiveObject:^(id object) {
//        [[WxxLoadView sharedWxxLoadView]hideSelf];
//        if ([object isKindOfClass:[NSArray class]]) {
////            self.restoreNum = (int)[object count];
//            for (int i =0 ; i<[object count]; i++) {
//                SKPaymentTransaction *skPay = object[i];
//                
//                [self getRestoreBookInfo:skPay.payment.productIdentifier];
//                
//                
//            }
//        }else if ([object isEqualToString:@"1"]) {
//            
//            return;
//        }
//        
//        
//    }];
//    [[WxxLoadView sharedWxxLoadView]showself];
//    //去苹果服务端获取买过的商品productid
//    [[WxxIapStore sharedWxxIapStore] restore];
}
//根据恢复购买的productid去服务端获取对应的书籍的信息
-(void)getRestoreBookInfo:(NSString *)productid{
    if ([productid isEqualToString:@"error"]) {
//        showAlert(@"提示", @"恢复错误");
        return;
    }
    NSString *bundleid = [[NSBundle mainBundle] bundleIdentifier];
    //截取productid的最后一位（为bookid）
    NSString *bookid = [productid substringFromIndex:[bundleid length]+1];
    if ([bookid intValue]==6) {
//        [[WxxPopView sharedWxxPopView]showPopText:locRestoreSuccess];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"restore"];//不在显示恢复按钮
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ynshowad"];//去广告
        //        [self.loadingView stopAnimation];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"hideAd" object:nil];
        //        showAlert(@"提示", @"已清楚广告");
    }else{
        
    }
    
//    self.restoreNum--;
//    if (self.restoreNum<=0) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"reflashStoreClass" object:nil];
//        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"restore"];
//        [[WxxLoadView sharedInstance]hideSelf];
//        self.navigationItem.leftBarButtonItem = nil;
//        [self.navigationItem setHidesBackButton:NO animated:YES];
//        [self.tableView reloadData];
//    }
    
}



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex == 1) {
        //取消
    }else{
//        [USERDATA logout];
        [self reflashInfo];
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
