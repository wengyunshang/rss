//
//  ViewController.m
//  wxxRss
//
//  Created by weng xiangxun on 15/5/11.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "ViewController.h"
#import "NewListViewController.h"
#import "RssCollectionViewCell.h"
#import "AddClassViewController.h"
#import "BigClassViewController.h"
#import "LeftHbgView.h"
#import "POPSpringAnimation.h"

#define marginx 14
#define marginy 8
@interface ViewController ()
@property (nonatomic,strong)NSMutableArray *rssClassArr;
@property (nonatomic,assign)BOOL ynChange;//是否编辑模式
@property (nonatomic,strong)WxxButton *circleBtn;
@property (nonatomic,strong)RssCollectionViewCell *doCell;
@end

@implementation ViewController

- (id)init
{
    self = [super init];
    if (self) {
  
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    self.view.backgroundColor = WXXCOLOR(242, 242, 242, 1);
    if ([[UIDevice currentDevice] systemVersion].floatValue>=7.0) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.navigationController.navigationBarHidden = YES;
    self.ynChange = NO;
    
    self.doCell = nil;
    
    [self initScrollview];
//    [self initCollectionView];
    [self initTitleBar];
    [self loadInfo];
    
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
//    longPressGr.minimumPressDuration = 1.0;
    [self.collectionView addGestureRecognizer:longPressGr];
    
}

-(void)loadView{
    [super loadView];
}

-(void)initScrollview{
    NSInteger pages = 1;
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.delegate = self;
        self.scrollView.contentOffset = CGPointMake(0, 0);
        self.scrollView.pagingEnabled = YES;
        [self.view addSubview:self.scrollView];
        [self createPages:pages];
    }
}

- (void)createPages:(NSInteger)pages {
    for (int i = 0; i < pages; i++) {
        if (i==1) {
            
            if (!self.timelineVC) {
                self.timelineVC = [[TimelineViewController alloc]init];
                //            self.setVC.view.backgroundColor = [UIColor redColor];
                [self.scrollView addSubview:self.timelineVC.view];
                self.timelineVC.view.frame = CGRectMake(CGRectGetWidth(self.scrollView.bounds) * i, 0, self.view.frame.size.width, self.view.frame.size.height);
                
            }
            
        }else if (i==0){
            if (!self.collectionView) {
                //确定是水平滚动，还是垂直滚动
                UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
                [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
                flowLayout.minimumInteritemSpacing = 5;
                self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width, UIBounds.size.height-0) collectionViewLayout:flowLayout];
                self.collectionView.dataSource=self;
                self.collectionView.delegate=self;
                [self.collectionView setBackgroundColor:[UIColor clearColor]];
                
                //注册Cell，必须要有
                [self.collectionView registerClass:[RssCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
                self.collectionView.alwaysBounceVertical = YES;
                [self.scrollView addSubview:self.collectionView];
                
                ////    self.collectionView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
                //    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, UIBounds.size.width-20, 150)];
                //    headView.backgroundColor = [UIColor whiteColor];
                //    [self.collectionView addSubview: headView];
            }
        }else{
        }
    }
    [self.scrollView setContentSize:CGSizeMake(CGRectGetWidth(self.scrollView.bounds) * pages,0)];
}

/**
 *  删除一个cell
 */
-(void)deleteCell{
    [self.collectionView performBatchUpdates:^{
        
        NSArray *selectedItemsIndexPaths = [self.collectionView indexPathsForSelectedItems];
        
        // Delete the items from the data source.
        [self deleteItemsFromDataSourceAtIndexPaths:selectedItemsIndexPaths];
        
        // Now delete the items from the collection view.
        [self.collectionView deleteItemsAtIndexPaths:selectedItemsIndexPaths];
        
    } completion:nil];
}

// This method is for deleting the selected images from the data source array
-(void)deleteItemsFromDataSourceAtIndexPaths:(NSArray  *)itemPaths
{
    NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
    for (NSIndexPath *itemPath  in itemPaths) {
        [indexSet addIndex:itemPath.row];
    }
    [self.rssClassArr removeObjectsAtIndexes:indexSet];
}

/**
 *  长按
 *
 *  @param gesture touch
 */
-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    UILongPressGestureRecognizer *longPress = (UILongPressGestureRecognizer *)gesture;
    UIGestureRecognizerState state = longPress.state;
    
    CGPoint location = [longPress locationInView:self.collectionView];
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:location];
    
    static UIView       *snapshot = nil;        ///< A snapshot of the row user is moving.
    static NSIndexPath  *sourceIndexPath = nil; ///< Initial index path, where gesture begins.
    
    switch (state) {
        case UIGestureRecognizerStateBegan: { //长按后获取到手指下面的那个模块
            if (indexPath) {
                sourceIndexPath = indexPath;
                UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
                
                // Take a snapshot of the selected row using helper method.
                snapshot = [self customSnapshoFromView:cell];
                
                // Add the snapshot as subview, centered at cell's center...
                __block CGPoint center = cell.center;
                snapshot.center = center;
                snapshot.alpha = 0.0;
                [self.collectionView addSubview:snapshot];
                [UIView animateWithDuration:0.25 animations:^{
                    
                    // Offset for gesture location.
                    center.y = location.y;
                    center.x = location.x;
                    snapshot.center = center;
                    snapshot.transform = CGAffineTransformMakeScale(1.05, 1.05);
                    snapshot.alpha = 0.98;
                    
                    // Fade out.
                    cell.alpha = 0.0;
                } completion:nil];
            }
            break;
        }
            
        case UIGestureRecognizerStateChanged: {//手指滑动模块跟着滑动
            CGPoint center = snapshot.center;
            center.y = location.y;
            center.x = location.x;
            snapshot.center = center;
            
            // Is destination valid and is it different from source?
            if (indexPath && ![indexPath isEqual:sourceIndexPath]) { //模块
                if (indexPath.row<self.rssClassArr.count) {
                    
                    // 移动界面
                    [self.collectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:indexPath];
                    
                    
                    /**
                     *重新排列数据列表和界面保持一致
                     *倒序和顺序替换算法不一样
                     */
                    long min = sourceIndexPath.row;
                    long max = indexPath.row;
                    if (min>max) {
                        for (long i = min; i>max; i--) {
                            [self.rssClassArr exchangeObjectAtIndex:i withObjectAtIndex:i-1];
                        }
                    }else{
                       
                        for (long i=min; i<max; i++) {
                            [self.rssClassArr exchangeObjectAtIndex:i withObjectAtIndex:i+1];
                        }
                        
                    }
                    
                    // ... and update source so it is in sync with UI changes.
                    sourceIndexPath = indexPath;
                    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:sourceIndexPath];
                    cell.alpha = 0.0;
                    
                    //手指放开后需要重置位置排名到数据库
                    [self resetRssClassRank];
                }
                
            }
            break;
        }
            
        default: {
            
            // Clean up.
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:sourceIndexPath];
            [UIView animateWithDuration:0.25 animations:^{
                
                snapshot.center = cell.center;
                snapshot.transform = CGAffineTransformIdentity;
                snapshot.alpha = 0.0;
                
                // Undo the fade-out effect we did.
                cell.alpha = 1.0;
                
            } completion:^(BOOL finished) {
                
                [snapshot removeFromSuperview];
                snapshot = nil;
                
            }];
            sourceIndexPath = nil;
            break;
        }
    }
