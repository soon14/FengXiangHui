//
//  UnionMerchantViewController.m
//  FengXH
//
//  Created by sun on 2018/10/12.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "UnionMerchantViewController.h"
#import "UnionMerchantResultModel.h"
#import "UnionMerchantHeaderView.h"
#import "UnionMerchantContentCell.h"
#import "GoodsDetailViewController.h"
#import "MerchantsUnionViewController.h"

@interface UnionMerchantViewController ()<UITableViewDelegate,UITableViewDataSource,UnionMerchantContentCellDelegate,UnionMerchantHeaderViewDelegate>
{
    NSMutableArray *merchgroupItemsArray;
    NSMutableArray *goodsItemsArray;
}
/** tableView */
@property(nonatomic , strong)UITableView *merchantTableView;

@end

@implementation UnionMerchantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联盟商户";
    merchgroupItemsArray = [NSMutableArray array];
    goodsItemsArray = [NSMutableArray array];
    
    [self.view addSubview:self.merchantTableView];
    [self unioMerchantDataRequest];
}

#pragma mark - 首页数据请求
- (void)unioMerchantDataRequest {
    NSString * urlString = @"r=apply.diypage&id=395";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:nil WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
        
            UnionMerchantResultModel *resultModel = [UnionMerchantResultModel yy_modelWithDictionary:responseDic[@"result"]];
            for (UnionMerchantResultItemsModel *itemsModel in resultModel.items) {
                if ([itemsModel.itemsID isEqualToString:@"merchgroup"]) {
                    [merchgroupItemsArray addObject:itemsModel.items];
                } else if ([itemsModel.itemsID isEqualToString:@"goods"]) {
                    [goodsItemsArray addObject:itemsModel.items];
                }
            }
            
            [self.merchantTableView reloadData];
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - tableView
- (UITableView *)merchantTableView {
    if (!_merchantTableView) {
        _merchantTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight) style:UITableViewStyleGrouped];
        _merchantTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _merchantTableView.backgroundColor = KTableBackgroundColor;
        _merchantTableView.showsVerticalScrollIndicator = NO;
        _merchantTableView.dataSource = self;
        _merchantTableView.delegate = self;
        _merchantTableView.estimatedRowHeight = 0;
        _merchantTableView.estimatedSectionHeaderHeight = 0;
        _merchantTableView.estimatedSectionFooterHeight = 0;
        [_merchantTableView registerClass:[UnionMerchantHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([UnionMerchantHeaderView class])];
        [_merchantTableView registerClass:[UnionMerchantContentCell class] forCellReuseIdentifier:NSStringFromClass([UnionMerchantContentCell class])];
        [_merchantTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    }
    return _merchantTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([merchgroupItemsArray count] > 0 && [goodsItemsArray count]) {
        return [merchgroupItemsArray count] <= [goodsItemsArray count] ? [merchgroupItemsArray count] : [goodsItemsArray count];
    } return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (KMAINSIZE.width-20)/3 + 75;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([merchgroupItemsArray count] > 0 && [goodsItemsArray count]) {
        return 80;
    } return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if ([merchgroupItemsArray count] > 0 && [goodsItemsArray count]) {
        UnionMerchantHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([UnionMerchantHeaderView class])];
        headerView.delegate = self;
        headerView.merchantArray = merchgroupItemsArray[section];
        return headerView;
    } return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([merchgroupItemsArray count] > 0 && [goodsItemsArray count] > 0) {
        UnionMerchantContentCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UnionMerchantContentCell class])];
        goodsCell.delegate = self;
        goodsCell.goodsArray = goodsItemsArray[indexPath.section];
        return goodsCell;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    return cell;
}

#pragma mark - 商品被点击
- (void)UnionMerchantContentCell:(UnionMerchantContentCell *)cell didSelectItemWith:(UnionMerchantResultItemsItemsModel *)goodsDataModel {
    GoodsDetailViewController *VC = [[GoodsDetailViewController alloc] init];
    VC.goodsID = goodsDataModel.gid;
    [self.navigationController pushViewController:VC animated:YES];
}

#pragma mark - 商品被点击
- (void)UnionMerchantHeaderView:(UnionMerchantHeaderView *)cell didSelectItemWith:(UnionMerchantResultItemsItemsModel *)merchantModel {
    MerchantsUnionViewController *VC = [[MerchantsUnionViewController alloc] init];
    VC.unionMerchantModel = merchantModel;
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
