//
//  ConfirmOrderViewController.m
//  FengXH
//
//  Created by sun on 2018/8/2.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ConfirmOrderViewController.h"
#import "ConfirmOrderBottomView.h"
#import "AddressResultModel.h"
#import "ConfirmOrderCreatResultModel.h"
#import "ConfirmOrderAddressCell.h"
#import "ConfirmOrderStoreHeaderView.h"
#import "AddressSelectViewController.h"
#import "ConfirmOrderGoodsCell.h"
#import "ConfirmOrderTotalPriceCell.h"
#import "ConfirmOrderJDFreightCell.h"
#import "ConfirmOrderRemarkCell.h"
#import "ConfirmOrderDeductCell.h"
#import "ConfirmOrderCouponCell.h"
#import "ConfirmOrderSelectCouponView.h"
#import "ConfirmOrderCouponResultModel.h"
#import "ConfirmOrderDetailPriceCell.h"
#import "ConfirmOrderCouponPriceCell.h"
#import "ConfirmOrderCouponPriceResultModel.h"
#import "PayOrderViewController.h"

static NSString *confirmOrderNothingCellID = @"confirmOrderNothingCellID";

@interface ConfirmOrderViewController ()<UITableViewDelegate,UITableViewDataSource>

/** 底部 View */
@property(nonatomic , strong)ConfirmOrderBottomView *bottomView;
/** tableView */
@property(nonatomic , strong)UITableView *confirmTableView;
/** 默认的地址模型 */
@property(nonatomic , strong)AddressResultListModel *addressModel;
/** 创建订单 model */
@property(nonatomic , strong)ConfirmOrderCreatResultModel *orderCreatResultModel;
/** 买家留言 */
@property(nonatomic , strong)UITextField *remarkTextField;
/** F 币支付 */
@property(nonatomic , assign)BOOL deductPay;
/** 被选择的优惠券的 Model */
@property(nonatomic , strong)ConfirmOrderCouponResultListModel *selectCouponModel;
/** 使用优惠券后返回的 Model */
@property(nonatomic , strong)ConfirmOrderCouponPriceResultModel *couponPriceModel;

@end

@implementation ConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"确认下单";
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.confirmTableView];
    
    //请求个人地址,请求成功之后再去请求创建订单接口
    [self myAddressListRequest];
}

#pragma mark - 底部 View
- (ConfirmOrderBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[ConfirmOrderBottomView alloc] initWithFrame:CGRectMake(0, KMAINSIZE.height-KNaviHeight-KBottomHeight-50, KMAINSIZE.width, 50)];
        MJWeakSelf
        _bottomView.payBlock = ^(UIButton *sender) {
            [weakSelf payButtonDidClicked];
        };
    }
    return _bottomView;
}

