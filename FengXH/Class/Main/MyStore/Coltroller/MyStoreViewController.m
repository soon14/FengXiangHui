//
//  MyStoreViewController.m
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MyStoreViewController.h"
#import "StoreMessageCell.h"
#import "StoreCommissionCell.h"
#import "StoreBottomItemCell.h"
#import "StoreModel.h"
#import "ShopkeeperCommissionViewController.h"
#import "DetailBaseViewController.h"
#import "MyTeamBaseViewController.h"
#import "PromotionPosterViewController.h"
#import "MyStoreSettingViewController.h"

@interface MyStoreViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic , strong)UICollectionView *storeCollectionView ;//我的小店collectionview
@property(nonatomic,strong)StoreModel *dataModel;

@property(nonatomic,strong)NSArray *itemData;

@end

@implementation MyStoreViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self myStoreDataRequest];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"我的小店";
    
}
#pragma mark - 数据请求
- (void)myStoreDataRequest {
    NSString * urlString = @"r=apply.commission";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:@{@"token":tokenStr} WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if (_storeCollectionView.mj_header.isRefreshing == YES) {
            [_storeCollectionView.mj_header endRefreshing];
        }
        if ([responseDic[@"status"] integerValue] == 1) {
            self.dataModel = [StoreModel yy_modelWithDictionary:responseDic[@"result"]];
            [self clearUpData];
            if (!_storeCollectionView) {
                [self.view addSubview:self.storeCollectionView];
            }
            else
            {
                [self.storeCollectionView reloadData];
            }
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        if (_storeCollectionView.mj_header.isRefreshing == YES) {
            [_storeCollectionView.mj_header endRefreshing];
        }
    }];
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0) {
        StoreMessageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([StoreMessageCell class]) forIndexPath:indexPath];
        return cell;
    }
    else if (indexPath.section==1)
    {
        StoreCommissionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([StoreCommissionCell class]) forIndexPath:indexPath];

        return cell;
    }
    else
    {
        StoreBottomItemCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([StoreBottomItemCell class]) forIndexPath:indexPath];
        
        return cell;
    }
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section==2) {
        return 5;// 隐藏 城市合伙人股东分红。 return 7显示
    }
    else
    {
        return 1;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    MJWeakSelf
    
    if (indexPath.section==0) {
        StoreMessageCell * messageCell = (StoreMessageCell *)cell;
        messageCell.storeMessageData = self.dataModel;
        messageCell.cellClickBlock = ^ {
            [weakSelf settingBtnAction];
        };
    }
    else if (indexPath.section==1)
    {
        StoreCommissionCell * commissionCell = (StoreCommissionCell *)cell;
        commissionCell.storeCommissionData = self.dataModel;
        commissionCell.commissionBlock = ^{
            [weakSelf commissionWithdraw];
        };
    }
    else
    {
        StoreBottomItemCell *itemCell=(StoreBottomItemCell *)cell;
        itemCell.storeBottomItemData=self.itemData[indexPath.row];
        
    }
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    UIViewController *vc;
    if (indexPath.section==2) {
        switch (indexPath.row) {
            case 0:
                vc=[[ShopkeeperCommissionViewController alloc]init];
                break;
            case 1:
                vc=[[DetailBaseViewController alloc] initWithType:0];
                break;
            case 2:
                vc=[[DetailBaseViewController alloc] initWithType:1];
                break;
            case 3:
                vc=[[MyTeamBaseViewController alloc]init];
                break;
            case 4:
                vc=[[PromotionPosterViewController alloc]init];
                break;
            default:
                break;
        }
    }
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
     
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat collectionViewWidth = collectionView.frame.size.width;
    if (indexPath.section==2) {
        return CGSizeMake((collectionViewWidth - 8.0) / 3.0, 130*KScreenRatio);
    }
    else if (indexPath.section==1)
    {
        return CGSizeMake(collectionViewWidth, 180);
    }
    else
    {
        return CGSizeMake(collectionViewWidth, 180);
    }
    
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section==2) {
        return UIEdgeInsetsMake(2, 2, 2, 2);
    }
    else
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }

}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section==2) {
        return 2.0;
    }
    else
    {
        return CGFLOAT_MIN;
    }
   
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section==2) {
        return 2.0;
    }
    else
    {
        return CGFLOAT_MIN;
    }
}
-(void)clearUpData
{
    NSString *name=@"name";
    NSString *count=@"count";
    NSString *iconImgName=@"iconImgName";
    self.itemData=@[@{name:@"店主佣金",count:[NSString stringWithFormat:@"%@元",self.dataModel.withdraw],iconImgName:@"店主佣金"},@{name:@"佣金明细",count:[NSString stringWithFormat:@"%@笔",self.dataModel.order],iconImgName:@"佣金明细"},@{name:@"提现明细",count:[NSString stringWithFormat:@"%@笔",self.dataModel.log],iconImgName:@"提现明细"},@{name:@"我的团队",count:[NSString stringWithFormat:@"%@人",self.dataModel.down],iconImgName:@"我的团队"},@{name:@"推广海报",count:@"",iconImgName:@"推广海报"},@{name:@"城市合伙人",count:@"",iconImgName:@"城市合伙人"},@{name:@"股东分红",count:@"",iconImgName:@"股东分红"}];
}
#pragma mark ----- 设置
-(void)settingBtnAction
{
    MyStoreSettingViewController *vc=[MyStoreSettingViewController new];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark ----- 佣金提现
-(void)commissionWithdraw
{
    ShopkeeperCommissionViewController *vc=[ShopkeeperCommissionViewController new];
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 懒加载
- (UICollectionView *)storeCollectionView {
    if (!_storeCollectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _storeCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KTabbarHeight) collectionViewLayout:flowLayout];
        _storeCollectionView.backgroundColor = KTableBackgroundColor;
        
        //注册商店信息部分cell
        [_storeCollectionView registerClass:[StoreMessageCell class] forCellWithReuseIdentifier:NSStringFromClass([StoreMessageCell class])];
        //注册商店佣金cell
        [_storeCollectionView registerClass:[StoreCommissionCell class] forCellWithReuseIdentifier:NSStringFromClass([StoreCommissionCell class])];
        //注册底部item的cell
        [_storeCollectionView registerClass:[StoreBottomItemCell class] forCellWithReuseIdentifier:NSStringFromClass([StoreBottomItemCell class])];
        
        _storeCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(myStoreDataRequest)];
        
        _storeCollectionView.dataSource = self;
        _storeCollectionView.delegate = self;
    }
    return _storeCollectionView;
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
