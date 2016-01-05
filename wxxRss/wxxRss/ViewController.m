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
#define margin 6

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
    self.navigationItem.title = @"新闻";
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarTintColor:WXXCOLOR(255, 255, 255, 1)];
    self.navigationController.navigationBar.translucent = NO;
        [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleDefault];
    self.view.backgroundColor = WXXCOLOR(255, 255, 255, 1);

    self.navigationController.navigationBarHidden = YES;
    self.ynChange = NO;
    
    self.doCell = nil;
    [self initCollectionView];
    [self initTitleBar];
    [self loadInfo];
    
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
//    longPressGr.minimumPressDuration = 1.0;
    [self.collectionView addGestureRecognizer:longPressGr];
    
}

-(void)loadView{
    [super loadView];
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
                    
                    //重新排列数据列表和界面保持一致
                    for (long i=sourceIndexPath.row; i<indexPath.row; i++) {
                        [self.rssClassArr exchangeObjectAtIndex:i withObjectAtIndex:i+1];
                    }
                    
                    // ... and update source so it is in sync with UI changes.
                    sourceIndexPath = indexPath;
                    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:sourceIndexPath];
                    cell.alpha = 0.0;
                    
                    
                }
                
            }
            break;
        }
            
        default: {
            //手指放开后需要重置位置排名到数据库
            [self resetRssClassRank];
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
            __block RssCollectionViewCell * cell = (RssCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
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
    UIView *titlV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.height, 64)];
    titlV.backgroundColor = WXXCOLOR(255, 255, 255, 1);
//        titlV.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:titlV.bounds cornerRadius:0].CGPath;
//        titlV.layer.shadowOffset = CGSizeMake(0, 1);
//        titlV.layer.shadowRadius = 1;
//        titlV.layer.shadowColor = [UIColor blackColor].CGColor;
//        titlV.layer.shadowOpacity = 0.5;
    [self.view addSubview:titlV];
    WxxLabel *titlLb = [[WxxLabel alloc]initWithFrame:CGRectMake(0, 30, UIBounds.size.width, 18)
                                                color:WXXCOLOR(0,0,0, 1)
                                                 font:18];
    titlLb.textAlignment = NSTextAlignmentCenter;
    titlLb.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
    titlLb.text = @"新闻阅读";
//
    [titlV addSubview:titlLb];
    
    WxxButton *lineBtn = [[WxxButton alloc]initWithFrame:CGRectMake(0, 0, 64, 64) title:@"" textColor:WXXCOLOR(0, 0, 0, 0) font:1 touchSize:0];
//    lineBtn.layer.borderColor = WXXCOLOR(0, 0, 0, 0.2).CGColor;
//    lineBtn.layer.borderWidth = 0.5;
    [titlV addSubview:lineBtn];
    [lineBtn addTarget:self action:@selector(setView) forControlEvents:UIControlEventTouchUpInside];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(16, 33, 20, 2)];
    line1.backgroundColor = WXXCOLOR(0, 0, 0, 0.5);
    [lineBtn addSubview:line1];
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(line1.frame)+5, 22, 2)];
    line2.backgroundColor = WXXCOLOR(0, 0, 0, 0.5);
    [lineBtn addSubview:line2];
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(16, CGRectGetMaxY(line2.frame)+5, 20, 2)];
    line3.backgroundColor = WXXCOLOR(0, 0, 0, 0.5);
    [lineBtn addSubview:line3];
    
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, titlV.frame.size.height-0.5, titlV.frame.size.width, 0.5)];
    line.backgroundColor = WXXCOLOR(0, 0, 0, 0.25);
    [titlV addSubview:line];
//    WxxButton *closeBtn = [[WxxButton alloc]initWithPoint:CGPointMake(16, 20+(44-24)/2) image:@"whitehead" touchSize:20];
//    [titlV addSubview:closeBtn];
//    //    closeBtn.backgroundColor = [UIColor blackColor];
//    [closeBtn addTarget:self action:@selector(setView) forControlEvents:UIControlEventTouchUpInside];
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
        self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 44, UIBounds.size.width, UIBounds.size.height-44) collectionViewLayout:flowLayout];
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
        CGSize size = {UIBounds.size.width, margin};
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
    return self.rssClassArr.count+1;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    RssCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    //最后一个是加号
    if (indexPath.row==self.rssClassArr.count) {
        [cell setAddbtn];
        [self doQueueLoadRss];
    }else{
        RssClassData *rsdata = [self.rssClassArr objectAtIndex:indexPath.row];
        [cell setInfo:rsdata];
    }
    if (self.ynChange) {
        [cell showChangeBtn];
    }else{
        [cell hideChangeBtn];
    }
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout


// 定义上下cell的最小间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return margin;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((UIBounds.size.width-margin*3)/2, (UIBounds.size.width-4)/2-50);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, margin,margin, margin);
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
        BigClassViewController *liVC = [[BigClassViewController alloc]init];
        UINavigationController *nv = [[UINavigationController alloc]initWithRootViewController:liVC];
        [self presentViewController:nv animated:YES completion:^{
            
        }];
                liVC.refreshCallback = ^(){
                    [self loadInfo];
                    [self doQueueLoadRss];
                };
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

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"adfa");
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
