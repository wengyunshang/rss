//
//  AddClassViewController.m
//  wxxRss
//
//  Created by weng xiangxun on 15/5/16.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "AddClassViewController.h"
#import "AddCollectionViewCell.h"
#import "AddRssView.h"
@interface AddClassViewController ()
@property (nonatomic,strong)NSMutableArray *rssClassArr;
@property (nonatomic,strong)AddRssView *headView;
@end

@implementation AddClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
//        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
//    }
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WXXCOLOR(244, 244, 244, 1);
//    [self initTitleBar];
     self.rssClassArr = [[PenSoundDao sharedPenSoundDao]selectrssClassToBigId:self.bigId];
    [self initCollectionView];
    
}


-(void)loadInfo{
    
    
    
    self.rssClassArr = [[PenSoundDao sharedPenSoundDao]selectrssClassToBigId:self.bigId];
    
    [self.collectionView reloadData];
    [self.collectionView reloadItemsAtIndexPaths:[self.collectionView indexPathsForVisibleItems]];
    
    
    //    [self doQueueLoadRss];
}

-(void)showAddBtn{
    self.rssClassArr = [[PenSoundDao sharedPenSoundDao]selectrssClassToBigId:self.bigId];
    self.navigationItem.rightBarButtonItem = [self createTitlebtn:@"添加" action:@selector(addNewRss)];
    if (self.rssClassArr.count <=0) {
        [self addNewRss];
    }
}

-(void)addNewRss{

    if (!self.headView) {
        self.headView = [[AddRssView alloc]initWithFrame:UIBounds];
        [self.view addSubview: self.headView];
        __block AddClassViewController *blockSelf = self;
        self.headView.setCallBack = ^(){
            [blockSelf loadInfo];
            //刷新主界面的订阅列表
            if (blockSelf.refreshCallback) {
                blockSelf.refreshCallback();
            }
        };
    }
    [self.headView showSelf];
}

//标题
-(void)initTitleBar{
    UIView *titlV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.height, 64)];
    titlV.backgroundColor = WXXCOLOR(192, 52, 52, 1);
    titlV.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:titlV.bounds cornerRadius:3].CGPath;
    titlV.layer.shadowOffset = CGSizeMake(0, 0);
    titlV.layer.shadowRadius = 1;
    titlV.layer.shadowColor = [UIColor blackColor].CGColor;
    titlV.layer.shadowOpacity = 0.5;
    [self.view addSubview:titlV];
    WxxLabel *titlLb = [[WxxLabel alloc]initWithFrame:CGRectMake(0, 30, UIBounds.size.width, 18)
                                                color:WXXCOLOR(255,255,255, 1)
                                                 font:18];
    titlLb.textAlignment = NSTextAlignmentCenter;
    titlLb.text = @"添加订阅";
    [titlV addSubview:titlLb];
    WxxButton *closeBtn = [[WxxButton alloc]initWithPoint:CGPointMake(16, 20+(44-24)/2) image:@"common_icon_return" touchSize:20];
    [titlV addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    

}
-(void)close{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}


-(void)initCollectionView{
    if (!self.collectionView) {
        //确定是水平滚动，还是垂直滚动
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        flowLayout.minimumInteritemSpacing = 10;
        self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, UIBounds.size.width, UIBounds.size.height-64) collectionViewLayout:flowLayout];
        self.collectionView.dataSource=self;
        self.collectionView.delegate=self;
        [self.collectionView setBackgroundColor:[UIColor clearColor]];
        
        //注册Cell，必须要有
        [self.collectionView registerClass:[AddCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        self.collectionView.alwaysBounceVertical = YES;
        [self.view addSubview:self.collectionView];
        
        
    }
    
}



#pragma mark -- UICollectionViewDataSource
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        CGSize size = {UIBounds.size.width, 10};
        return size;
    }
    else
    {
        CGSize size = {UIBounds.size.width, 100};
        return size;
    }
}


//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.rssClassArr.count;
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
    AddCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = WXXCOLOR(0, 0, 0, 1);
    
    RssClassData *rsdata = [self.rssClassArr objectAtIndex:indexPath.row];
    [cell setInfo:rsdata];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
// 定义上下cell的最小间距
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    return 2;
//}


//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(UIBounds.size.width-20, 90);
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
 
    AddCollectionViewCell * cell = (AddCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell setCheck];
    
    //刷新主界面的订阅列表
//    if (self.refreshCallback) {
//        self.refreshCallback();
//    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //    resignFirstRespond
    [self.headView resignFirstRespond];
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