//    if(gesture.state == UIGestureRecognizerStateBegan)
//    {
//        CGPoint point = [gesture locationInView:self.collectionView];
//        NSIndexPath * indexPath = [self.collectionView indexPathForItemAtPoint:point];
//        if(indexPath == nil) return ;
//        self.ynChange = YES;
//        NSLog(@"编辑");
//        [self loadInfo];
//        if (!self.circleBtn) {
//            UIImage *image = [UIImage imageNamed:@"CheckCircle-orange"];
//            self.circleBtn = [[WxxButton alloc]initWithFrame:CGRectMake(UIBounds.size.width, self.view.frame.size.height, 200,200)];
//            UIImageView *imgv = [[UIImageView alloc]initWithFrame:CGRectMake(38, 38, image.size.width, image.size.height)];
//            imgv.image = image;
//            [self.circleBtn addSubview:imgv];
//            self.circleBtn.layer.cornerRadius = 100;
//            self.circleBtn.backgroundColor = WXXCOLOR(0, 0, 0, 0.9);
//            [self.view addSubview:self.circleBtn];
//            [self.circleBtn addTarget:self action:@selector(changeOver) forControlEvents:UIControlEventTouchUpInside];
//        }
//        [self showPopToy:self.view.frame.size.height x:self.view.frame.size.width view:self.circleBtn];
//        //add your code here
//    }
}

//重置分类模块位置排名
-(void)resetRssClassRank{
    NSLog(@"重置排名");
    for (int i=0; i<self.rssClassArr.count; i++) {
        RssClassData *classData = [self.rssClassArr objectAtIndex:i];
        classData.rrcrank = [NSString stringWithFormat:@"%d",(i+1)];
        NSLog(@"%@----%@",classData.rrcName,classData.rrcrank);
        [classData updateSelf];
    }
}



