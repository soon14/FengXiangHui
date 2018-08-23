//
//  GroupOperatingViewController.m
//  FengXH
//
//  Created by mac on 2018/7/31.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GroupOperatingViewController.h"

#import "TitleCollectionViewCell.h"
#import "GroupOperatingModel.h"
#import "MoreGroupCollectionViewCell.h"
#import "MoreGoodsModel.h"
//创建订单
#import "CreateGroupOrderViewController.h"
//我要参团
#import "ParticipateGroupViewController.h"
//拼团玩法
#import "WebJumpViewController.h"
@interface GroupOperatingViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,TitleCollectionViewCellDelegate>
@property (nonatomic , strong) UICollectionView *collectionView ;
@property (nonatomic , strong) NSDictionary *dataDic;
@property (nonatomic , strong) NSArray *dataGoodsDic;
@end

@implementation GroupOperatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"拼团操作";
    [self operatingRequest];
    

}
- (void)operatingRequest{
    NSString * urlString = @"r=apply.groups.goods.openGroups";
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [DBHUD Hiden:YES fromView:self.view];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:@{@"token":tokenStr,@"id":self.goodsId} WithSuccessBlock:^(NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 1) {
            
            _dataDic = [[responseDic objectForKey:@"result"] objectForKey:@"goods"];
            _dataGoodsDic = [[responseDic objectForKey:@"result"] objectForKey:@"teams"];
            [self.view addSubview:self.collectionView];
            [self.collectionView reloadData];
            
        }
        
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        
    }];
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = KTableBackgroundColor;
        //注册cell
        [_collectionView registerClass:[TitleCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([TitleCollectionViewCell class])];
        [_collectionView registerClass:[MoreGroupCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([MoreGroupCollectionViewCell class])];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
    }
    return _collectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    return 1;
    if (section == 0) {
        return 1;
    }else{
        return _dataGoodsDic.count;
    }
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        TitleCollectionViewCell * cell1 = (TitleCollectionViewCell *)cell;
        cell1.groupOperatingModel = [GroupOperatingModel yy_modelWithDictionary:_dataDic];
    }else{
        MoreGroupCollectionViewCell * cell1 = (MoreGroupCollectionViewCell *)cell;
        cell1.moreGoodsModel = [MoreGoodsModel yy_modelWithDictionary:_dataGoodsDic[indexPath.item]];
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        TitleCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([TitleCollectionViewCell class]) forIndexPath:indexPath];
        cell.mdelegate = self;
        
        return cell;
    }else{
        MoreGroupCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MoreGroupCollectionViewCell class]) forIndexPath:indexPath];
        
        
        return cell;
    }
}
- (void)btnClicked:(NSInteger)sender {
    if (sender == 0) {
        NSLog(@"参团");
        ParticipateGroupViewController *vc = [[ParticipateGroupViewController alloc]init];
        vc.goodsId = self.goodsId;
        [self.navigationController pushViewController:vc animated:YES];
    }else if(sender == 1){
        NSLog(@"开团");
        CreateGroupOrderViewController *vc = [[CreateGroupOrderViewController alloc]init];
        vc.type = @"groups";
        vc.goodsId = self.goodsId;
        vc.heads = @"1";
        vc.teamid = @"";
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        NSLog(@"玩法");
        
        WebJumpViewController *vc = [[WebJumpViewController alloc]init];
        vc.jumpURL = [NSString stringWithFormat:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=groups.team.rules&mid=%@%@",[[NSUserDefaults standardUserDefaults]objectForKey:KUserId],[[NSUserDefaults standardUserDefaults]objectForKey:KUserToken]];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return CGSizeMake(KMAINSIZE.width, 350);
    }else{
        return CGSizeMake(KMAINSIZE.width/2-10*KScreenRatio, 245);
    }
}
//边距设置:整体边距的优先级，始终高于内部边距的优先级
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    if (section == 1) {
        return UIEdgeInsetsMake(0, 5, 0, 5);
    }else{
        return  UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
