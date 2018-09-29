//
//  ArticleListBaseViewController.m
//  FengXH
//
//  Created by HomepageDataCategoryGoodsModel on 2018/9/5.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ArticleListBaseViewController.h"
#import "NArticleListViewController.h"
#import "ArticleCategoryResultModel.h"
#import "ArticleListTitleCell.h"

#define TopButtonWidth (KMAINSIZE.width-80)
#define TopButtonHeight 42

@interface ArticleListBaseViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/** categoryModel */
@property(nonatomic , strong)ArticleCategoryResultModel *resultModel;
/** collection */
@property(nonatomic , strong)UICollectionView *titleCollectionView;
/** 移动光标 */
@property(nonatomic , strong)UIView *moveLine;
/** 放置控制器的ScrollView */
@property(nonatomic , strong)UIScrollView *basicScrollView;

@end

@implementation ArticleListBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"赏金文章";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    //标题请求
    [self articleListTitleRequest];
}

- (void)initSegment {
    [self.view addSubview:self.titleCollectionView];
    [self.titleCollectionView addSubview:self.moveLine];
    //添加子控制器
    [self AddChildViewControllers:self.resultModel.categorys];
    //添加滚动视图
    [self.view addSubview:self.basicScrollView];
    //
    [self scrollViewDidEndScrollingAnimation:self.basicScrollView];
    //
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [self.titleCollectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
}

#pragma mark - 添加子控制器
- (void)AddChildViewControllers:(NSArray *)categorys {
    for (NSInteger i = 0; i < categorys.count; i++) {
        ArticleCategoryResultCategoryModel *categoryModel = categorys[i];
        NArticleListViewController *VC = [[NArticleListViewController alloc] initWithType:[categoryModel.categoryID integerValue]];
        [self addChildViewController:VC];
    }
}



#pragma mark -<UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView == self.basicScrollView) {
        NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
        UIViewController *chileview = self.childViewControllers[index];
        CGRect frame = {{scrollView.contentOffset.x , 0}, scrollView.frame.size};
        chileview.view.frame = frame;
        [scrollView addSubview:chileview.view];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        [self.titleCollectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionCenteredHorizontally];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.basicScrollView) {
        [self scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.basicScrollView) {
        CGFloat moveLineScale = ((TopButtonWidth/KMAINSIZE.width)*scrollView.contentOffset.x)/self.resultModel.categorys.count;
        self.moveLine.frame = CGRectMake(moveLineScale+12, 40, TopButtonWidth/self.resultModel.categorys.count-24, 2);
        
        if (scrollView.contentOffset.x < -(KMAINSIZE.width/4-20)) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (UICollectionView *)titleCollectionView {
    if (!_titleCollectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsZero;
        _titleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake((KMAINSIZE.width-TopButtonWidth)/2, 0, TopButtonWidth, TopButtonHeight) collectionViewLayout:flowLayout];
        _titleCollectionView.backgroundColor = [UIColor whiteColor];
        _titleCollectionView.dataSource = self;
        _titleCollectionView.delegate = self;
//        _titleCollectionView.alwaysBounceVertical = YES;
        [_titleCollectionView registerClass:[ArticleListTitleCell class] forCellWithReuseIdentifier:NSStringFromClass([ArticleListTitleCell class])];
    }
    return _titleCollectionView;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.resultModel.categorys.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.resultModel.categorys.count > 4) {
        return CGSizeMake(80, TopButtonHeight);
    } return CGSizeMake(TopButtonWidth/self.resultModel.categorys.count, TopButtonHeight);
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    ArticleListTitleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ArticleListTitleCell class]) forIndexPath:indexPath];
    ArticleCategoryResultCategoryModel *catogoryModel = self.resultModel.categorys[indexPath.item];
    cell.title = catogoryModel.category_name;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    CGPoint offset = self.basicScrollView.contentOffset;
    offset.x = indexPath.item * self.basicScrollView.frame.size.width;
    [self.basicScrollView setContentOffset:offset animated:YES];
}

#pragma mark - 底层 scrollView
- (UIScrollView *)basicScrollView {
    if (!_basicScrollView) {
        _basicScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 42, KMAINSIZE.width, KMAINSIZE.height-42)];
        _basicScrollView.delegate = self;
        _basicScrollView.pagingEnabled = YES;
        _basicScrollView.showsHorizontalScrollIndicator = NO;
        _basicScrollView.contentSize = CGSizeMake(self.childViewControllers.count*KMAINSIZE.width, KMAINSIZE.height-42);
    }
    return _basicScrollView;
}

#pragma mark - 移动光标
- (UIView *)moveLine {
    if (!_moveLine) {
        _moveLine = [[UIView alloc] initWithFrame:CGRectMake(12, 40, (self.resultModel.categorys.count>4?80:(TopButtonWidth/self.resultModel.categorys.count))-24, 2)];
        [_moveLine setBackgroundColor:KRedColor];
        [_moveLine.layer setMasksToBounds:YES];
        [_moveLine.layer setCornerRadius:1];
    }
    return _moveLine;
}

#pragma mark - 赏金文章标题请求
- (void)articleListTitleRequest {
    NSString *url = @"r=apply.article.alist";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:
                        [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token", nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        if ([responseDic[@"status"] integerValue] == 1) {
            
            self.resultModel = [ArticleCategoryResultModel yy_modelWithDictionary:responseDic[@"result"]];
            [self initSegment];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]?responseDic[@"message"]:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
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