#pragma mark - tableView
- (UITableView *)confirmTableView {
    if (!_confirmTableView) {
        _confirmTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight-50) style:UITableViewStylePlain];
        _confirmTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _confirmTableView.backgroundColor = KTableBackgroundColor;
        _confirmTableView.showsVerticalScrollIndicator = NO;
        _confirmTableView.dataSource = self;
        _confirmTableView.delegate = self;
        _confirmTableView.estimatedRowHeight = 0;
        _confirmTableView.estimatedSectionHeaderHeight = 0;
        _confirmTableView.estimatedSectionFooterHeight = 0;
        [_confirmTableView registerClass:[ConfirmOrderAddressCell class] forCellReuseIdentifier:NSStringFromClass([ConfirmOrderAddressCell class])];
        [_confirmTableView registerClass:[ConfirmOrderStoreHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([ConfirmOrderStoreHeaderView class])];
        [_confirmTableView registerClass:[ConfirmOrderGoodsCell class] forCellReuseIdentifier:NSStringFromClass([ConfirmOrderGoodsCell class])];
        [_confirmTableView registerClass:[ConfirmOrderTotalPriceCell class] forCellReuseIdentifier:NSStringFromClass([ConfirmOrderTotalPriceCell class])];
        [_confirmTableView registerClass:[ConfirmOrderJDFreightCell class] forCellReuseIdentifier:NSStringFromClass([ConfirmOrderJDFreightCell class])];
        [_confirmTableView registerClass:[ConfirmOrderRemarkCell class] forCellReuseIdentifier:NSStringFromClass([ConfirmOrderRemarkCell class])];
        [_confirmTableView registerClass:[ConfirmOrderDeductCell class] forCellReuseIdentifier:NSStringFromClass([ConfirmOrderDeductCell class])];
        [_confirmTableView registerClass:[ConfirmOrderCouponCell class] forCellReuseIdentifier:NSStringFromClass([ConfirmOrderCouponCell class])];
        [_confirmTableView registerClass:[ConfirmOrderDetailPriceCell class] forCellReuseIdentifier:NSStringFromClass([ConfirmOrderDetailPriceCell class])];
        [_confirmTableView registerClass:[ConfirmOrderCouponPriceCell class] forCellReuseIdentifier:NSStringFromClass([ConfirmOrderCouponPriceCell class])];
        [_confirmTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:confirmOrderNothingCellID];
    }
    return _confirmTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.orderCreatResultModel.goods_list.count > 0) {
        return self.orderCreatResultModel.goods_list.count +8;
    } return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (0 < section && section < self.orderCreatResultModel.goods_list.count +1) {
        ConfirmOrderCreatResultGoodsListModel *storeListModel = self.orderCreatResultModel.goods_list[section-1];
        return storeListModel.goods.count;
    } return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //地址
        return 90;
    } else if (0 < indexPath.section && indexPath.section < self.orderCreatResultModel.goods_list.count +1) {
        //商品
        return 110;
    } else if (indexPath.section == self.orderCreatResultModel.goods_list.count +1) {
        //商品总价+数量
        return 45;
    } else if (indexPath.section == self.orderCreatResultModel.goods_list.count +2) {
        //京东运费
        return 45;
    } else if (indexPath.section == self.orderCreatResultModel.goods_list.count +3) {
        //买家留言
        return 45;
    } else if (indexPath.section == self.orderCreatResultModel.goods_list.count +4) {
        //F 币抵扣
        if ([self.orderCreatResultModel.deductcredit2 floatValue] > 0) {
            return 45;
        } return CGFLOAT_MIN;
    } else if (indexPath.section == self.orderCreatResultModel.goods_list.count +5) {
        //可用优惠券
        if (self.orderCreatResultModel.couponcount > 0) {
            return 45;
        } return CGFLOAT_MIN;
    } else if (indexPath.section == self.orderCreatResultModel.goods_list.count +6) {
        //购物送话费、商品小计、运费、会员优惠
        return 160;
    } else {
        //优惠券优惠
        if (self.couponPriceModel) {
            return 40;
        } return CGFLOAT_MIN;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (0 < section && section < self.orderCreatResultModel.goods_list.count +1) {
        return 45;
    } return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (0 < section && section < self.orderCreatResultModel.goods_list.count +1) {
        ConfirmOrderStoreHeaderView *storeView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([ConfirmOrderStoreHeaderView class])];
        storeView.storeModel = self.orderCreatResultModel.goods_list[section-1];
        return storeView;
    } return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (0 < section && section < self.orderCreatResultModel.goods_list.count +1) {
        //商品
        return CGFLOAT_MIN;
    } else if (section == self.orderCreatResultModel.goods_list.count +4)  {
        //F币抵扣
         if ([self.orderCreatResultModel.deductcredit2 floatValue] > 0) {
             return 10;
         } return CGFLOAT_MIN;
    } else if (section == self.orderCreatResultModel.goods_list.count +5) {
        //可用优惠券
        if (self.orderCreatResultModel.couponcount > 0) {
            return 10;
        } return CGFLOAT_MIN;
    } else if (section == self.orderCreatResultModel.goods_list.count +6) {
        //会员优惠
        return CGFLOAT_MIN;
    }
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        // 地址栏
        ConfirmOrderAddressCell *addressCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ConfirmOrderAddressCell class])];
        return addressCell;
    } else if (0 < indexPath.section && indexPath.section < self.orderCreatResultModel.goods_list.count +1) {
        // 商品
        ConfirmOrderGoodsCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ConfirmOrderGoodsCell class])];
        return goodsCell;
    } else if (indexPath.section == self.orderCreatResultModel.goods_list.count +1) {
        //商品总价+数量
        ConfirmOrderTotalPriceCell *totalPriceCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ConfirmOrderTotalPriceCell class])];
        return totalPriceCell;
    } else if (indexPath.section == self.orderCreatResultModel.goods_list.count +2) {
        //京东运费
        ConfirmOrderJDFreightCell *freightCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ConfirmOrderJDFreightCell class])];
        return freightCell;
    } else if (indexPath.section == self.orderCreatResultModel.goods_list.count +3) {
        //买家留言
        ConfirmOrderRemarkCell *remarkCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ConfirmOrderRemarkCell class])];
        return remarkCell;
    } else if (indexPath.section == self.orderCreatResultModel.goods_list.count +4) {
        //F 币抵扣
        if ([self.orderCreatResultModel.deductcredit2 floatValue] > 0) {
            ConfirmOrderDeductCell *deductCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ConfirmOrderDeductCell class])];
            return deductCell;
        }
    } else if (indexPath.section == self.orderCreatResultModel.goods_list.count +5) {
        //可用优惠券
        if (self.orderCreatResultModel.couponcount > 0) {
            ConfirmOrderCouponCell *couponCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ConfirmOrderCouponCell class])];
            return couponCell;
        }
    } else if (indexPath.section == self.orderCreatResultModel.goods_list.count +6) {
        //各项价格明细
        ConfirmOrderDetailPriceCell *detailCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ConfirmOrderDetailPriceCell class])];
        return detailCell;
    } else if (indexPath.section == self.orderCreatResultModel.goods_list.count +7) {
        //优惠券优惠
        if (self.couponPriceModel) {
            ConfirmOrderCouponPriceCell *couponPriceCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ConfirmOrderCouponPriceCell class])];
            return couponPriceCell;
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:confirmOrderNothingCellID];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        // 地址栏
        ConfirmOrderAddressCell *addressCell = (ConfirmOrderAddressCell *)cell;
        addressCell.addressModel = self. addressModel;
    } else if (0 < indexPath.section && indexPath.section < self.orderCreatResultModel.goods_list.count +1) {
        // 商品
        ConfirmOrderGoodsCell *goodsCell = (ConfirmOrderGoodsCell *)cell;
        ConfirmOrderCreatResultGoodsListModel *storeListModel = self.orderCreatResultModel.goods_list[indexPath.section-1];
        goodsCell.goodsListModel = storeListModel.goods[indexPath.row];
    } else if (indexPath.section == self.orderCreatResultModel.goods_list.count +1) {
        //商品总价+数量
        ConfirmOrderTotalPriceCell *totalPriceCell = (ConfirmOrderTotalPriceCell *)cell;
        totalPriceCell.resultModel = self.orderCreatResultModel;
    } else if (indexPath.section == self.orderCreatResultModel.goods_list.count +2) {
        //京东运费
        ConfirmOrderJDFreightCell *freightCell = (ConfirmOrderJDFreightCell *)cell;
        freightCell.resultModel = self.orderCreatResultModel;
    } else if (indexPath.section == self.orderCreatResultModel.goods_list.count +3) {
        //买家留言
        ConfirmOrderRemarkCell *remarkCell = (ConfirmOrderRemarkCell *)cell;
        self.remarkTextField = remarkCell.remarkTextField;
    } else if (indexPath.section == self.orderCreatResultModel.goods_list.count +4) {
        //F 币抵扣
        if ([self.orderCreatResultModel.deductcredit2 floatValue] > 0) {
            ConfirmOrderDeductCell *deductCell = (ConfirmOrderDeductCell *)cell;
            deductCell.resultModel = self.orderCreatResultModel;
            MJWeakSelf
            deductCell.switchBlock = ^(UISwitch *sender) {
                weakSelf.deductPay = sender.on;
                [weakSelf caculateTotalPrice];
            };
        }
    } else if (indexPath.section == self.orderCreatResultModel.goods_list.count +5) {
        //可用优惠券
        if (self.orderCreatResultModel.couponcount > 0) {
            ConfirmOrderCouponCell *couponCell = (ConfirmOrderCouponCell *)cell;
            couponCell.resultModel = self.orderCreatResultModel;
        }
    } else if (indexPath.section == self.orderCreatResultModel.goods_list.count +6) {
        //各项价格明细
        ConfirmOrderDetailPriceCell *detailCell = (ConfirmOrderDetailPriceCell *)cell;
        detailCell.resultModel = self.orderCreatResultModel;
    } else if (indexPath.section == self.orderCreatResultModel.goods_list.count +7) {
        //优惠券优惠
        if (self.couponPriceModel) {
            ConfirmOrderCouponPriceCell *couponPriceCell = (ConfirmOrderCouponPriceCell *)cell;
            couponPriceCell.couponPriceModel = self.couponPriceModel;
        }
    }
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        //地址选择
        AddressSelectViewController *VC = [[AddressSelectViewController alloc] init];
        VC.selectAddressModel = self.addressModel;
        MJWeakSelf
        VC.addressSelectBlock = ^(AddressResultListModel *addressModel) {
            weakSelf.addressModel = addressModel;
            //选择地址成功再次请求
            [self creatOrderRequest];
        };
        [self.navigationController pushViewController:VC animated:YES];
    } else if (0 < indexPath.section && indexPath.section < self.orderCreatResultModel.goods_list.count +1) {
        //点击商品跳转
        ConfirmOrderCreatResultGoodsListModel *storeListModel = self.orderCreatResultModel.goods_list[indexPath.section-1];
        ConfirmOrderCreatResultGoodsListGoodsModel *goodsListModel = storeListModel.goods[indexPath.row];
        [DBHUD ShowInView:self.view withTitle:[NSString stringWithFormat:@"商品名：%@",goodsListModel.title]];
    } else if (indexPath.section == self.orderCreatResultModel.goods_list.count +5) {
        //可用优惠券
        if (self.orderCreatResultModel.couponcount > 0) {
            [self availableCouponRequest];
        }
    }
}

