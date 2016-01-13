//
//  TimelineViewController.m
//  wxxRss
//
//  Created by linxiaolong on 16/1/12.
//  Copyright © 2016年 wxx. All rights reserved.
//

#import "TimelineViewController.h"
#import "TimelineCell.h"
#import "TimelineLoadCell.h"
@interface TimelineViewController ()
@property (nonatomic,strong)NSMutableArray *rssArr;
@property (nonatomic,strong)UIRefreshControl *refreshControl;
@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCollectionView];
//    self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
}

-(void)initCollectionView{
    if (!self.collectionView) {
        //确定是水平滚动，还是垂直滚动
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumInteritemSpacing = 5;
        self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width, UIBounds.size.height) collectionViewLayout:flowLayout];
        self.collectionView.dataSource=self;
        self.collectionView.delegate=self;
        [self.collectionView setBackgroundColor:[UIColor clearColor]];
        
        //注册Cell，必须要有
        [self.collectionView registerClass:[TimelineCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        [self.collectionView registerClass:[TimelineLoadCell class] forCellWithReuseIdentifier:@"NewListLoadCell"];
        self.collectionView.alwaysBounceVertical = YES;
        [self.view addSubview:self.collectionView];
        [self initRefreshView];
    }
}

-(void)reloadInfo{
    [[WxxLoadView sharedWxxLoadView]hideSelf];
    if (self.rssArr) {
        self.rssArr = nil;
    }
    
    self.rssArr = [[PenSoundDao sharedPenSoundDao]selectTimeLineRssList];
   
    
    [self.collectionView reloadData];
}

//请求新数据
-(void)refreshInfo{
  
    [[WxxLoadView sharedWxxLoadView]showself];
   
        [WXXNETUTIL getTimelineNewForLastTimecallback:^(id response) {
            
            if (self.refreshControl) {
                [self.refreshControl endRefreshing];
            }
            
            //            if ([response isEqualToString:WXXSUCCESS]) {
            //回到主线程渲染数据
            [self performSelectorOnMainThread:@selector(reloadInfo) withObject:nil waitUntilDone:NO];
            //            }else{
            //            }
        }];
}

-(void)initRefreshView{
    UIRefreshControl *refresh = [[UIRefreshControl alloc] init];
    //        refresh.tintColor = WXXCOLOR(0, 87, 72, 0.87);
    //refresh.attributedTitle = [[[NSAttributedString alloc] initWithString:NSLocalizedString(@"PulltoRefresh", nil)] autorelease];
    [refresh addTarget:self action:@selector(refreshView:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    [self.collectionView addSubview:self.refreshControl];
    float orgx = (UIBounds.size.width-30) / 4;
    [[refresh.subviews objectAtIndex:0] setFrame:CGRectMake(orgx, 40, 30, 30)];
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
        CGSize size = {UIBounds.size.width, 70};
        return size;
    }
}


//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section==1) {
        if (self.rssArr.count > 0) {
            return self.rssArr.count+1;
        }
        return 0;
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
    if (indexPath.row == self.rssArr.count) {
        static NSString * CellIdentifier = @"NewListLoadCell";
        TimelineLoadCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        return cell;
    }else{
        static NSString * CellIdentifier = @"UICollectionViewCell";
        TimelineCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
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
    labelsize.height = labelsize.height + labelsize.height/font.xHeight*2;
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
    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
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
