//
//  JingDongViewController.m
//  FengXH
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "JingDongViewController.h"
#import "JingdongImgCollectionViewCell.h"
#import "JingdongItemCollectionViewCell.h"
#import "GoodsListViewController.h"//全部商品列表
#import "JingdongCategoryViewController.h"//类目优选
@interface JingDongViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) NSMutableArray *dataMutableArr;
@end

@implementation JingDongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"京东优选";
    _dataMutableArr = [NSMutableArray array];
    [self jingdongRequest];
}
- (void)jingdongRequest{
    
    NSString *path = [HBBaseAPI appendAPIurl:self.urlStr];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:nil WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            NSArray *arr = [[responseDic objectForKey:@"result"] objectForKey:@"items"];
            for(int i = 0;i<arr.count;i++){
                if ([[arr[i] objectForKey:@"id"] isEqualToString:@"picture"]||[[arr[i] objectForKey:@"id"] isEqualToString:@"menu"]) {
                    [_dataMutableArr addObject:arr[i]];
                    
                }
            }
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
        flowLayout.minimumInteritemSpacing = 0;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
//        _collectionView.
        //注册cell
        [_collectionView registerClass:[JingdongImgCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([JingdongImgCollectionViewCell class])];
        [_collectionView registerClass:[JingdongItemCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([JingdongItemCollectionViewCell class])];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
    }
    return _collectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataMutableArr.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *arr = [_dataMutableArr[section] objectForKey:@"items"];
    return arr.count;
    
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *itemArr = [_dataMutableArr[indexPath.section] objectForKey:@"items"];
    if ([[_dataMutableArr[indexPath.section] objectForKey:@"id"] isEqualToString:@"picture"]) {
        JingdongImgCollectionViewCell * cell1 = (JingdongImgCollectionViewCell *)cell;
        
        [cell1 setImg:[itemArr[0] objectForKey:@"imgurl"]];

    }else{
        JingdongItemCollectionViewCell * cell1 = (JingdongItemCollectionViewCell *)cell;
        
        [cell1 setThumb:[itemArr[indexPath.item] objectForKey:@"imgurl"] setTitle:[itemArr[indexPath.item] objectForKey:@"text"]];
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([[_dataMutableArr[indexPath.section] objectForKey:@"id"] isEqualToString:@"picture"]) {
        JingdongImgCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JingdongImgCollectionViewCell class]) forIndexPath:indexPath];
        
        
        return cell;
    }else{
        JingdongItemCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JingdongItemCollectionViewCell class]) forIndexPath:indexPath];
        
        
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[_dataMutableArr[indexPath.section] objectForKey:@"id"] isEqualToString:@"picture"]) {
        if (indexPath.section == 0) {
            return CGSizeMake(KMAINSIZE.width, 180);
        }else{
            return CGSizeMake(KMAINSIZE.width, 115);
        }
    }else{
        return CGSizeMake(KMAINSIZE.width/4-5*KScreenRatio, 115);
    }
}
//边距设置:整体边距的优先级，始终高于内部边距的优先级
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    if ([[_dataMutableArr[section] objectForKey:@"id"] isEqualToString:@"picture"]) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }else{
        return UIEdgeInsetsMake(5, 10, 0, 10);
        
    }
    
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *itemArr = [_dataMutableArr[indexPath.section] objectForKey:@"items"];
    if ([[_dataMutableArr[indexPath.section] objectForKey:@"id"] isEqualToString:@"picture"]) {
        if (indexPath.section == 1) {
            
            NSString *jumpURLString = [[itemArr[indexPath.item] objectForKey:@"linkurl"] stringByReplacingOccurrencesOfString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=diypage&id=" withString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=apply.diypage&id="];
            JingdongCategoryViewController *vc =[[JingdongCategoryViewController alloc]init];
            vc.urlStr = jumpURLString;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        GoodsListViewController *vc = [[GoodsListViewController alloc]init];
        vc.categatoryId = [itemArr[indexPath.item] objectForKey:@"linkurl"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
