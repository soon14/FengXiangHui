//
//  ShopCartSubViewController.m
//  FengXH
//
//  Created by sun on 2018/9/29.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "ShopCartSubViewController.h"
#import "AccountView.h"
#import "CartCellHeaderView.h"
#import "ShoppingCartCell.h"
#import "ShoppingCartResultModel.h"
#import "ConfirmOrderViewController.h"
#import "GoodsDetailViewController.h"
@interface ShopCartSubViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic , strong)UITableView *shopCartTableView;
/** 底部结算 */
@property(nonatomic , strong)AccountView *accountView;
/** 导航栏右编辑按钮 */
@property(nonatomic , strong)UIButton *editButton;
/** 分组完的购物车商品数组 */
@property(nonatomic , strong)NSArray *cartGoodsArray;

@end

@implementation ShopCartSubViewController



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //设置导航栏右边按钮
    [self.navigationController.navigationBar addSubview:self.editButton];
    
    //获取购物车数据
    [self getShoppingCarDataRequest];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.editButton) {
        [self.editButton removeFromSuperview];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = KTableBackgroundColor;
    self.title = @"购物车";
    //底部结算栏
    [self.view addSubview:self.accountView];
    //
    [self.view addSubview:self.shopCartTableView];
    
}

#pragma mark - 底部结算栏
- (AccountView *)accountView {
    if (!_accountView) {
        _accountView = [[AccountView alloc]initWithFrame:CGRectMake(0, KMAINSIZE.height-KNaviHeight-KBottomHeight-50, KMAINSIZE.width, 50+KBottomHeight)];
        MJWeakSelf
        _accountView.accountViewBlock = ^(UIButton *sender) {
            [weakSelf accountViewButtonDidClick:sender];
        };
    }
    return _accountView;
}

- (UITableView *)shopCartTableView {
    if (!_shopCartTableView) {
        _shopCartTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight-50) style:UITableViewStylePlain];
        _shopCartTableView.delegate = self;
        _shopCartTableView.dataSource = self;
        _shopCartTableView.showsVerticalScrollIndicator = NO;
        _shopCartTableView.backgroundColor = KTableBackgroundColor;
        _shopCartTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _shopCartTableView.separatorColor = KLineColor;
        _shopCartTableView.estimatedRowHeight = 0;
        _shopCartTableView.estimatedSectionHeaderHeight = 0;
        _shopCartTableView.estimatedSectionFooterHeight = 0;
        _shopCartTableView.tableFooterView = [[UIView alloc] init];
        [_shopCartTableView registerClass:[CartCellHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([CartCellHeaderView class])];
        _shopCartTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    }
    return _shopCartTableView;
}

#pragma mark - 刷新
- (void)refresh {
    [self getShoppingCarDataRequest];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cartGoodsArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.cartGoodsArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 118;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CartCellHeaderView *sectionHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([CartCellHeaderView class])];
    MJWeakSelf
    sectionHeaderView.clickBlock = ^(NSString *selectIdsString, BOOL selected) {
        [weakSelf shoppingCartGoodsSelectWithIdsString:selectIdsString Selected:selected];
    };
    sectionHeaderView.storeArray = self.cartGoodsArray[section];
    return sectionHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ShoppingCartCell *cartCell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingCartCellID"];
    if (!cartCell) {
        cartCell = [[ShoppingCartCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShoppingCartCellID"];
        MJWeakSelf
        //选中按钮的 block
        cartCell.selectClickBlock = ^(NSString *selectIdsString, BOOL selected) {
            [weakSelf shoppingCartGoodsSelectWithIdsString:selectIdsString Selected:selected];
        };
        //商品减少操作
        cartCell.minsBtnClickBlock = ^(ShoppingCartResultListModel *goodsModel, NSInteger goodsNumber) {
            [weakSelf shoppingCartGoodsUpdateWithListModel:goodsModel GoodsNumber:goodsNumber];
        };
        //商品增加操作
        cartCell.plusBtnClickBlock = ^(ShoppingCartResultListModel *goodsModel, NSInteger goodsNumber) {
            [weakSelf shoppingCartGoodsUpdateWithListModel:goodsModel GoodsNumber:goodsNumber];
        };
        //商品数量编辑完成操作
        cartCell.endEditNumberBlock = ^(ShoppingCartResultListModel *goodsModel, NSInteger goodsNumber) {
            [weakSelf shoppingCartGoodsUpdateWithListModel:goodsModel GoodsNumber:goodsNumber];
        };
        //友情提示 block
        cartCell.alertBlock = ^(NSString *message) {
            [DBHUD ShowInView:weakSelf.view withTitle:message];
        };
    }
    cartCell.cartGoodsModel = self.cartGoodsArray[indexPath.section][indexPath.row];
    return cartCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cartGoodsArray.count > 0) {
        ShoppingCartResultListModel *listModel = self.cartGoodsArray[indexPath.section][indexPath.row];
        GoodsDetailViewController *VC = [[GoodsDetailViewController alloc]init];
        VC.hidesBottomBarWhenPushed = YES;
        VC.goodsID = listModel.goodsid;
        [self.navigationController pushViewController:VC animated:YES];
    }
}

