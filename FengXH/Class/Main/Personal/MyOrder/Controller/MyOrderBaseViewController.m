//
//  MyOrderBaseViewController.m
//  FengXH
//
//  Created by sun on 2018/7/19.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MyOrderBaseViewController.h"
#import "MyOrderViewController.h"
#import "OrderTypeHeaderView.h"

@interface MyOrderBaseViewController ()<UIScrollViewDelegate>

@property(nonatomic , strong)OrderTypeHeaderView *topButtonView;
@property(nonatomic , strong)UIScrollView *basicScrollView;
@property(nonatomic , assign)NSInteger orderType;

@end

@implementation MyOrderBaseViewController

- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _orderType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //顶部订单类型按钮
    [self.view addSubview:self.topButtonView];
    
    //添加子控制器
    [self AddChildViewControllers];
    
    //添加滚动视图
    [self.view addSubview:self.basicScrollView];
    
    //
    CGPoint offset = self.basicScrollView.contentOffset;
    if (self.orderType == AllOrder) {
        [self scrollViewDidEndScrollingAnimation:self.basicScrollView];
    } else if (self.orderType == waitingForPayOrder){
        offset.x = KMAINSIZE.width;
        [self.basicScrollView setContentOffset:offset animated:YES];
    } else if (self.orderType == waitingForSendOrder){
        offset.x = KMAINSIZE.width*2;
        [self.basicScrollView setContentOffset:offset animated:YES];
    } else if (self.orderType == waitingForReceiveOrder){
        offset.x = KMAINSIZE.width*3;
        [self.basicScrollView setContentOffset:offset animated:YES];
    } else if (self.orderType == completedOrder){
        offset.x = KMAINSIZE.width*4;
        [self.basicScrollView setContentOffset:offset animated:YES];
    }
    
}

#pragma mark - 顶部订单类型按钮
- (OrderTypeHeaderView *)topButtonView {
    if (!_topButtonView) {
        _topButtonView = [[OrderTypeHeaderView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 42)];
        MJWeakSelf
        _topButtonView.orderTypeBlock = ^(NSInteger index) {
            [weakSelf chooseTheTitle:index];
        };
    }
    return _topButtonView;
}

#pragma mark - 添加子控制器
- (void)AddChildViewControllers {
    //订单状态 -1已取消 0待付款 1待发货 2待收货 3已完成 4退款申请
    
    MyOrderViewController *allOrderVC = [[MyOrderViewController alloc]initWithType:400];
    MyOrderViewController *waitPaidVC = [[MyOrderViewController alloc]initWithType:0];
    MyOrderViewController *waitSendVC = [[MyOrderViewController alloc]initWithType:1];
    MyOrderViewController *waitReceiveVC = [[MyOrderViewController alloc]initWithType:2];
    MyOrderViewController *waitEvaluateVC = [[MyOrderViewController alloc]initWithType:3];
    
    [self addChildViewController:allOrderVC];
    [self addChildViewController:waitPaidVC];
    [self addChildViewController:waitSendVC];
    [self addChildViewController:waitReceiveVC];
    [self addChildViewController:waitEvaluateVC];
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
        CGFloat scale = scrollView.contentOffset.x/5;
        _topButtonView.moveLine.frame = CGRectMake(scale+10, 40, KMAINSIZE.width/5-20, 2);
        if (scale<KMAINSIZE.width/10) {
            [_topButtonView.allButton setTitleColor:KRedColor forState:UIControlStateNormal];
            [_topButtonView.waitPaidButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.waitSendButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.waitReceiveButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.waitEvaluateButton setTitleColor:KUIColorFromHex(0x666666)forState:UIControlStateNormal];
            //NSLog(@"--1--");
        } else if (scale>KMAINSIZE.width/10 && scale<(KMAINSIZE.width/10)*3) {
            [_topButtonView.allButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.waitPaidButton setTitleColor:KRedColor forState:UIControlStateNormal];
            [_topButtonView.waitSendButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.waitReceiveButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.waitEvaluateButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            //NSLog(@"--2--");
        } else if (scale>(KMAINSIZE.width/10)*3 && scale<(KMAINSIZE.width/10)*5) {
            [_topButtonView.allButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.waitPaidButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.waitSendButton setTitleColor:KRedColor forState:UIControlStateNormal];
            [_topButtonView.waitReceiveButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.waitEvaluateButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            //NSLog(@"--3--");
        } else if (scale>(KMAINSIZE.width/10)*5 && scale<(KMAINSIZE.width/10)*7) {
            [_topButtonView.allButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.waitPaidButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.waitSendButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.waitReceiveButton setTitleColor:KRedColor forState:UIControlStateNormal];
            [_topButtonView.waitEvaluateButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            //NSLog(@"--4--");
        } else if (scale>(KMAINSIZE.width/10)*7 && scale<(KMAINSIZE.width/10)*9) {
            [_topButtonView.allButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.waitPaidButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.waitSendButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.waitReceiveButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.waitEvaluateButton setTitleColor:KRedColor forState:UIControlStateNormal];
            //NSLog(@"--5--");
        }
        if (scrollView.contentOffset.x < -(KMAINSIZE.width/4-20)) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
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