#pragma mark - 使 plain 样式的 tableView 的 sectionHeader 不吸附在顶端
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 45;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

#pragma mark - 立即支付按钮被点击
- (void)payButtonDidClicked {
    [self creatOrderSubmitRequest];
}


#pragma mark - 计算结算栏总价格
- (void)caculateTotalPrice {
    float totalPrice = 0;
    totalPrice = ((self.couponPriceModel?[self.couponPriceModel.totalprice floatValue]:[self.orderCreatResultModel.subtotalprice floatValue]) + [self.orderCreatResultModel.dispatch_price floatValue]) - ([self.orderCreatResultModel.discountprice floatValue]) - (_deductPay?[self.orderCreatResultModel.deductcredit2 floatValue]:0);
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"需付：%.2f",totalPrice]];
    [aString addAttributes:@{NSForegroundColorAttributeName:KRedColor} range:NSMakeRange(3, [NSString stringWithFormat:@"%.2f",totalPrice].length)];
    [self.bottomView.totalPriceLabel setAttributedText:aString];
}


#pragma mark - 订单创建提交请求
- (void)creatOrderSubmitRequest {
    NSMutableArray *goodsArray = [NSMutableArray array];
    for (ConfirmOrderCreatResultGoodsListModel *listModel in self.orderCreatResultModel.goods_list) {
        for (ConfirmOrderCreatResultGoodsListGoodsModel *goodsModel in listModel.goods) {
            NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
            [tempDic setObject:goodsModel.goodsid forKey:@"goodsid"];
            [tempDic setObject:goodsModel.total forKey:@"total"];
            [tempDic setObject:goodsModel.optionid forKey:@"optionid"];
            [goodsArray addObject:tempDic];
        }
    }
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:self.addressModel.addressID forKey:@"addressid"];
    if (self.selectCouponModel) {
        [paramDic setObject:self.selectCouponModel.couponID forKey:@"couponid"];
    }
    if (self.remarkTextField.text.length > 0) {
        [paramDic setObject:self.remarkTextField.text forKey:@"remarks"];
    }
    [paramDic setObject:@(self.deductPay) forKey:@"deduct2"];
    [paramDic setObject:goodsArray forKey:@"goods"];
    
    NSString *url = [NSString stringWithFormat:@"r=apply.order.create.submit&token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken]];
    NSString *path = [HBBaseAPI appendAPIurl:url];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBJSONNetWork sharedManager] requestWithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
                PayOrderViewController *VC = [[PayOrderViewController alloc] init];
                VC.orderID = responseDic[@"result"][@"orderid"];
                [self.navigationController pushViewController:VC animated:YES];

        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:@"订单提交失败"];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 可使用优惠券请求
