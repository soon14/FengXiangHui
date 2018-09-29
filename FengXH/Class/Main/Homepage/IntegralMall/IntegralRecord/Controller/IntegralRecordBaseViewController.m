//
//  IntegralRecordViewController.m
//  FengXH
//
//  Created by sun on 2018/9/26.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralRecordBaseViewController.h"
#import "IntegralRecordBaseHeaderView.h"
#import "IntegralRecordViewController.h"

@interface IntegralRecordBaseViewController ()<UIScrollViewDelegate>

/** headerView */
@property(nonatomic , strong)IntegralRecordBaseHeaderView *headerView;
@property(nonatomic , strong)UIScrollView *basicScrollView;

@end

@implementation IntegralRecordBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"兑换记录";

    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.height.mas_equalTo(42);
    }];
    
    //添加子控制器
    [self AddChildViewControllers];
    //添加滚动视图
    [self.view addSubview:self.basicScrollView];
    //
    [self scrollViewDidEndScrollingAnimation:self.basicScrollView];
    
}

#pragma mark - headerView
- (IntegralRecordBaseHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[IntegralRecordBaseHeaderView alloc] init];
        MJWeakSelf
        _headerView.headerBlock = ^(NSInteger index) {
            [weakSelf chooseTheTitle:index];
        };
    }
    return _headerView;
}

#pragma mark - 添加子控制器
- (void)AddChildViewControllers {
    IntegralRecordViewController *allVC = [[IntegralRecordViewController alloc] initWithType:0];
    IntegralRecordViewController *exchagneVC = [[IntegralRecordViewController alloc] initWithType:1];
    IntegralRecordViewController *winnerVC = [[IntegralRecordViewController alloc] initWithType:2];
    
    [self addChildViewController:allVC];
    [self addChildViewController:exchagneVC];
    [self addChildViewController:winnerVC];
}

#pragma mark - 底层 scrollView
- (UIScrollView *)basicScrollView {
    if (!_basicScrollView) {
        _basicScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 42, KMAINSIZE.width, KMAINSIZE.height-(KNaviHeight+42))];
        _basicScrollView.delegate = self;
        _basicScrollView.pagingEnabled = YES;
        _basicScrollView.showsHorizontalScrollIndicator = NO;
        _basicScrollView.contentSize = CGSizeMake(self.childViewControllers.count*KMAINSIZE.width, KMAINSIZE.height-(KNaviHeight+42));
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
    CGPoint offset = self.basicScrollView.contentOffset;
    offset.x = index * self.basicScrollView.frame.size.width;
    [self.basicScrollView setContentOffset:offset animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.basicScrollView) {
        CGFloat scale = scrollView.contentOffset.x/3;
        _headerView.moveLine.frame = CGRectMake(scale+40, 40, KMAINSIZE.width/3-80, 2);
        if (scale<KMAINSIZE.width/6) {
            [_headerView.allRecordButton setTitleColor:KRedColor forState:UIControlStateNormal];
            [_headerView.exchangeButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_headerView.winnerButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            //NSLog(@"--1--");
        } else if (scale>KMAINSIZE.width/6 && scale<(KMAINSIZE.width/6)*3) {
            [_headerView.allRecordButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_headerView.exchangeButton setTitleColor:KRedColor forState:UIControlStateNormal];
            [_headerView.winnerButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            //NSLog(@"--2--");
        } else if (scale>KMAINSIZE.width/6 && scale<(KMAINSIZE.width/6)*5) {
            [_headerView.allRecordButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_headerView.exchangeButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_headerView.winnerButton setTitleColor:KRedColor forState:UIControlStateNormal];
            //NSLog(@"--2--");
        }
        if (scrollView.contentOffset.x < -(KMAINSIZE.width/4-20)) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
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
