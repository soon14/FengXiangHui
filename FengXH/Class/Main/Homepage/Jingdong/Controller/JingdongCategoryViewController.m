//
//  JingdongCategoryViewController.m
//  FengXH
//
//  Created by mac on 2018/8/8.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "JingdongCategoryViewController.h"
#import "JingdongImgCollectionViewCell.h"
#import "FreshViewController.h"
@interface JingdongCategoryViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic ,strong) NSArray *dataArr;
@property (nonatomic ,strong) UICollectionView *collectionView;

@end

@implementation JingdongCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"京东优选计划";
    [self jingdongRequest];
}
- (void)jingdongRequest{
    
    NSString *path = [HBBaseAPI appendAPIurl:self.urlStr];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:nil WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            _dataArr = [[responseDic objectForKey:@"result"] objectForKey:@"items"];
        }
        [self.view addSubview:self.collectionView];
        [self.collectionView reloadData];
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
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = KUIColorFromHex(0xB62521);
        //        _collectionView.
        //注册cell
        [_collectionView registerClass:[JingdongImgCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([JingdongImgCollectionViewCell class])];
        
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
    }
    return _collectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataArr.count-1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 1;
    
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSArray *arr = [_dataArr[indexPath.section] objectForKey:@"items"];
    
    JingdongImgCollectionViewCell * cell1 = (JingdongImgCollectionViewCell *)cell;
    
    [cell1 setImg:[arr[0] objectForKey:@"imgurl"]];
        
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        JingdongImgCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([JingdongImgCollectionViewCell class]) forIndexPath:indexPath];
        
        
        return cell;
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
        if (indexPath.section == 0) {
            return CGSizeMake(KMAINSIZE.width, 255);
        }else if (indexPath.section == 9){
            return CGSizeMake(KMAINSIZE.width, 63);
        }else{
            return CGSizeMake(KMAINSIZE.width-10, 105);
        }
    
}
//边距设置:整体边距的优先级，始终高于内部边距的优先级
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0||section == 9) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }else{
        return UIEdgeInsetsMake(5, 5, 0, 5);
    }
    
    
    
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    
    NSArray *arr = [_dataArr[indexPath.section] objectForKey:@"items"];
    
    
    if (indexPath.section == 0 || indexPath.section == 9) {
        
    }else{
        
        NSString *jumpURLString = [[arr[0] objectForKey:@"linkurl"] stringByReplacingOccurrencesOfString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=diypage&id=" withString:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=apply.diypage&id="];
        FreshViewController *vc =[[FreshViewController alloc]init];
        if (indexPath.section == 8) {
            
        }else{
            vc.typeColor = @"white";
        }
        vc.urlStr = jumpURLString;
        [self.navigationController pushViewController:vc animated:YES];
    }

    
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