- (void)availableCouponRequest {
    NSMutableArray *goodsArray = [NSMutableArray array];
    for (ConfirmOrderCreatResultGoodsListModel *listModel in self.orderCreatResultModel.goods_list) {
        for (ConfirmOrderCreatResultGoodsListGoodsModel *goodsModel in listModel.goods) {
            NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
            [tempDic setObject:goodsModel.goodsid forKey:@"goodsid"];
            [tempDic setObject:goodsModel.total forKey:@"total"];
            [tempDic setObject:goodsModel.optionid forKey:@"optionid"];
            [goodsArray addObject:tempDic];
        }
    }
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken] forKey:@"token"];
    NSDictionary *merchsDic = [self.orderCreatResultModel.merchs yy_modelToJSONObject];
    [paramDic setObject:merchsDic?merchsDic:@"" forKey:@"merchs"];
    [paramDic setObject:goodsArray forKey:@"goods"];
    
    NSString *url = @"r=sale.coupon.util.query";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            ConfirmOrderCouponResultModel *couponResultModel = [ConfirmOrderCouponResultModel yy_modelWithDictionary:responseDic[@"result"]];
            
            ConfirmOrderSelectCouponView *View = [[ConfirmOrderSelectCouponView alloc]init];
            View.couponResultModel = couponResultModel;
            MJWeakSelf
            View.couponSelectedBlock = ^(ConfirmOrderCouponResultListModel *couponModel) {
                weakSelf.selectCouponModel = couponModel;
                [weakSelf couponSelecedRequest:couponModel];
            };
            [View show];

        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}