#pragma mark - Helper methods

/** @brief Returns a customized snapshot of a given view. */
- (UIView *)customSnapshoFromView:(UIView *)inputView {
    
    // Make an image from the input view.
    UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, NO, 0);
    [inputView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Create an image view.
    UIView *snapshot = [[UIImageView alloc] initWithImage:image];
    snapshot.layer.masksToBounds = NO;
    snapshot.layer.cornerRadius = 0.0;
    snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0);
    snapshot.layer.shadowRadius = 5.0;
    snapshot.layer.shadowOpacity = 0.4;
    
    return snapshot;
}


/**
 *  编辑结束
 */
-(void)changeOver{
    if (self.ynChange) {
        self.ynChange = NO;
        [self loadInfo];
//        self.circleBtn.hidden = YES;
        [self showPopToy:self.view.frame.size.height+self.circleBtn.frame.size.width/2 x:self.view.frame.size.width+self.circleBtn.frame.size.width/2 view:self.circleBtn];
    }
}


-(void)showPopToy:(float)orgy x:(float)orgx view:(UIView *)view{
    
    POPSpringAnimation *onscreenAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPosition];
    onscreenAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(orgx, orgy)];;
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

-(void)loadInfo{
    self.rssClassArr = [[PenSoundDao sharedPenSoundDao]selectRssClassList];
    [self.collectionView reloadData];
    [self.collectionView reloadItemsAtIndexPaths:[self.collectionView indexPathsForVisibleItems]];
}

//队列加载rss
-(void)doQueueLoadRss{
//    if (self.rssClassArr.count <= 0) {
//        self.rssClassArr = [[PenSoundDao sharedPenSoundDao]selectRssClassList];
//    }
    for (int i=0; i<self.rssClassArr.count; i++) {
        RssClassData *rssCLassData = [self.rssClassArr objectAtIndex:i];
        //一小时内刷新过就不用刷新啦
        if ([rssCLassData ynNeedRefresh]) {
            //开始显示加载转圈
            __block RssCollectionViewCell * cell = (RssCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:1]];
            //        __block ViewController *blockself = self;
            [cell startLoading];
            
            if ([rssCLassData.rrcynapi intValue]==1) {
                [WXXNETUTIL getNewForClassId:rssCLassData callback:^(id response) {
                    
                    //返回主线程停止loading
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [cell stoptLoading];
                        [cell refreshImageV];
                        //                [blockself loadInfo];
                    });
                    //            if ([response isEqualToString:WXXSUCCESS]) {
                    //回到主线程渲染数据
//                    [self performSelectorOnMainThread:@selector(reloadInfo) withObject:nil waitUntilDone:NO];
                    //            }else{
                    //            }
                }];
            }else{
                //开始网络请求
                [[WxxNetTBXMLUtil shared]loadURL:rssCLassData callback:^(id response) {
                    //返回主线程停止loading
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [cell stoptLoading];
                        [cell refreshImageV];
                        //                [blockself loadInfo];
                    });
                    
                    if ([response isEqualToString:WXXSUCCESS]) {
                        
                    }else{
                    }
                }];
            }
            
        }
    }
    
    
}


//标题
-(void)initTitleBar{
    UIView *titlV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.width, 64)];
    titlV.backgroundColor = WXXCOLOR(255, 255, 255, 0.9);
    [self.view addSubview:titlV];
    
    WxxLabel *titlLb = [[WxxLabel alloc]initWithFrame:CGRectMake(0, 30, UIBounds.size.width, 18)
                                                color:WXXCOLOR(0,0,0, 1)
                                                 font:18];
    titlLb.textAlignment = NSTextAlignmentCenter;
    titlLb.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    titlLb.text = @"订阅";
    [titlV addSubview:titlLb];
    
    
    self.foursquareSegmentedControl = [[NYSegmentedControl alloc] initWithItems:@[@"订阅", @"发现"]];
    self.foursquareSegmentedControl.titleTextColor = WXXCOLOR(155, 155, 155, 1);
    self.foursquareSegmentedControl.selectedTitleTextColor = [UIColor whiteColor];
    self.foursquareSegmentedControl.delegate = self;
    self.foursquareSegmentedControl.selectedTitleFont = [UIFont systemFontOfSize:15.0f];
    self.foursquareSegmentedControl.segmentIndicatorBackgroundColor = [UIColor colorWithRed:0.38f green:0.68f blue:0.93f alpha:1.0f];
    self.foursquareSegmentedControl.backgroundColor = WXXCOLOR(222, 222, 222, 1);//[UIColor colorWithRed:0.31f green:0.53f blue:0.72f alpha:1.0f];
    self.foursquareSegmentedControl.borderWidth = 0.0f;
    self.foursquareSegmentedControl.segmentIndicatorBorderWidth = 0.0f;
    self.foursquareSegmentedControl.segmentIndicatorInset = 1.0f;
    self.foursquareSegmentedControl.segmentIndicatorBorderColor = self.view.backgroundColor;
    [self.foursquareSegmentedControl sizeToFit];
    self.foursquareSegmentedControl.cornerRadius = CGRectGetHeight(self.foursquareSegmentedControl.frame) / 2.0f;
    self.foursquareSegmentedControl.center = CGPointMake(titlV.center.x, titlV.center.y+10);
