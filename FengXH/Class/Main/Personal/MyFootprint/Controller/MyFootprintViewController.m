//
//  MyFootprintViewController.m
//  FengXH
//
//  Created by sun on 2018/8/6.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MyFootprintViewController.h"
#import "MyFootprintBottomView.h"
#import "MyFootprintCell.h"
#import "MyFootprintResultModel.h"

@interface MyFootprintViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger requestPage;
    BOOL editingStatus;
    NSMutableArray *footprintListArray;
}
/** 导航栏右编辑按钮 */
@property(nonatomic , strong)UIButton *editButton;
/** tableView */
@property(nonatomic , strong)UITableView *footTableView;
/** bottomView */
@property(nonatomic , strong)MyFootprintBottomView *bottomView;

@end

@implementation MyFootprintViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //设置导航栏右边按钮
    [self.navigationController.navigationBar addSubview:self.editButton];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (self.editButton) {
        [self.editButton removeFromSuperview];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的足迹";
    self.view.backgroundColor = [UIColor whiteColor];
    
    footprintListArray = [NSMutableArray array];
    editingStatus = NO;
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.footTableView];
    
    requestPage = 1;
    [self myFootprintListRequest:requestPage];
}


- (MyFootprintBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[MyFootprintBottomView alloc]initWithFrame:CGRectMake(0, KMAINSIZE.height-KNaviHeight-KBottomHeight-50, KMAINSIZE.width, 50)];
        [_bottomView setHidden:YES];
        MJWeakSelf
        _bottomView.buttonClickBlock = ^(UIButton *sender) {
            [weakSelf bottomButtonClicked:sender];
        };
    }
    return _bottomView;
}

#pragma mark - tableView
- (UITableView *)footTableView {
    if (!_footTableView) {
        _footTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight) style:UITableViewStylePlain];
        _footTableView.separatorColor = KLineColor;
        _footTableView.backgroundColor = KTableBackgroundColor;
        _footTableView.showsVerticalScrollIndicator = NO;
        _footTableView.dataSource = self;
        _footTableView.delegate = self;
        _footTableView.estimatedRowHeight = 0;
        _footTableView.estimatedSectionHeaderHeight = 0;
        _footTableView.estimatedSectionFooterHeight = 0;
        _footTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        _footTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    }
    return _footTableView;
}

#pragma mark - 下拉刷新
- (void)refresh {
    if (!_footTableView.mj_footer.isRefreshing) {
        requestPage = 1;
        [self myFootprintListRequest:requestPage];
    }
}

#pragma mark - 上拉加载
- (void)loadmore {
    if(!_footTableView.mj_header.isRefreshing){
        requestPage ++;
        [self myFootprintListRequest:requestPage];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return footprintListArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyFootprintCell *footprintCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyFootprintCell class])];
    if (!footprintCell) {
        footprintCell = [[MyFootprintCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([MyFootprintCell class])];
    }
    if (footprintListArray.count > 0) {
        footprintCell.footprintModel = footprintListArray[indexPath.section];
    }
    footprintCell.editingStatus = editingStatus;
    return footprintCell;
}

#pragma mark - 编辑状态
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (footprintListArray.count > 0) {
        return YES;
    } else {
        return NO;
    }
}

- (NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSMutableArray *selectedArray = [NSMutableArray array];
        MyFootprintResultListModel *listModel = footprintListArray[indexPath.section];
        [selectedArray addObject:listModel];
        [self removeMyFootprintRequest:selectedArray];
    }];
    
    [deleteRowAction setBackgroundColor:KRedColor];
    return @[deleteRowAction];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyFootprintResultListModel *listModel = footprintListArray[indexPath.section];
    [DBHUD ShowInView:self.view withTitle:[NSString stringWithFormat:@"商品 id：%@",listModel.goodsid]];
}


#pragma mark - 底部按钮被点击
- (void)bottomButtonClicked:(UIButton *)sender {
    switch (sender.tag) {
        case 0: {//全选
            sender.selected = !sender.selected;
            if (!sender.selected) {
                for (MyFootprintResultListModel *listModel in footprintListArray) {
                    listModel.selected = NO;
                }
                [self.footTableView reloadData];
            } else {
                for (MyFootprintResultListModel *listModel in footprintListArray) {
                    listModel.selected = YES;
                }
                [self.footTableView reloadData];
            }
        } break;
        case 1: {//删除选中的
            NSMutableArray *selectedArray = [NSMutableArray array];
            for (MyFootprintResultListModel *listModel in footprintListArray) {
                if (listModel.selected) {
                    [selectedArray addObject:listModel];
                }
            }
            [self removeMyFootprintRequest:selectedArray];
        } break;
            
        default:
            break;
    }
}

#pragma mark - 导航栏右编辑按钮被点击
- (void)editButtonDidClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    editingStatus = sender.selected;
    if (!editingStatus) {
        [self.bottomView setHidden:YES];
        [self.footTableView setFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight)];
    } else {
        [self.bottomView setHidden:NO];
        [self.footTableView setFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight-50)];
    }
    [self.footTableView reloadData];
}


#pragma mark - 清除足迹请求
- (void)removeMyFootprintRequest:(NSArray *)goodsArray {
    NSMutableString *idsString = [NSMutableString string];
    for (MyFootprintResultListModel *listModel in goodsArray) {
        [idsString appendString:[NSString stringWithFormat:@",%@",listModel.footprintID]];
    }
    [idsString deleteCharactersInRange:NSMakeRange(0, 1)];
    
    NSString *url = @"r=apply.history.remove";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              idsString,@"ids", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            [footprintListArray removeObjectsInArray:goodsArray];
            
            [self.footTableView reloadData];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}

#pragma mark - 我的足迹列表请求
- (void)myFootprintListRequest:(NSInteger)page {
    NSString *url = @"r=apply.history.get_list";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              [NSString stringWithFormat:@"%ld",(long)page],@"page", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {

            if (page == 1) {
                [footprintListArray removeAllObjects];
            }
            [self.footTableView.mj_header endRefreshing];
            [self.footTableView.mj_footer endRefreshing];
            if ([responseDic[@"status"] integerValue] == 1) {
                
                MyFootprintResultModel *resultModel = [MyFootprintResultModel yy_modelWithDictionary:responseDic[@"result"]];
                [footprintListArray addObjectsFromArray:resultModel.list];
                
                if ([resultModel.list count] < KPageSize) {
                    [self.footTableView.mj_footer endRefreshingWithNoMoreData];
                }
            }
            
            [self.footTableView reloadData];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        if (self.footTableView.mj_header.isRefreshing == YES) {
            [self.footTableView.mj_header endRefreshing];
        }
        if ([self.footTableView.mj_footer isRefreshing] == YES) {
            requestPage --;
            [self.footTableView.mj_footer endRefreshing];
        }
    }];
    
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
