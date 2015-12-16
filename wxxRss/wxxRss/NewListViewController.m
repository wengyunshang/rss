//
//  NewListViewController.m
//  wxxRss
//
//  Created by weng xiangxun on 15/5/12.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "NewListViewController.h"
#import "SMDetailViewController.h"
#import "NewListCollectionViewCell.h"
#import "NewListLoadCell.h"
#import "NSString+wxx.h"
@interface NewListViewController ()
@property (nonatomic,strong)NSMutableArray *rssArr;
@property (nonatomic,strong)WxxButton *refreshBtn;
@property (nonatomic,assign)float angle;
@property (nonatomic,assign)BOOL ynRefresh;
@property (nonatomic,assign)BOOL ynLoaded;//是否加载完毕
@property (nonatomic,strong)UIRefreshControl *refreshControl;
@end

@implementation NewListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WXXCOLOR(244, 244, 244, 1);
    
    
    //列表
    [self initCollectionView];
    //顶部
    [self initTitleBar];
    //底部
    [self initBottomBar];
}

-(void)viewDidAppear:(BOOL)animated{
    
}

//刷新界面
-(void)reloadInfo{
    [[WxxLoadView sharedWxxLoadView]hideSelf];
    if (self.rssArr) {
        self.rssArr = nil;
    }
    //是否收藏
    if (self.ynCollect) {
        self.rssArr = [[PenSoundDao sharedPenSoundDao]selectRssCollectList:WXXYES];
    }else{
        self.rssArr = [[PenSoundDao sharedPenSoundDao]selectRssList:self.rssClassData.rrcId];
    }
    
    [self.collectionView reloadData];
}

//底部界面
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
    
    
    WxxButton *backBtn = [[WxxButton alloc]initWithPoint:CGPointMake(10, (CGRectGetHeight(bottomBar.frame)-32)/2)
                                                   image:@"common_icon_return"
                                               touchSize:10];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [bottomBar addSubview:backBtn];
    
    
    self.refreshBtn = [[WxxButton alloc]init];
    [self.refreshBtn setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    self.refreshBtn.alpha = 0.6;

    [bottomBar addSubview:self.refreshBtn];
    [self.refreshBtn addTarget:self action:@selector(refreshBtnTouch) forControlEvents:UIControlEventTouchUpInside];
    self.refreshBtn.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *met = @{@"width":@42};
    [bottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_refreshBtn(==width)]-20-|" options:0 metrics:met views:NSDictionaryOfVariableBindings(_refreshBtn)]];
    [bottomBar addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_refreshBtn(==width)]" options:0 metrics:met views:NSDictionaryOfVariableBindings(_refreshBtn)]];
    [bottomBar addConstraint:[NSLayoutConstraint constraintWithItem:_refreshBtn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:bottomBar attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
}

-(void)refreshBtnTouch{
    [self startAnimation];
    [self refreshInfo];
}

//请求新数据
-(void)refreshInfo{
    if (self.ynCollect) {
        //我的收藏不需要请求
        return;
    }
    
    [[WxxLoadView sharedWxxLoadView]showself];
    self.ynLoaded = NO;
    
    if ([self.rssClassData.rrcynapi intValue]==1) {
        [WXXNETUTIL getNewForClassId:self.rssClassData callback:^(id response) {
            self.ynLoaded = YES;
            if (self.refreshControl) {
                [self.refreshControl endRefreshing];
            }
            
            //            if ([response isEqualToString:WXXSUCCESS]) {
            //回到主线程渲染数据
            [self performSelectorOnMainThread:@selector(reloadInfo) withObject:nil waitUntilDone:NO];
            //            }else{
            //            }
        }];
    }else{
        //多线程请求数据
        [[WxxNetTBXMLUtil shared]loadURL:self.rssClassData callback:^(id response) {
            self.ynLoaded = YES;
            if (self.refreshControl) {
                [self.refreshControl endRefreshing];
            }
            
            if ([response isEqualToString:WXXSUCCESS]) {
                //回到主线程渲染数据
                [self performSelectorOnMainThread:@selector(reloadInfo) withObject:nil waitUntilDone:NO];
            }else{
            }
        }];
    }
}

- (void)startAnimation
{
    if (!self.ynLoaded) {
        CGAffineTransform endAngle = CGAffineTransformMakeRotation(self.angle * (M_PI / 180.0f));
        
        [UIView animateWithDuration:0.02 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.refreshBtn.transform = endAngle;
        } completion:^(BOOL finished) {
            self.angle += 10;
            [self startAnimation];
        }];
    }else{
        CGAffineTransform endAngle = CGAffineTransformMakeRotation((self.angle+90) * (M_PI / 180.0f));
        
        [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.refreshBtn.transform = endAngle;
        } completion:^(BOOL finished) {
            self.angle += 10;
        }];
    }
}