//    foursquareSegmentedControlBackgroundView.center = foursquareSegmentedControl.center;
    [titlV addSubview:self.foursquareSegmentedControl];
    self.foursquareSegmentedControl.hidden = YES;
//    [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(_scrollView.frame), 0) animated:YES];setSelectedSegmentIndex

    //***********左边按钮**********//
    WxxButton *LeftBtn = [[WxxButton alloc]initWithFrame:CGRectMake(0, 0, 64, 64) title:@"" textColor:WXXCOLOR(0, 0, 0, 0) font:1 touchSize:0];
    [titlV addSubview:LeftBtn];
    [LeftBtn addTarget:self action:@selector(setView) forControlEvents:UIControlEventTouchUpInside];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(16, 34, 18, 2.5)];
    line1.backgroundColor = WXXCOLOR(0, 0, 0, 0.5);
    [LeftBtn addSubview:line1];
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(line1.frame)+4.5, 20, 2.5)];
    line2.backgroundColor = WXXCOLOR(0, 0, 0, 0.5);
    [LeftBtn addSubview:line2];
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(line2.frame)+4.5, 18, 2.5)];
    line3.backgroundColor = WXXCOLOR(0, 0, 0, 0.5);
    [LeftBtn addSubview:line3];
    line1.layer.cornerRadius = 1;
    line2.layer.cornerRadius = 1;
    line3.layer.cornerRadius = 1;
    
    //***********右边按钮**********//
    WxxButton *rightBtn = [[WxxButton alloc]initWithFrame:CGRectMake(CGRectGetWidth(titlV.frame)-64, 0, 64, 64) title:@"" textColor:WXXCOLOR(0, 0, 0, 0) font:1 touchSize:0];
    [rightBtn addTarget:self action:@selector(presentBigClassVC) forControlEvents:UIControlEventTouchUpInside];
//    rightBtn.backgroundColor = [UIColor redColor];
    [titlV addSubview:rightBtn];
    
    float fangwidth = 8;
    UIView *fang1 = [[UIView alloc]initWithFrame:CGRectMake(64-16-fangwidth*2-2, 33, fangwidth, fangwidth)];
    fang1.backgroundColor = WXXCOLOR(0, 0, 0, 0.5);
    [rightBtn addSubview:fang1];
    UIView *fang2 = [[UIView alloc]initWithFrame:CGRectMake(64-16-fangwidth*2-2, 33+fangwidth+2, fangwidth, fangwidth)];
    fang2.backgroundColor = WXXCOLOR(0, 0, 0, 0.5);
    [rightBtn addSubview:fang2];
    UIView *fang3 = [[UIView alloc]initWithFrame:CGRectMake(64-16-fangwidth, 33, fangwidth, fangwidth)];
    fang3.backgroundColor = WXXCOLOR(0, 0, 0, 0.2);
    [rightBtn addSubview:fang3];
    UIView *fang4 = [[UIView alloc]initWithFrame:CGRectMake(64-16-fangwidth, 33+fangwidth+2, fangwidth, fangwidth)];
    fang4.backgroundColor = WXXCOLOR(0, 0, 0, 0.5);
    [rightBtn addSubview:fang4];

    fang1.layer.cornerRadius = 1;
    fang2.layer.cornerRadius = 1;
    fang3.layer.cornerRadius = 1;
    fang4.layer.cornerRadius = 1;
//
    
    //分割线
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, titlV.frame.size.height-0.53, titlV.frame.size.width, 0.5)];
    line.backgroundColor = WXXCOLOR(0, 0, 0, 0.25);
    [titlV addSubview:line];
