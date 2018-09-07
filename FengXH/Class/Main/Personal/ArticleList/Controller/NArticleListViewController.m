//
//  NArticleListViewController.m
//  FengXH
//
//  Created by HomepageDataCategoryGoodsModel on 2018/9/5.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "NArticleListViewController.h"
#import "ArticleListHeaderCell.h"
#import "ArticleListContentCell.h"
#import "ArticelListResultModel.h"
#import "ArticleContentViewController.h"

@interface NArticleListViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger requestPage;
    NSMutableArray *articleListArray;
}
/** 文章类型 */
@property(nonatomic , assign)NSInteger articleType;
/** tableView */
@property(nonatomic , strong)UITableView *articleTableView;

@end

@implementation NArticleListViewController

- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _articleType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    articleListArray = [NSMutableArray array];
    
    [self.view addSubview:self.articleTableView];
    
    requestPage = 1;
    [self articleListRequest:requestPage];
}

#pragma mark - tableView
- (UITableView *)articleTableView {
    if (!_articleTableView) {
        _articleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-42-KNaviHeight) style:UITableViewStylePlain];
        _articleTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _articleTableView.backgroundColor = [UIColor whiteColor];
        _articleTableView.showsVerticalScrollIndicator = NO;
        _articleTableView.dataSource = self;
        _articleTableView.delegate = self;
        _articleTableView.estimatedRowHeight = 0;
        _articleTableView.estimatedSectionHeaderHeight = 0;
        _articleTableView.estimatedSectionFooterHeight = 0;
        [_articleTableView registerClass:[ArticleListHeaderCell class] forCellReuseIdentifier:NSStringFromClass([ArticleListHeaderCell class])];
        [_articleTableView registerClass:[ArticleListContentCell class] forCellReuseIdentifier:NSStringFromClass([ArticleListContentCell class])];
        [_articleTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
        _articleTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
        _articleTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    }
    return _articleTableView;
}

#pragma mark - 下拉刷新
- (void)refresh {
    if (!_articleTableView.mj_footer.isRefreshing) {
        requestPage = 1;
        [self articleListRequest:requestPage];
    }
}

#pragma mark - 上拉加载
- (void)loadmore {
    if(!_articleTableView.mj_header.isRefreshing){
        requestPage ++;
        [self articleListRequest:requestPage];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (articleListArray.count > 0) {
        return 2;
    } return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0: return 1; break;
        case 1: return articleListArray.count; break;
        default: return 0; break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            return [ShareManager getImageHeight:@"ArticleListBack"];
        } break;
        case 1: {
            return 140;
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
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0: {
            ArticleListHeaderCell *headerCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ArticleListHeaderCell class])];
            return headerCell;
        } break;
        case 1: {
            if (articleListArray.count > 0) {
                ArticleListContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ArticleListContentCell class])];
                contentCell.articleListModel = articleListArray[indexPath.row];
                return contentCell;
            }
        } break;
        default:
            break;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
    cell.backgroundColor = [UIColor orangeColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        ArticelListResultArticlesListModel *articleModel = articleListArray[indexPath.row];
        ArticleContentViewController *articleVC = [[ArticleContentViewController alloc] init];
        articleVC.articleModel = articleModel;
        [self.navigationController pushViewController:articleVC animated:YES];
    }
}


#pragma mark - 赏金文章列表请求
- (void)articleListRequest:(NSInteger)page {
    NSString *url = @"r=apply.article.getlist";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token",
                              [NSString stringWithFormat:@"%ld",(long)_articleType],@"cateid",
                              [NSString stringWithFormat:@"%d",KPageSize],@"pageSize",
                              [NSString stringWithFormat:@"%ld",(long)page],@"page", nil];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if (page == 1) {
            [articleListArray removeAllObjects];
        }
        [self.articleTableView.mj_header endRefreshing];
        [self.articleTableView.mj_footer endRefreshing];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            ArticelListResultModel *resultModel = [ArticelListResultModel yy_modelWithDictionary:responseDic[@"result"]];
            [articleListArray addObjectsFromArray:resultModel.articles.list];

            if ([resultModel.articles.list count] < KPageSize) {
                [self.articleTableView.mj_footer endRefreshingWithNoMoreData];
            }
            
            [self.articleTableView reloadData];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        if (self.articleTableView.mj_header.isRefreshing == YES) {
            [self.articleTableView.mj_header endRefreshing];
        }
        if ([self.articleTableView.mj_footer isRefreshing] == YES) {
            requestPage --;
            [self.articleTableView.mj_footer endRefreshing];
        }
    }];
    
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