-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initTitleBar{
    UIView *titlV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.height, 64)];
    titlV.backgroundColor = [UIColor whiteColor];
    titlV.layer.borderColor = WXXCOLOR(0, 0, 0, 0.2).CGColor;
    titlV.layer.borderWidth = 0.5;
    [self.view addSubview:titlV];
    
    UIView *lineleft = [[UIView alloc]initWithFrame:CGRectMake(10, 41, 15, 0.5)];
    lineleft.backgroundColor = WXXCOLOR([self.rssClassData.rrr intValue], [self.rssClassData.rrg intValue], [self.rssClassData.rrb intValue], 1);
    [titlV addSubview:lineleft];
    
    WxxLabel *titlLb = [[WxxLabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineleft.frame)+5, 30, UIBounds.size.width-32, 18)
                                                color:WXXCOLOR([self.rssClassData.rrr intValue], [self.rssClassData.rrg intValue], [self.rssClassData.rrb intValue], 1)
                                                 font:18];
    titlLb.text = [NSString stringWithFormat:@"%@",self.rssClassData.rrcName];
    [titlV addSubview:titlLb];
    [titlLb resetOneFrame];
    
    UIView *lineright = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(titlLb.frame)+5, 41, UIBounds.size.width-CGRectGetMaxX(titlLb.frame)-5-10, 0.5)];
    lineright.backgroundColor = WXXCOLOR([self.rssClassData.rrr intValue], [self.rssClassData.rrg intValue], [self.rssClassData.rrb intValue], 1);
    [titlV addSubview:lineright];
}


-(void)initCollectionView{
    if (!self.collectionView) {
        //确定是水平滚动，还是垂直滚动
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumInteritemSpacing = 5;
        self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 44, UIBounds.size.width, UIBounds.size.height-44-44) collectionViewLayout:flowLayout];
        self.collectionView.dataSource=self;
        self.collectionView.delegate=self;
        [self.collectionView setBackgroundColor:[UIColor clearColor]];
        
        //注册Cell，必须要有
        [self.collectionView registerClass:[NewListCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [self.collectionView registerClass:[NewListLoadCell class] forCellWithReuseIdentifier:@"NewListLoadCell"];
        self.collectionView.alwaysBounceVertical = YES;
        [self.view addSubview:self.collectionView];
        [self initRefreshView];
        ////    self.collectionView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        //    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, UIBounds.size.width-20, 150)];
        //    headView.backgroundColor = [UIColor whiteColor];
        //    [self.collectionView addSubview: headView];
    }
}

