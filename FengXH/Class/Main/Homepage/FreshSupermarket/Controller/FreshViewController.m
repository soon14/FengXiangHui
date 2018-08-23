//
//  FreshViewController.m
//  FengXH
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "FreshViewController.h"
#import "JingdongImgCollectionViewCell.h"
#import "JingdongItemCollectionViewCell.h"
#import "FreshCollectionViewCell.h"
#import "HomepageBaseGoodsDetailController.h"//商品详情
#import "GoodsListViewController.h"//分类
@interface FreshViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) NSMutableArray *dataMutableArr;
@end

@implementation FreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"生鲜优选";
    
    [self freshRequest];
    _dataMutableArr = [NSMutableArray array];
}
- (void)freshRequest{
    
    NSString *path = [HBBaseAPI appendAPIurl:self.urlStr];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:nil WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            NSArray *arr = [[responseDic objectForKey:@"result"] objectForKey:@"items"];
            for(int i = 0;i<arr.count;i++){
                
                if ([[arr[i] objectForKey:@"id"] isEqualToString:@"banner"]||[[arr[i] objectForKey:@"id"] isEqualToString:@"picture"]||[[arr[i] objectForKey:@"id"] isEqualToString:@"goods"]||[[arr[i] objectForKey:@"id"] isEqualToString:@"picturew"]) {
                    
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
        if ([self.typeColor isEqualToString:@"white"]) {
            _collectionView.backgroundColor = KTableBackgroundColor;
        } else if ([self.typeColor isEqualToString:@"red"]) {
            _collectionView.backgroundColor = KUIColorFromHex(0x550D20);
        } else if ([self.typeColor isEqualToString:@"blue"]) {
            _collectionView.backgroundColor = KUIColorFromHex(0x2CA8FF);
        } else {
            _collectionView.backgroundColor = [UIColor blackColor];
        }
        
        //注册cell
        [_collectionView registerClass:[JingdongImgCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([JingdongImgCollectionViewCell class])];
        [_collectionView registerClass:[FreshCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([FreshCollectionViewCell class])];
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
    if ([[_dataMutableArr[indexPath.section] objectForKey:@"id"] isEqualToString:@"picture"]||[[_dataMutableArr[indexPath.section] objectForKey:@"id"] isEqualToString:@"banner"]||[[_dataMutableArr[indexPath.section] objectForKey:@"id"] isEqualToString:@"picturew"]) {
        JingdongImgCollectionViewCell * cell1 = (JingdongImgCollectionViewCell *)cell;
        
        [cell1 setImg:[itemArr[indexPath.item] objectForKey:@"imgurl"]];
        
    }else{
        FreshCollectionViewCell * cell1 = (FreshCollectionViewCell *)cell;
        [cell1 setData:[itemArr[indexPath.item] objectForKey:@"thumb"] AndRecommended:[itemArr[indexPath.item] objectForKey:@"goodsiconsrc"] AndTitle:[itemArr[indexPath.item] objectForKey:@"title"] AndPrice:[itemArr[indexPath.item] objectForKey:@"price"]];
    }
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if ([[_dataMutableArr[indexPath.section] objectForKey:@"id"] isEqualToString:@"picture"]||[[_dataMutableArr[indexPath.section] objectForKey:@"id"] isEqualToString:@"banner"]||[[_dataMutableArr[indexPath.section] objectForKey:@"id"] isEqualToString:@"picturew"]) {
        JingdongImgCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JingdongImgCollectionViewCell class]) forIndexPath:indexPath];
        return cell;
    }else{
        FreshCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([FreshCollectionViewCell class]) forIndexPath:indexPath];
        
        
        return cell;
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([[_dataMutableArr[indexPath.section] objectForKey:@"id"] isEqualToString:@"picture"]||[[_dataMutableArr[indexPath.section] objectForKey:@"id"] isEqualToString:@"banner"]) {
        if (indexPath.section == 0) {
            return CGSizeMake(KMAINSIZE.width, 250);
        }else{
            return CGSizeMake(KMAINSIZE.width, 115);
        }
    }else if ([[_dataMutableArr[indexPath.section] objectForKey:@"id"] isEqualToString:@"picturew"]){
        return CGSizeMake(KMAINSIZE.width/2-7.5*KScreenRatio,112);
    }
    else{
        return CGSizeMake(KMAINSIZE.width/3-10*KScreenRatio, 210);
    }
}
//边距设置:整体边距的优先级，始终高于内部边距的优先级
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    if ([[_dataMutableArr[section] objectForKey:@"id"] isEqualToString:@"picture"]||[[_dataMutableArr[section] objectForKey:@"id"] isEqualToString:@"banner"]) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }else{
        return UIEdgeInsetsMake(5, 5, 5, 5);
        
    }
    
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *itemArr = [_dataMutableArr[indexPath.section] objectForKey:@"items"];
    if ([[_dataMutableArr[indexPath.section] objectForKey:@"id"] isEqualToString:@"picture"]||[[_dataMutableArr[indexPath.section] objectForKey:@"id"] isEqualToString:@"banner"]||[[_dataMutableArr[indexPath.section] objectForKey:@"id"] isEqualToString:@"picturew"]) {
        //图片点击
        if ([[itemArr[indexPath.item] objectForKey:@"linkurl"] isEqual:[NSNull null]]) {
            
        }else{
            GoodsListViewController *vc = [[GoodsListViewController alloc]init];
            vc.categatoryId = [itemArr[indexPath.item] objectForKey:@"linkurl"];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else{
        //商品点击
        HomepageBaseGoodsDetailController *vc = [[HomepageBaseGoodsDetailController alloc]init];
        vc.goodsId = [itemArr[indexPath.item] objectForKey:@"gid"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    NSArray *itemArr = [_dataMutableArr[section] objectForKey:@"items"];
    if ([[_dataMutableArr[section] objectForKey:@"id"] isEqualToString:@"picture"]&&itemArr.count>1) {
        return 0;
    }else{
        return 10;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