#pragma mark - 选择优惠券请求
- (void)couponSelecedRequest:(ConfirmOrderCouponResultListModel *)couponModel {
    //商品
    NSMutableArray *goodsArray = [NSMutableArray array];
    for (ConfirmOrderCreatResultGoodsListModel *listModel in self.orderCreatResultModel.goods_list) {
        for (ConfirmOrderCreatResultGoodsListGoodsModel *goodsModel in listModel.goods) {
            NSMutableDictionary *goodsDic = [NSMutableDictionary dictionary];
            [goodsDic setObject:goodsModel.goodsid forKey:@"goodsid"];
            [goodsDic setObject:goodsModel.total forKey:@"total"];
            [goodsDic setObject:goodsModel.optionid forKey:@"optionid"];
            [goodsDic setObject:goodsModel.cates forKey:@"cates"];
            [goodsDic setObject:goodsModel.merchid forKey:@"merchid"];
            [goodsDic setObject:goodsModel.marketprice forKey:@"marketprice"];
            [goodsArray addObject:goodsDic];
        }
    }
    
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:goodsArray forKey:@"goods"];
    [paramDic setObject:couponModel.couponID?couponModel.couponID:@"" forKey:@"couponid"];
    [paramDic setObject:self.orderCreatResultModel.discountprice forKey:@"discountprice"];
    [paramDic setObject:self.orderCreatResultModel.subtotalprice forKey:@"goodsprice"];
    [paramDic setObject:[NSString stringWithFormat:@"2"] forKey:@"contype"];
    
    NSString *url = [NSString stringWithFormat:@"r=apply.order.create.getcouponprice&token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken]];
    NSString *path = [HBBaseAPI appendAPIurl:url];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBJSONNetWork sharedManager] requestWithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            self.couponPriceModel = [ConfirmOrderCouponPriceResultModel yy_modelWithDictionary:responseDic[@"result"]];
            [self creatOrderRequest];
        } else {
            [DBHUD ShowInView:self.view withTitle:@"优惠券不可用~"];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 订单创建请求
- (void)creatOrderRequest {
    NSString *url = @"r=apply.order.create";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken] forKey:@"token"];
    if (_goodsID) {
        [paramDic setObject:_goodsID forKey:@"id"];
    }
    if (_optionID) {
        [paramDic setObject:_optionID forKey:@"optionid"];
    }
    if (_goodsNum) {
        [paramDic setObject:_goodsNum forKey:@"total"];
    }
    if (self.addressModel) {
        [paramDic setObject:self.addressModel.addressID forKey:@"addressid"];
    }
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            self.orderCreatResultModel = [ConfirmOrderCreatResultModel yy_modelWithDictionary:responseDic[@"result"]];
            
            [self caculateTotalPrice];
            [self.confirmTableView reloadData];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 我的地址请求
- (void)myAddressListRequest {
    NSString *url = @"r=apply.member.address";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            AddressResultModel *addressResultModel = [AddressResultModel yy_modelWithDictionary:responseDic[@"result"]];
            for (AddressResultListModel *listModel in addressResultModel.list) {
                if (listModel.isdefault == 1) {
                    self.addressModel = listModel;
                    break;
                }
            }
            
            //创建订单请求
            [self creatOrderRequest];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

- (void)dealloc {
    NSLog(@"%s",__func__);
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
