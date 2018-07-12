//
//  ShopCartViewController.m
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ShopCartViewController.h"
#import "AccountView.h"
#import "CartCellHeaderView.h"
#import "ShoppingCartCell.h"
#import "ShoppingCartModel.h"

@interface ShopCartViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic , strong)UITableView *shopCartTableView;
@property(nonatomic , strong)AccountView *accountView;
@property(nonatomic , strong)UIButton *editButton;
@property(nonatomic , strong)ShoppingCartModel *dataModel;

@end

@implementation ShopCartViewController

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
    self.edgesForExtendedLayout = UIRectEdgeNone;
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
        _accountView = [[AccountView alloc]initWithFrame:CGRectMake(0, KMAINSIZE.height-KNaviHeight-KTabbarHeight-50, KMAINSIZE.width, 50)];
        MJWeakSelf
        _accountView.accountViewBlock = ^(NSInteger index) {
            [weakSelf accountViewButtonDidClick:index];
        };
    }
    return _accountView;
}

- (UITableView *)shopCartTableView {
    if (!_shopCartTableView) {
        _shopCartTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KTabbarHeight-50) style:UITableViewStylePlain];
        _shopCartTableView.delegate = self;
        _shopCartTableView.dataSource = self;
        _shopCartTableView.showsVerticalScrollIndicator = NO;
        _shopCartTableView.backgroundColor = KTableBackgroundColor;
        _shopCartTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _shopCartTableView.separatorColor = KUIColorFromHex(0xeeeeee);
    }
    return _shopCartTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataModel.info.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ShoppingCartStoreModel *storeModel = self.dataModel.info[section];
    return storeModel.goods.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 118;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CartCellHeaderView *sectionHeaderView = [[CartCellHeaderView alloc]init];
    sectionHeaderView.clickBlock = ^(ShoppingCartStoreModel *storeModel) {
        [self sectionHeaderSelectButtonDidClickd:storeModel];
    };
    sectionHeaderView.storeModel = self.dataModel.info[section];
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
        //选中按钮的 block
        cartCell.selectClickBlock = ^(ShoppingCartGoodsModel *goodsModel) {
            [self cartCellSelectButtonDidClickd:goodsModel];
        };
        //
        cartCell.minsBtnClickBlock = ^(ShoppingCartGoodsModel *goodsModel) {
            [self calculateSelectedGoodsPrice];
        };
        //
        cartCell.plusBtnClickBlock = ^(ShoppingCartGoodsModel *goodsModel) {
            [self calculateSelectedGoodsPrice];
        };
    }
    ShoppingCartStoreModel *storeModel = self.dataModel.info[indexPath.section];
    cartCell.cartGoodsModel = storeModel.goods[indexPath.row];
    return cartCell;
}


#pragma mark - 编辑状态
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.dataModel.info.count>0) {
        return YES;
    } else {
        return NO;
    }
}

- (NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //删除按钮
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [self deleteRowActionDidClicked:indexPath];
    }];
    [deleteRowAction setBackgroundColor:KUIColorFromHex(0xff5753)];
    return @[deleteRowAction];
}

