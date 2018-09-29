//
//  IntegralGoodsDetailViewController.m
//  FengXH
//
//  Created by  on 2018/9/27.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralGoodsDetailViewController.h"
#import "IntegralGoodsDetailResultModel.h"
#import "IntegralGoodsDetailGoodsInfoCell.h"
#import "IntegralGoodsDetailGoodsDetailCell.h"
#import "IntegralGoodsDetailRecommendCell.h"
#import "IntegralGoodsDetailBottomView.h"
#import "IntegralCreatOrderViewController.h"

@interface IntegralGoodsDetailViewController ()<UITableViewDelegate,UITableViewDataSource,IntegralGoodsDetailRecommendCellDelegate,IntegralGoodsDetailBottomViewDelegate>
{
    NSMutableArray *contentImageHeightArray;        //存放详情页图片高度的数组
}
/** model */
@property(nonatomic , strong)IntegralGoodsDetailResultModel *resultModel;
/** tableView */
@property(nonatomic , strong)UITableView *detailTableView;
/** bottom */
@property(nonatomic , strong)IntegralGoodsDetailBottomView *bottomView;

@end

@implementation IntegralGoodsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品详情";
    contentImageHeightArray = [NSMutableArray array];
    
    [self.view addSubview:self.detailTableView];
    [self.view addSubview:self.bottomView];
    
    [self integralGoodsDetailDataRequest];
}

- (IntegralGoodsDetailBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[IntegralGoodsDetailBottomView alloc] initWithFrame:CGRectMake(0, KMAINSIZE.height-KNaviHeight-(50+KBottomHeight), KMAINSIZE.width, 50+KBottomHeight)];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

#pragma mark - 积分兑换商品详情
- (void)integralGoodsDetailDataRequest {
    NSString *url = @"r=apply.creditshop.detail";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              self.goodsID,@"id", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            self.resultModel = [IntegralGoodsDetailResultModel yy_modelWithDictionary:responseDic[@"result"]];
            [self.detailTableView reloadData];
            [self caculateContentImageHeight];
            self.bottomView.detailResultModel = self.resultModel;
            
        } else if ([responseDic[@"status"] integerValue] == 401) {
            [self presentLoginViewControllerWithSuccessBlock:^{
                [self integralGoodsDetailDataRequest];
            } WithFailureBlock:nil];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 计算详情页每张图片高度并放入数组
- (void)caculateContentImageHeight {
    //创建一个分线程
    MJWeakSelf
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSInteger i=0; i < weakSelf.resultModel.goodsdetail.count; i++) {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",weakSelf.resultModel.goodsdetail[i]]]];
            UIImage *image = [UIImage imageWithData:data];
            [contentImageHeightArray addObject:[NSString stringWithFormat:@"%f",KMAINSIZE.width/image.size.width*image.size.height]];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
            [weakSelf.detailTableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationNone];
        });
    });
}

#pragma mark - tableView
- (UITableView *)detailTableView {
    if (!_detailTableView) {
        _detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-(50+KBottomHeight)) style:UITableViewStylePlain];
        _detailTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _detailTableView.backgroundColor = KTableBackgroundColor;
        _detailTableView.showsVerticalScrollIndicator = NO;
        _detailTableView.dataSource = self;
        _detailTableView.delegate = self;
        _detailTableView.estimatedRowHeight = 0;
        _detailTableView.estimatedSectionHeaderHeight = 0;
        _detailTableView.estimatedSectionFooterHeight = 0;
        [_detailTableView registerClass:[IntegralGoodsDetailGoodsInfoCell class] forCellReuseIdentifier:NSStringFromClass([IntegralGoodsDetailGoodsInfoCell class])];
        [_detailTableView registerClass:[IntegralGoodsDetailGoodsDetailCell class] forCellReuseIdentifier:NSStringFromClass([IntegralGoodsDetailGoodsDetailCell class])];
        [_detailTableView registerClass:[IntegralGoodsDetailRecommendCell class] forCellReuseIdentifier:NSStringFromClass([IntegralGoodsDetailRecommendCell class])];
        [_detailTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _detailTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.resultModel) {
        return 3;
    } return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 1: return contentImageHeightArray.count; break;
        default: return 1; break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: return 360*KScreenRatio+160; break;
        case 1: {
            if (contentImageHeightArray.count > 0) {
                return [contentImageHeightArray[indexPath.row] floatValue];
            } return CGFLOAT_MIN;
        } break;
        case 2: {
            return 225;
        } break;
        default: return CGFLOAT_MIN; break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            IntegralGoodsDetailGoodsInfoCell *infoCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IntegralGoodsDetailGoodsInfoCell class])];
            
            return infoCell;
        } break;
        case 1: {
            IntegralGoodsDetailGoodsDetailCell *detailCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IntegralGoodsDetailGoodsDetailCell class])];
            return detailCell;
        } break;
        case 2: {
            IntegralGoodsDetailRecommendCell *recommendCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([IntegralGoodsDetailRecommendCell class])];
            return recommendCell;
        } break;
        default:
            break;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            IntegralGoodsDetailGoodsInfoCell *infoCell = (IntegralGoodsDetailGoodsInfoCell *)cell;
            infoCell.detailResultModel = self.resultModel;
        } break;
        case 1: {
            if (self.resultModel.goodsdetail.count > 0) {
                IntegralGoodsDetailGoodsDetailCell *detailCell = (IntegralGoodsDetailGoodsDetailCell *)cell;
                detailCell.imageURLString = self.resultModel.goodsdetail[indexPath.row];
            }
        } break;
        case 2: {
            IntegralGoodsDetailRecommendCell *recommendCell = (IntegralGoodsDetailRecommendCell *)cell;
            recommendCell.delegate = self;
            recommendCell.recommendGoodsArray = self.resultModel.goodsrec;
        } break;
        default:
            break;
    }
}

#pragma mark - 推荐商品被点击
- (void)IntegralGoodsDetailRecommendCell:(IntegralGoodsDetailRecommendCell *)cell didSelectRecommendGoodsWith:(IntegralGoodsDetailResultGoodsRecommendModel *)goodsDataModel {
    IntegralGoodsDetailViewController *VC = [[IntegralGoodsDetailViewController alloc] init];
    VC.goodsID = goodsDataModel.goodsID;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 立即兑换按钮被点击
- (void)IntegralGoodsDetailBottomView:(IntegralGoodsDetailBottomView *)view {
    IntegralCreatOrderViewController *VC = [[IntegralCreatOrderViewController alloc] init];
    VC.goodsID = self.resultModel.goodsID;
    [self.navigationController pushViewController:VC animated:YES];
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
