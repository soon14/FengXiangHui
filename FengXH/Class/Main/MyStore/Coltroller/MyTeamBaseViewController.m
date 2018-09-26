//
//  MyTeamBaseViewController.m
//  FengXH
//
//  Created by mac on 2018/7/26.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MyTeamBaseViewController.h"
#import "MyTeamTopView.h"
#import "MyTeamViewController.h"

@interface MyTeamBaseViewController ()<UIScrollViewDelegate>

@property(nonatomic , strong)MyTeamTopView *topButtonView;

@property(nonatomic , strong)UIScrollView *basicScrollView;

@property(nonatomic,strong)UIViewController *currentVC;


@end

@implementation MyTeamBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"我的团队";
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //顶部view
    [self.view addSubview:self.topButtonView];
    
    //添加子控制器
    [self AddChildViewControllers];
    
    //添加滚动视图
    [self.view addSubview:self.basicScrollView];
    
    [self scrollViewDidEndScrollingAnimation:self.basicScrollView];

}
- (MyTeamTopView *)topButtonView {
    if (!_topButtonView) {
        _topButtonView = [[MyTeamTopView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 42)];
        MJWeakSelf
        _topButtonView.myTeamBlock = ^(NSInteger index) {
            [weakSelf chooseTheTitle:index];
        };
    }
    return _topButtonView;
}

#pragma mark - 添加子控制器
- (void)AddChildViewControllers {
    
    MyTeamViewController *firstVC = [[MyTeamViewController alloc]initWithType:0];
    MyTeamViewController *secondVC = [[MyTeamViewController alloc]initWithType:1];
    
    [self addChildViewController:firstVC];
    [self addChildViewController:secondVC];
    
    
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

#pragma mark -<UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView == self.basicScrollView) {
        NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
        UIViewController *chileview = self.childViewControllers[index];
        CGRect frame = {{scrollView.contentOffset.x , 0}, scrollView.frame.size};
        chileview.view.frame = frame;
//        if (self.currentVC!=chileview) {
//            [self.currentVC.view removeFromSuperview];
            [scrollView addSubview:chileview.view];
//            self.currentVC=chileview;
//        }
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.basicScrollView) {
        CGFloat scale = scrollView.contentOffset.x/2;
        _topButtonView.moveLine.frame = CGRectMake(scale, 40, KMAINSIZE.width/2, 2);
        if (scale<KMAINSIZE.width/2/2) {
            [_topButtonView.stairShopkeeper setTitleColor:KRedColor forState:UIControlStateNormal];
            [_topButtonView.secondShopkeeper setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            
        } else if (scale>KMAINSIZE.width/2/2 && scale<(KMAINSIZE.width/2/2)*3) {
            [_topButtonView.stairShopkeeper setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.secondShopkeeper setTitleColor:KRedColor forState:UIControlStateNormal];
            
        }
        if (scrollView.contentOffset.x < -KMAINSIZE.width/4) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}

#pragma mark - 顶部类型按钮被点击
- (void)chooseTheTitle:(NSInteger)index {
    CGPoint offset = self.basicScrollView.contentOffset;
    offset.x = index * self.basicScrollView.frame.size.width;
    [self.basicScrollView setContentOffset:offset animated:YES];
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
