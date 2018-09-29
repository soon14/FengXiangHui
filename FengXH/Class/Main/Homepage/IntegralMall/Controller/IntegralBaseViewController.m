//
//  IntegralBaseViewController.m
//  FengXH
//
//  Created by sun on 2018/9/26.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralBaseViewController.h"
#import "IntegralBaseHeaderView.h"
#import "IntegralMallViewController.h"
#import "IntegralExchangeViewController.h"
#import "IntegralRecordBaseViewController.h"
#import "PersonalDataModel.h"

@interface IntegralBaseViewController ()<UIScrollViewDelegate>

/** headerView */
@property(nonatomic , strong)IntegralBaseHeaderView *headerView;
/** 底层scrollView */
@property(nonatomic , strong)UIScrollView *basicScrollView;
/** model */
@property(nonatomic , strong)PersonalDataModel *dataModel;

@end

@implementation IntegralBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_offset(0);
        make.height.mas_equalTo(KNaviHeight+90);
    }];
    
    //添加子控制器
    [self AddChildViewControllers];
    //添加滚动视图
    [self.view addSubview:self.basicScrollView];
    //
    [self scrollViewDidEndScrollingAnimation:self.basicScrollView];
    //请求个人数据
    [self requestPersonalDada];
    
}

#pragma mark - headerView
- (IntegralBaseHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[IntegralBaseHeaderView alloc] init];
        MJWeakSelf
        _headerView.headerBlock = ^(NSInteger index) {
            [weakSelf chooseTheTitle:index];
        };
    }
    return _headerView;
}

#pragma mark - 添加子控制器
- (void)AddChildViewControllers {
    IntegralMallViewController *mallVC = [[IntegralMallViewController alloc] init];
    IntegralExchangeViewController *exchangeVC = [[IntegralExchangeViewController alloc] init];
    
    [self addChildViewController:mallVC];
    [self addChildViewController:exchangeVC];
}

#pragma mark - 底层 scrollView
- (UIScrollView *)basicScrollView {
    if (!_basicScrollView) {
        _basicScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, KNaviHeight+90, KMAINSIZE.width, KMAINSIZE.height-(KNaviHeight+90))];
        _basicScrollView.delegate = self;
        _basicScrollView.pagingEnabled = YES;
        _basicScrollView.showsHorizontalScrollIndicator = NO;
        _basicScrollView.contentSize = CGSizeMake(self.childViewControllers.count*KMAINSIZE.width, KMAINSIZE.height-(KNaviHeight+90));
    }
    return _basicScrollView;
}

#pragma mark -<UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView == self.basicScrollView) {
        NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
        UIViewController *chileview = self.childViewControllers[index];
        CGRect frame = {{scrollView.contentOffset.x , 0}, scrollView.frame.size};
        chileview.view.frame = frame;
        [scrollView addSubview:chileview.view];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - 订单类型按钮被点击
- (void)chooseTheTitle:(NSInteger)index {
    switch (index) {
        case 0:
        case 1: {
            CGPoint offset = self.basicScrollView.contentOffset;
            offset.x = index * self.basicScrollView.frame.size.width;
            [self.basicScrollView setContentOffset:offset animated:YES];
        } break;
            
        default: {
            IntegralRecordBaseViewController *VC = [[IntegralRecordBaseViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        } break;
    }
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.basicScrollView) {
        CGFloat scale = scrollView.contentOffset.x/2;
        if (scale<KMAINSIZE.width/4) {
            [_headerView.integralMallButton setTitleColor:KRedColor forState:UIControlStateNormal];
            [_headerView.integralExchangeButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_headerView.exchangeRecordButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            //NSLog(@"--1--");
        } else if (scale>KMAINSIZE.width/4 && scale<(KMAINSIZE.width/4)*3) {
            [_headerView.integralMallButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_headerView.integralExchangeButton setTitleColor:KRedColor forState:UIControlStateNormal];
            [_headerView.exchangeRecordButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            //NSLog(@"--2--");
        }
        if (scrollView.contentOffset.x < -(KMAINSIZE.width/4-20)) {
            [self.navigationController popViewControllerAnimated:YES];
        } else if (scrollView.contentOffset.x > KMAINSIZE.width + KMAINSIZE.width/4) {
            IntegralRecordBaseViewController *VC = [[IntegralRecordBaseViewController alloc] init];
            [self.navigationController pushViewController:VC animated:YES];
        }
    }
}

#pragma mark - 个人中心数据请求
- (void)requestPersonalDada {
    NSString * urlString = @"r=apply.personal";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token", nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            self.dataModel = [PersonalDataModel yy_modelWithDictionary:responseDic[@"result"]];
            self.headerView.personalDataModel = self.dataModel;
            
        } else if ([responseDic[@"status"] integerValue] == 401) {
            [self presentLoginViewControllerWithSuccessBlock:^{
                [self requestPersonalDada];
            } WithFailureBlock:nil];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
        }
    } WithFailureBlock:^(NSError *error) {

        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        
    }];
    
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
