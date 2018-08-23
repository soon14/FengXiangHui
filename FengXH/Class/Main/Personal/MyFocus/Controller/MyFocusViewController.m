//
//  MyFocusViewController.m
//  FengXH
//
//  Created by sun on 2018/8/6.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MyFocusViewController.h"
#import "MyFocusCell.h"
#import "MyFocusBottomView.h"
#import "MyFocusResultModel.h"

@interface MyFocusViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger requestPage;
    BOOL editingStatus;
    NSMutableArray *focusListArray;
}
/** 导航栏右编辑按钮 */
@property(nonatomic , strong)UIButton *editButton;
/** tableView */
@property(nonatomic , strong)UITableView *focusTableView;
/** bottomView */
@property(nonatomic , strong)MyFocusBottomView *bottomView;
@end

@implementation MyFocusViewController

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
    self.title = @"我的关注";
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    focusListArray = [NSMutableArray array];
    editingStatus = NO;
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.focusTableView];
    
    requestPage = 1;
    [self myFocusListRequest:requestPage];
}

- (MyFocusBottomView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[MyFocusBottomView alloc]initWithFrame:CGRectMake(0, KMAINSIZE.height-KNaviHeight-KBottomHeight-50, KMAINSIZE.width, 50)];
        [_bottomView setHidden:YES];
        MJWeakSelf
        _bottomView.buttonClickBlock = ^(UIButton *sender) {
            [weakSelf bottomButtonClicked:sender];
        };
    }
    return _bottomView;
}

#pragma mark - tableView
- (UITableView *)focusTableView {
    if (!_focusTableView) {
        _focusTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight) style:UITableViewStylePlain];
        _focusTableView.separatorColor = KLineColor;
        _focusTableView.backgroundColor = KTableBackgroundColor;
        _focusTableView.showsVerticalScrollIndicator = NO;
        _focusTableView.dataSource = self;
        _focusTableView.delegate = self;
        _focusTableView.estimatedRowHeight = 0;
        _focusTableView.estimatedSectionHeaderHeight = 0;
        _focusTableView.estimatedSectionFooterHeight = 0;
        _focusTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        _focusTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    }
    return _focusTableView;
}

#pragma mark - 下拉刷新
- (void)refresh {
    if (!_focusTableView.mj_footer.isRefreshing) {
        requestPage = 1;
        [self myFocusListRequest:requestPage];
    }
}

#pragma mark - 上拉加载
- (void)loadmore {
    if(!_focusTableView.mj_header.isRefreshing){
        requestPage ++;
        [self myFocusListRequest:requestPage];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return focusListArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
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
    MyFocusCell *focusCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MyFocusCell class])];
    if (!focusCell) {
        focusCell = [[MyFocusCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([MyFocusCell class])];
    }
    if (focusListArray.count > 0) {
        focusCell.focusResultListModel = focusListArray[indexPath.row];
    }
    focusCell.editingStatus = editingStatus;
    return focusCell;
}

#pragma mark - 编辑状态
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (focusListArray.count > 0) {
        return YES;
    } else {
        return NO;
    }
}

- (NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSMutableArray *selectedArray = [NSMutableArray array];
        MyFocusResultListModel *listModel = focusListArray[indexPath.row];
        [selectedArray addObject:listModel];
        [self removeMyFocusGoodsRequest:selectedArray];
    }];

    [deleteRowAction setBackgroundColor:KRedColor];
    return @[deleteRowAction];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyFocusResultListModel *listModel = focusListArray[indexPath.row];
    [DBHUD ShowInView:self.view withTitle:[NSString stringWithFormat:@"商品 id：%@",listModel.goodsid]];
}




#pragma mark - 底部按钮被点击
- (void)bottomButtonClicked:(UIButton *)sender {
    switch (sender.tag) {
        case 0: {//全选
            sender.selected = !sender.selected;
            if (!sender.selected) {
                for (MyFocusResultListModel *listModel in focusListArray) {
                    listModel.selected = NO;
                }
                [self.focusTableView reloadData];
            } else {
                for (MyFocusResultListModel *listModel in focusListArray) {
                    listModel.selected = YES;
                }
                [self.focusTableView reloadData];
            }
        } break;
        case 1: {//删除选中的
            NSMutableArray *selectedArray = [NSMutableArray array];
            for (MyFocusResultListModel *listModel in focusListArray) {
                if (listModel.selected) {
                    [selectedArray addObject:listModel];
                }
            }
            [self removeMyFocusGoodsRequest:selectedArray];
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
        [self.focusTableView setFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight)];
    } else {
        [self.bottomView setHidden:NO];
        [self.focusTableView setFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight-50)];
    }
    [self.focusTableView reloadData];
}

#pragma mark - 删除我的关注
- (void)removeMyFocusGoodsRequest:(NSArray *)goodsArray {
    NSMutableString *idsString = [NSMutableString string];
    for (MyFocusResultListModel *listModel in goodsArray) {
        [idsString appendString:[NSString stringWithFormat:@",%@",listModel.focusID]];
    }
    [idsString deleteCharactersInRange:NSMakeRange(0, 1)];
    
    NSString *url = @"r=apply.favorite.remove";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              idsString,@"ids", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            [focusListArray removeObjectsInArray:goodsArray];
            
            [self.focusTableView reloadData];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
    
}

#pragma mark - 我的关注列表请求
- (void)myFocusListRequest:(NSInteger)page {
    NSString *url = @"r=apply.favorite.get_list";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              [NSString stringWithFormat:@"%d",KPageSize],@"pageSize",
                              [NSString stringWithFormat:@"%ld",(long)page],@"page", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if (page == 1) {
            [focusListArray removeAllObjects];
        }
        [self.focusTableView.mj_header endRefreshing];
        [self.focusTableView.mj_footer endRefreshing];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            MyFocusResultModel *resultModel = [MyFocusResultModel yy_modelWithDictionary:responseDic[@"result"]];
            [focusListArray addObjectsFromArray:resultModel.list];
            
            if ([resultModel.list count] < KPageSize) {
                [self.focusTableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            [self.focusTableView reloadData];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        if (self.focusTableView.mj_header.isRefreshing == YES) {
            [self.focusTableView.mj_header endRefreshing];
        }
        if ([self.focusTableView.mj_footer isRefreshing] == YES) {
            requestPage --;
            [self.focusTableView.mj_footer endRefreshing];
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