//    WxxButton *closeBtn = [[WxxButton alloc]initWithPoint:CGPointMake(16, 20+(44-24)/2) image:@"whitehead" touchSize:20];
//    [titlV addSubview:closeBtn];
//    //    closeBtn.backgroundColor = [UIColor blackColor];
//    [closeBtn addTarget:self action:@selector(setView) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark delegate
-(void)NYSegmentedFromSelectedItem:(long)item{
    
    NSLog(@"选中:%ld",item);
    if (item==0) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }else{
        [_scrollView setContentOffset:CGPointMake(CGRectGetWidth(_scrollView.frame), 0) animated:YES];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self pageAnimation];
    
    //    [self.nibPageControl setCurrentPage:page];
}

-(void)pageAnimation{
    CGFloat pageWidth = self.scrollView.frame.size.width;
    NSInteger page =  floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    //    NSLog(@"%d",page);
    //    NSLog(@"111111111111111111111");
    switch (page) {
        case 0:
            [self.foursquareSegmentedControl setSelectedSegmentIndex:0 animated:YES];
            break;
        case 1:
            [self.timelineVC reloadInfo];
            [self.foursquareSegmentedControl setSelectedSegmentIndex:1 animated:YES];
            break;
        case 2:
            
            break;
        default:
            break;
    }
}

-(void)setView{
    
    [[LeftHbgView sharedLeftHbgView]showSelf];
}

-(void)initCollectionView{
    if (!self.collectionView) {
        //确定是水平滚动，还是垂直滚动
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumInteritemSpacing = 5;
        self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width, UIBounds.size.height-0) collectionViewLayout:flowLayout];
        self.collectionView.dataSource=self;
        self.collectionView.delegate=self;
        [self.collectionView setBackgroundColor:[UIColor clearColor]];
        
        //注册Cell，必须要有
        [self.collectionView registerClass:[RssCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        self.collectionView.alwaysBounceVertical = YES;
        [self.view addSubview:self.collectionView];
        
        ////    self.collectionView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        //    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, UIBounds.size.width-20, 150)];
        //    headView.backgroundColor = [UIColor whiteColor];
        //    [self.collectionView addSubview: headView];
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
        CGSize size = {UIBounds.size.width, 70};
        return size;
    }
}


//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==1) {
        return self.rssClassArr.count+1;
    }else{
        return 0;
    }
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    RssCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    //最后一个是加号
    if (indexPath.row==self.rssClassArr.count) {
        [cell setAddbtn];
//        [self doQueueLoadRss];
    }else{
        RssClassData *rsdata = [self.rssClassArr objectAtIndex:indexPath.row];
        [cell setInfo:rsdata];
    }
//    if (self.ynChange) {
//        [cell showChangeBtn];
//    }else{
//        [cell hideChangeBtn];
//    }
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout


// 定义上下cell的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return marginy;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((UIBounds.size.width-marginx*3)/2, (UIBounds.size.width-4)/2-55);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, marginx,marginy, marginx);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < self.rssClassArr.count) {
        if (self.ynChange) {
            RssClassData *rsdata = [self.rssClassArr objectAtIndex:indexPath.row];
            [rsdata deleteSelf];
            [self deleteCell];
            return;
        }
    }
    
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.enabled = YES;
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    //    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //    //临时改变个颜色，看好，只是临时改变的。如果要永久改变，可以先改数据源，然后在cellForItemAtIndexPath中控制。（和UITableView差不多吧！O(∩_∩)O~）
    //    cell.backgroundColor = [UIColor greenColor];
    if (indexPath.row==self.rssClassArr.count) {
        [self presentBigClassVC];
        //        [self.navigationController pushViewController:liVC animated:YES];
    }else{
        
        self.doCell  = (RssCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        NewListViewController *liVC = [[NewListViewController alloc]init];
        RssClassData *rsdata = [self.rssClassArr objectAtIndex:indexPath.row];
        liVC.rssClassData = rsdata;
        [self.navigationController pushViewController:liVC animated:YES];
    }
    
    //    NSLog(@"item======%d",indexPath.item);
    //    NSLog(@"row=======%d",indexPath.row);
    //    NSLog(@"section===%d",indexPath.section);
}

-(void)presentBigClassVC{
    BigClassViewController *liVC = [[BigClassViewController alloc]init];
    UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:liVC];
    [self presentViewController:nv animated:YES completion:^{
        
    }];
    liVC.refreshCallback = ^(){
        [self loadInfo];
//        [self doQueueLoadRss];
    };
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)viewWillAppear:(BOOL)animated{
//    NSLog(@"adfa");
}
-(void)viewDidAppear:(BOOL)animated{
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    if (self.doCell) {
        [self.doCell refreshTipNumV];
        [self.doCell refreshImageV];
    }
//    [self loadAdmob];
//    [self loadGdtMob];
//    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
//    [self loadInfo];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}






@end