#pragma mark - 删除按钮被点击
- (void)deleteRowActionDidClicked:(NSIndexPath *)indexPath {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除?删除后无法恢复!" preferredStyle:1];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        ShoppingCartStoreModel *storeModel = self.dataModel.info[indexPath.section];
        ShoppingCartGoodsModel *goodsModel = storeModel.goods[indexPath.row];
        
        [storeModel.goods removeObject:goodsModel];
        if (storeModel.goods.count < 1) {
            [self.dataModel.info removeObject:storeModel];
        }
        
//        [self.shopCartTableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationNone];
        [self.shopCartTableView reloadData];
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:okAction];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 底部按钮被点击
- (void)accountViewButtonDidClick:(NSInteger )index {
    switch (index) {
        case 0:
        {
            if (self.accountView.allSelectButton.selected == NO) {
                for (ShoppingCartStoreModel *storeModel in self.dataModel.info) {
                    storeModel.storeSelected = YES;
                    for (ShoppingCartGoodsModel *goodsModel in storeModel.goods) {
                        goodsModel.goodsSelected = YES;
                    }
                }
            } else {
                for (ShoppingCartStoreModel *storeModel in self.dataModel.info) {
                    storeModel.storeSelected = NO;
                    for (ShoppingCartGoodsModel *goodsModel in storeModel.goods) {
                        goodsModel.goodsSelected = NO;
                    }
                }
            }
            
            [self.shopCartTableView reloadData];
            [self calculateSelectedGoodsPrice];
        }
            break;
        case 1:
        {
            [DBHUD ShowInView:self.view withTitle:@"结算"];
        }
            break;
        case 2:
        {
            [DBHUD ShowInView:self.view withTitle:@"收藏按钮"];
        }
            break;
        case 3:
        {
            [DBHUD ShowInView:self.view withTitle:@"删除按钮"];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 结算并生成已选中的商品字典
- (void)CalculatePriceAndRetureSelectedGoods {
    
}

#pragma mark - 结算选中商品的价格及数量
- (void)calculateSelectedGoodsPrice {
    //所有商品的总价
    CGFloat allPrice = 0.0;
    //结算处的个数
    NSInteger allNumber = 0;
    /*遍历所有模型*/
    for (ShoppingCartStoreModel *storeModel in self.dataModel.info) {
        for (ShoppingCartGoodsModel *seleModel in storeModel.goods) {
            if (seleModel.goodsSelected==YES) {
                allPrice = allPrice + [seleModel.goods_price floatValue]*seleModel.goods_num;
                allNumber = allNumber + seleModel.goods_num;
            }
        }
    }
    
    
    [self.accountView.totalPriceLabel setText:[NSString stringWithFormat:@"合计：¥%.2f",allPrice]];
    [self.accountView.accountButton setTitle:[NSString stringWithFormat:@"结算(%ld)",(long)allNumber] forState:UIControlStateNormal];
}

#pragma mark - cell 上的选中按钮被点击
- (void)cartCellSelectButtonDidClickd:(ShoppingCartGoodsModel *)goodsModel {
    NSInteger i = 0;
    ShoppingCartStoreModel *storeSelectModel;
    for (ShoppingCartStoreModel *storeModel in self.dataModel.info) {
        for (ShoppingCartGoodsModel *tmpGoodsModel in storeModel.goods) {
            if (tmpGoodsModel.goodsSelected==NO) {
                storeModel.storeSelected = NO;
            } else {
                i++;
            }
            
            if (tmpGoodsModel==goodsModel) {
                storeSelectModel = storeModel;
            }
        }
    }
    
    //    NSLog(@"%@",storeSelectModel.store_id);
    
    if (i==storeSelectModel.goods.count) {
        storeSelectModel.storeSelected = YES;
    }
    
    [self calculateSelectedGoodsPrice];
    [self.shopCartTableView reloadData];
}

#pragma mark - sectionHeader 上的选中按钮被点击
- (void)sectionHeaderSelectButtonDidClickd:(ShoppingCartStoreModel *)storeModel {
    for (ShoppingCartGoodsModel *goodsModel in storeModel.goods) {
        if (storeModel.storeSelected==NO) {
            goodsModel.goodsSelected = NO;
        } else {
            goodsModel.goodsSelected = YES;
        }
    }
    [self calculateSelectedGoodsPrice];
    [self.shopCartTableView reloadData];
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
        _editButton.frame = CGRectMake(KMAINSIZE.width-44, 0, 44, 44);
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_editButton setTitle:@"完成" forState:UIControlStateSelected];
        [_editButton setTitleColor:KUIColorFromHex(0x333333) forState:UIControlStateNormal];
        [_editButton.titleLabel setFont:KFont(16)];
        [_editButton setShowsTouchWhenHighlighted:YES];
        [_editButton addTarget:self action:@selector(editButtonDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _editButton;
}

#pragma mark - 获取购物车数据
- (void)getShoppingCarDataRequest {
    
    NSDictionary *dataDic = @{
                              @"info":@[
                                      @{
                                          @"store_name":@"喵咪喵",
                                          @"goods":@[@{@"goods_name":@"深海胶原套装深层补水保湿滋润控油爽肤水乳",
                                                       @"goods_num":@"1",
                                                       @"goods_price":@"100.0"},
                                                     @{@"goods_name":@"大宝 SOD 蜜深层补水保湿滋润控油爽肤水乳",
                                                       @"goods_num":@"2",
                                                       @"goods_price":@"299.0"}],
                                          @"store_id":@"001"
                                          },
                                      @{
                                          @"store_name":@"汪汪汪",
                                          @"goods":@[@{@"goods_name":@"欧米茄 女士自动机械表",
                                                       @"goods_num":@"2",
                                                       @"goods_price":@"2100.0"}],
                                          @"store_id":@"002"
                                          },
                                      @{
                                          @"store_name":@"艾夫杰尼",
                                          @"goods":@[@{@"goods_name":@"复古港风文艺韩国格纹长裤大长腿格子休闲裤直筒裤潮",
                                                       @"goods_num":@"1",
                                                       @"goods_price":@"134.0"},
                                                     @{@"goods_name":@"大宝 SOD 英国进口迪斯科茶棒红茶袋泡茶棒柠檬茶",
                                                       @"goods_num":@"1",
                                                       @"goods_price":@"256.0"}],
                                          @"store_id":@"003"
                                          },
                                      @{
                                          @"store_name":@"葬爱家族",
                                          @"goods":@[@{@"goods_name":@"新款军事风嘻哈收脚迷彩束脚裤长裤纯色休闲裤潮男布裤",
                                                       @"goods_num":@"1",
                                                       @"goods_price":@"125.0"},
                                                     @{@"goods_name":@"高街纯色打底圆弧下摆加长款短袖半袖中袖暗黑",
                                                       @"goods_num":@"1",
                                                       @"goods_price":@"449.0"},
                                                     @{@"goods_name":@"隐形眼镜月抛近视6片海昌旗舰官方店2盒半年量",
                                                       @"goods_num":@"1",
                                                       @"goods_price":@"199.0"}],
                                          @"store_id":@"004"
                                          },
                                      @{
                                          @"store_name":@"蛋堡宝宝",
                                          @"goods":@[@{@"goods_name":@"复古潮牌卡通漫画中国有嘻哈恶搞搞笑说唱男女半袖中袖短袖",
                                                       @"goods_num":@"1",
                                                       @"goods_price":@"650.0"},
                                                     @{@"goods_name":@"原创街头嘻哈街舞复古拼色白边运动裤潮男女束脚休闲裤小脚裤",
                                                       @"goods_num":@"1",
                                                       @"goods_price":@"239.0"}],
                                          @"store_id":@"005"
                                          }
                                      ]
                              };
    
    //    NSLog(@"购物车商品：%@",dataDic/*[@"info"][1][@"goods"][0][@"goods_price"]*/);
    self.dataModel = [ShoppingCartModel yy_modelWithDictionary:dataDic];
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