#pragma mark - 编辑状态
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.cartGoodsArray.count>0) {
        return YES;
    } else {
        return NO;
    }
}

- (NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    MJWeakSelf
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        ShoppingCartResultListModel *listModel = weakSelf.cartGoodsArray[indexPath.section][indexPath.row];
        [weakSelf shoppingCartGoodsDeleteWithIdsString:listModel.cart_id];
    }];
    UITableViewRowAction *focusRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"移到关注" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        ShoppingCartResultListModel *listModel = weakSelf.cartGoodsArray[indexPath.section][indexPath.row];
        [weakSelf shoppingCartGoodsFocusWithIdsString:listModel.cart_id];
    }];
    [focusRowAction setBackgroundColor:KUIColorFromHex(0x999999)];
    [deleteRowAction setBackgroundColor:KUIColorFromHex(0xff5753)];
    return @[deleteRowAction,focusRowAction];
}

#pragma mark - 底部按钮被点击
- (void)accountViewButtonDidClick:(UIButton *)sender {
    switch (sender.tag) {
        case 0: {
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSArray *arr in self.cartGoodsArray) {
                [tempArray addObjectsFromArray:arr];
            }
            NSMutableString *idsString = [NSMutableString string];
            for (ShoppingCartResultListModel *listModel in tempArray) {
                [idsString appendString:[NSString stringWithFormat:@",%@",listModel.cart_id]];
            }
            if (idsString.length > 0) {
                [idsString deleteCharactersInRange:NSMakeRange(0, 1)];
                [self shoppingCartGoodsSelectWithIdsString:idsString Selected:sender.selected];
            } else {
                [DBHUD ShowInView:self.view withTitle:@"请选择商品"];
            }
        } break;
        case 1: {
            //结算
            [self shoppingCartGoodsAccountRequest];
        } break;
        case 2: {
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSArray *arr in self.cartGoodsArray) {
                [tempArray addObjectsFromArray:arr];
            }
            NSMutableString *idsString = [NSMutableString string];
            for (ShoppingCartResultListModel *listModel in tempArray) {
                if (listModel.selected) {
                    [idsString appendString:[NSString stringWithFormat:@",%@",listModel.cart_id]];
                }
            }
            if (idsString.length > 0) {
                [idsString deleteCharactersInRange:NSMakeRange(0, 1)];
                [self shoppingCartGoodsFocusWithIdsString:idsString];
            } else {
                [DBHUD ShowInView:self.view withTitle:@"请选择商品"];
            }
        } break;
        case 3: {
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSArray *arr in self.cartGoodsArray) {
                [tempArray addObjectsFromArray:arr];
            }
            NSMutableString *idsString = [NSMutableString string];
            for (ShoppingCartResultListModel *listModel in tempArray) {
                if (listModel.selected) {
                    [idsString appendString:[NSString stringWithFormat:@",%@",listModel.cart_id]];
                }
            }
            if (idsString.length > 0) {
                [idsString deleteCharactersInRange:NSMakeRange(0, 1)];
                [self shoppingCartGoodsDeleteWithIdsString:idsString];
            } else {
                [DBHUD ShowInView:self.view withTitle:@"请选择商品"];
            }
        } break;
            
        default:
            break;
    }
}

#pragma mark - 导航栏右编辑按钮被点击
- (void)editButtonDidClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.accountView.collectButton.hidden = !sender.selected;
    self.accountView.deleteButton.hidden = !sender.selected;
    self.accountView.totalPriceLabel.hidden = sender.selected;
    self.accountView.accountButton.hidden = sender.selected;
}

#pragma mark - 使 plain 样式的 tableView 的 sectionHeader 不吸附在顶端
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 40;
    if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
}