-(void)initRefreshView{
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    //        refresh.tintColor = WXXCOLOR(0, 87, 72, 0.87);
    //refresh.attributedTitle = [[[NSAttributedString alloc] initWithString:NSLocalizedString(@"PulltoRefresh", nil)] autorelease];
    [refresh addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    [self.collectionView addSubview:self.refreshControl];
}
-(void)refreshView:(UIRefreshControl *)refresh
{
    if (refresh.refreshing) {
        // refresh.attributedTitle = [[[NSAttributedString alloc]initWithString:NSLocalizedString(@"Refreshing", nil)] autorelease];
        [self refreshInfo];
    }
}



#pragma mark -- UICollectionViewDataSource
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        CGSize size = {UIBounds.size.width, 0};
        return size;
    }
    else
    {
        CGSize size = {UIBounds.size.width, 50};
        return size;
    }
}


//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.ynCollect) {
        //我的收藏不需要有加载按钮
        return self.rssArr.count;
    }
    return self.rssArr.count+1;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.rssArr.count) {
        static NSString * CellIdentifier = @"NewListLoadCell";
        NewListLoadCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        return cell;
    }else{
        static NSString * CellIdentifier = @"UICollectionViewCell";
        NewListCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        RssData *rsdata = [self.rssArr objectAtIndex:indexPath.row];
        [cell setInfo:rsdata];
        
        return cell;
    }
}

#pragma mark --UICollectionViewDelegateFlowLayout
// 定义上下cell的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 5;
}

-(float)highHeight:(NSString*)string width:(float)width{
    UIFont *font = [UIFont fontWithName:@"STHeitiSC-Light" size:15];
    CGSize labelsize = [string boundingRectWithSize:CGSizeMake(width,2000)
                                            options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:@{NSFontAttributeName : font}
                                            context:nil].size;
    labelsize.height = labelsize.height + labelsize.height/font.xHeight*5;
    return labelsize.height;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float height = 50;
    if (indexPath.row < self.rssArr.count) {
        
        if (self.rssArr.count>0) {
            RssData *rsdata = [self.rssArr objectAtIndex:indexPath.row];
            
            if ([rsdata.rrimage length]>0) {
                height = [self highHeight:rsdata.rrtitle width:UIBounds.size.width-16-60-10-16-20]+35;
                if (height < 80) {
                    height = 80;  //有图片的cell最少80
                }else{
                }
            }else{
                height = [self highHeight:rsdata.rrtitle width:UIBounds.size.width-16-16-20]+35; //没有图片的话 去掉图片的宽度
            }
        }
    }
    return CGSizeMake(UIBounds.size.width-10, height);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5,5, 5);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.rssArr.count) {
        SMDetailViewController *detailVC = [SMDetailViewController new];
        RssData *rsdata = [self.rssArr objectAtIndex:indexPath.row];
        [detailVC setRss:rsdata];
        detailVC.rclassData = self.rssClassData;
        //更新本条为已读
        rsdata.rrynread = WXXYES;
        [rsdata updateRead];
        NewListCollectionViewCell * cell = (NewListCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        [cell refreshInfo:rsdata];
        [self.navigationController pushViewController:detailVC animated:YES];
        [detailVC renderDetailViewFromRSS];
    }else{

        
        __block NewListLoadCell *cell  = (NewListLoadCell *)[collectionView cellForItemAtIndexPath:indexPath];
        //未刷新到服务器最旧的数据，可以继续刷新
        if (!cell.ynEnd) {
            [cell loadIngView];//状态改为加载中。。。
            RssData *rsdata = [self.rssArr objectAtIndex:self.rssArr.count-1];
            //加载最后一条数据之前的消息
            [WXXNETUTIL getBeforNewForClassId:self.rssClassData rssdata:rsdata callback:^(id response) {
                
                NSString *str = response;
                
                
                if ([str isEqualToString:WXXSUCCESS]) {
                    //请求有数据
                    [cell loadingOver];
                    [self performSelectorOnMainThread:@selector(reloadInfo) withObject:nil waitUntilDone:NO];
                }else{
                    //请求无数据
                    [cell loadend];
                }
            }];
        }
        
    }
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [self reloadInfo];
    //无数据，请求最新数据
    //    if (self.rssArr.count<=0) {
    //        [self refreshInfo];
    //    }
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
}
@end
