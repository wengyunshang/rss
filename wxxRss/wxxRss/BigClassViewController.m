//
//  BigClassViewController.m
//  wxxRss
//
//  Created by weng xiangxun on 15/5/19.
//  Copyright (c) 2015年 wxx. All rights reserved.
//

#import "BigClassViewController.h"
#import "BigCollectionViewCell.h"
#import "AddClassViewController.h"

@interface BigClassViewController ()
@property (nonatomic,strong)NSMutableArray *rssClassArr;

@end

@implementation BigClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    self.navigationItem.title = @"订阅";
    [[UINavigationBar appearance] setTintColor:WXXCOLOR(0, 0, 0, 0.5)];
//    NSDictionary * dict=[NSDictionary dictionaryWithObject:WXXCOLOR(0, 0, 0, 1) forKey:UITextAttributeTextColor];
//    self.navigationController.navigationBar.titleTextAttributes = dict;
    [self.navigationController.navigationBar setBarTintColor:WXXCOLOR(255, 255, 255, 1)];
    self.navigationController.navigationBar.translucent = NO;
//    self.navigationController.navigationBarHidden = YES;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WXXCOLOR(242, 242, 242, 1);
    
    self.navigationItem.leftBarButtonItem = [self createRightbarbtn:@"contenttoolbar_hd_close" action:@selector(close)];
    
//    [self initTitleBar];
//    self.rssClassArr = [[PenSoundDao sharedPenSoundDao]selectBigClassList];
    [self initCollectionView];
    
    
}

//标题
-(void)initTitleBar{
    UIView *titlV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UIBounds.size.height, 64)];
    titlV.backgroundColor = WXXCOLOR(192, 52, 52, 1);
//    titlV.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:titlV.bounds cornerRadius:3].CGPath;
//    titlV.layer.shadowOffset = CGSizeMake(0, 0);
//    titlV.layer.shadowRadius = 1;
//    titlV.layer.shadowColor = [UIColor blackColor].CGColor;
//    titlV.layer.shadowOpacity = 0.5;
    [self.view addSubview:titlV];
    WxxLabel *titlLb = [[WxxLabel alloc]initWithFrame:CGRectMake(0, 30, UIBounds.size.width, 18)
                                                color:WXXCOLOR(255,255,255, 1)
                                                 font:18];
    titlLb.textAlignment = NSTextAlignmentCenter;
    titlLb.text = @"添加订阅";
    [titlV addSubview:titlLb];
    WxxButton *closeBtn = [[WxxButton alloc]initWithPoint:CGPointMake(16, 20+(44-24)/2) image:@"close" touchSize:20];
    [titlV addSubview:closeBtn];
    [closeBtn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
}
-(void)close{
    [self dismissViewControllerAnimated:YES completion:^{
        if (self.refreshCallback) {
            self.refreshCallback();
        }
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
        [self.collectionView registerClass:[BigCollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        self.collectionView.alwaysBounceVertical = YES;
        [self.view addSubview:self.collectionView];
        
        //    self.collectionView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
        WxxButton *addView = [[WxxButton alloc]initWithFrame:CGRectMake(10, 15, UIBounds.size.width-20, 50)];
        addView.backgroundColor = WXXCOLOR(255, 255, 255, 1);
        [addView setTitle:@"自定义" forState:UIControlStateNormal];
        [addView setTitleColor:WXXCOLOR(0, 0, 0, 0.87) forState:UIControlStateNormal];
        addView.layer.borderColor = WXXCOLOR(0, 0, 0, 0.2).CGColor;
        addView.layer.borderWidth = 0.5;
        [addView addTarget:self action:@selector(addNewRss) forControlEvents:UIControlEventTouchUpInside];
        [self.collectionView addSubview:addView];
        UIImage *image = [UIImage imageNamed:@"rightArrowgray"];
        UIImageView *arrowImgv = [[UIImageView alloc]initWithFrame:CGRectMake(addView.frame.size.width-image.size.width-16, (addView.frame.size.height-image.size.height)/2, image.size.width, image.size.height)];
        arrowImgv.image = image;
        [addView addSubview:arrowImgv];
        
    }
    
}

-(void)addNewRss{

    AddClassViewController *liVC = [[AddClassViewController alloc]init];
    liVC.bigId = @"0";
    liVC.navigationItem.title = @"自定义";
    [liVC showAddBtn];
    [self.navigationController pushViewController:liVC animated:YES];
    liVC.refreshCallback = ^(){
        
    };
}

#pragma mark -- UICollectionViewDataSource
-(CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        CGSize size = {UIBounds.size.width, 70};
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
    BigCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    //    cell.backgroundColor = WXXCOLOR(0, 0, 0, 1);
    
    RssBigClassData *rsdata = [self.rssClassArr objectAtIndex:indexPath.row];
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
    return CGSizeMake(UIBounds.size.width-20, 50);
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
    
//    AddCollectionViewCell * cell = (AddCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    [cell setCheck];
//    
//    //刷新主界面的订阅列表
    AddClassViewController *liVC = [[AddClassViewController alloc]init];
    RssBigClassData *rsdata = [self.rssClassArr objectAtIndex:indexPath.row];
    liVC.bigId = rsdata.rrbId;
    liVC.navigationItem.title = rsdata.rrbName;
    [self.navigationController pushViewController:liVC animated:YES];
//    liVC.refreshCallback = ^(){
//        if (self.refreshCallback) {
//            self.refreshCallback();
//        }
//    };
}

 

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