#pragma mark - 编辑按钮
- (UIButton *)editButton {
    if (!_editButton) {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _editButton.frame = CGRectMake(KMAINSIZE.width-50, 0, 44, 44);
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_editButton setTitle:@"完成" forState:UIControlStateSelected];
        [_editButton setTitleColor:KUIColorFromHex(0x333333) forState:UIControlStateNormal];
        [_editButton.titleLabel setFont:KFont(16)];
        [_editButton setShowsTouchWhenHighlighted:YES];
        [_editButton addTarget:self action:@selector(editButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editButton;
}


#pragma mark - 购物车商品结算
- (void)shoppingCartGoodsAccountRequest {
    NSString *url = @"r=apply.cart.submit";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            //确认下单
            ConfirmOrderViewController *VC = [[ConfirmOrderViewController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 商品移到关注网络请求
- (void)shoppingCartGoodsFocusWithIdsString:(NSString *)idsString {
    NSString *url = @"r=apply.cart.tofavorite";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken] forKey:@"token"];
    if (idsString) {
        [paramDic setObject:idsString forKey:@"ids"];
    }
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            [self getShoppingCarDataRequest];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 删除商品网络请求
- (void)shoppingCartGoodsDeleteWithIdsString:(NSString *)idsString {
    NSString *url = @"r=apply.cart.remove";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSMutableDictionary *paramDic = [NSMutableDictionary dictionary];
    [paramDic setObject:[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken] forKey:@"token"];
    if (idsString) {
        [paramDic setObject:idsString forKey:@"ids"];
    }
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            [self getShoppingCarDataRequest];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 购物车商品选择请求
- (void)shoppingCartGoodsSelectWithIdsString:(NSString *)idsString Selected:(BOOL)selected {
    NSString *url = @"r=apply.cart.select";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              selected ? @"0" : @"1",@"select",
                              idsString,@"ids", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            [self getShoppingCarDataRequest];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 购物车商品数量修改请求
- (void)shoppingCartGoodsUpdateWithListModel:(ShoppingCartResultListModel *)listModel GoodsNumber:(NSInteger)goodsNumber {
    NSString *url = @"r=apply.cart.update";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              listModel.cart_id,@"id",
                              [NSString stringWithFormat:@"%ld",(long)goodsNumber],@"total",
                              listModel.optionid,@"optionid", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            [self getShoppingCarDataRequest];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 获取购物车数据
- (void)getShoppingCarDataRequest {
    NSString *url = @"r=apply.cart.get_list";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token", nil];
    //    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if (self.shopCartTableView.mj_header.isRefreshing == YES) {
            [self.shopCartTableView.mj_header endRefreshing];
        }
        if ([responseDic[@"status"] integerValue] == 1) {
            //进行分店铺归类
            ShoppingCartResultModel *resultModel = [ShoppingCartResultModel yy_modelWithDictionary:responseDic[@"result"]];
            self.cartGoodsArray = [self getGoodsArrayWithStroeName:resultModel.list];
            [self.accountView.totalPriceLabel setText:[NSString stringWithFormat:@"合计：¥%.2f",[resultModel.totalprice floatValue]]];
            [self.accountView.accountButton setTitle:[NSString stringWithFormat:@"结算(%ld)",(long)resultModel.total] forState:UIControlStateNormal];
            [self.accountView.allSelectButton setSelected:resultModel.ischeckall];
            
            [self.shopCartTableView reloadData];
        } else if ([responseDic[@"status"] integerValue] == 401) {
            [self presentLoginViewControllerWithSuccessBlock:^{
                [self getShoppingCarDataRequest];
            } WithFailureBlock:^{
            }];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        if (self.shopCartTableView.mj_header.isRefreshing == YES) {
            [self.shopCartTableView.mj_header endRefreshing];
        }
    }];
}

#pragma mark - 传入请求得到的数组，重新生成
- (NSArray *)getGoodsArrayWithStroeName:(NSArray *)goodsList {
    NSMutableArray *returnGoodsArray = [NSMutableArray array];
    //取出所有不重复的店名
    NSMutableSet *storeNameSet = [NSMutableSet set];
    for (ShoppingCartResultListModel *listModel in goodsList) {
        [storeNameSet addObject:listModel.merchid];
    }
    NSArray *tmpStoreIDArray = [storeNameSet allObjects];
    NSArray *storeIDArray = [tmpStoreIDArray sortedArrayUsingSelector:@selector(compare:)];
    //NSLog(@"storeIDArray:%@",storeIDArray);
    
    for (NSString *obj in storeIDArray) {
        NSMutableArray *storeArray = [NSMutableArray array];
        for (ShoppingCartResultListModel *listModel in goodsList) {
            if ([obj isEqualToString:listModel.merchid]) {
                [storeArray addObject:listModel];
            }
        }
        [returnGoodsArray addObject:storeArray];
    }
    return returnGoodsArray;
}

- (void)dealloc {
    NSLog(@"%s",__func__);
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
