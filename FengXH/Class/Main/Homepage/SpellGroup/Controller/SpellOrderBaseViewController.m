//
//  SpellOrderBaseViewController.m
//  FengXH
//
//  Created by mac on 2018/8/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderBaseViewController.h"
#import "MySpellHeaderView.h"
#import "SpellOrderViewController.h"

@interface SpellOrderBaseViewController ()<UIScrollViewDelegate>

@property(nonatomic , strong)MySpellHeaderView *topButtonView;

@property(nonatomic , strong)UIScrollView *basicScrollView;

@property(nonatomic,strong)UIViewController *currentVC;

@end

@implementation SpellOrderBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的订单";
    
    //添加返回按钮
    UIBarButtonItem * backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"erji_fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonItemAction)];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    [backBarButtonItem setTintColor:KUIColorFromHex(0x9a9a9a)];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //顶部view
    [self.view addSubview:self.topButtonView];
    
    //添加子控制器
    [self AddChildViewControllers];
    
    //添加滚动视图
    [self.view addSubview:self.basicScrollView];
    
    [self scrollViewDidEndScrollingAnimation:self.basicScrollView];
    
}

- (void)backBarButtonItemAction{
    [self.tabBarController.navigationController popViewControllerAnimated:YES];
}

- (MySpellHeaderView *)topButtonView {
    if (!_topButtonView) {
        _topButtonView = [[MySpellHeaderView alloc]initWithType:0];
        _topButtonView.frame=CGRectMake(0, 0, KMAINSIZE.width, 42);
        MJWeakSelf
        _topButtonView.spellTypeBlock = ^(NSInteger index) {
            [weakSelf chooseTheTitle:index];
        };
    }
    return _topButtonView;
}

#pragma mark - 添加子控制器
- (void)AddChildViewControllers {
    
    SpellOrderViewController *firstVC = [[SpellOrderViewController alloc]initWithType:0];
    SpellOrderViewController *secondVC = [[SpellOrderViewController alloc]initWithType:1];
    SpellOrderViewController *thirdVC = [[SpellOrderViewController alloc]initWithType:2];
    SpellOrderViewController *fourthVC = [[SpellOrderViewController alloc]initWithType:3];
    SpellOrderViewController *fifthVC = [[SpellOrderViewController alloc]initWithType:4];
    
    
    
    [self addChildViewController:firstVC];
    [self addChildViewController:secondVC];
    [self addChildViewController:thirdVC];
    [self addChildViewController:fourthVC];
    [self addChildViewController:fifthVC];

    
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
        if (self.currentVC!=chileview) {
            [self.currentVC.view removeFromSuperview];
            [scrollView addSubview:chileview.view];
            self.currentVC=chileview;
        }
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.basicScrollView) {
        CGFloat scale = scrollView.contentOffset.x/5;
        _topButtonView.moveLine.frame = CGRectMake(scale, 40, KMAINSIZE.width/5, 2);
        if (scale<KMAINSIZE.width/5/2) {
            [_topButtonView.firstBtn setTitleColor:KUIColorFromHex(0xff463c) forState:UIControlStateNormal];
            [_topButtonView.secondBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.thirdBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.fourthBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.fifthBtn setTitleColor:KUIColorFromHex(0x666666)forState:UIControlStateNormal];
        } else if (scale>KMAINSIZE.width/5/2 && scale<(KMAINSIZE.width/5/2)*3) {
            [_topButtonView.firstBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.secondBtn setTitleColor:KUIColorFromHex(0xff463c) forState:UIControlStateNormal];
            [_topButtonView.thirdBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.fourthBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.fifthBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        } else if (scale>(KMAINSIZE.width/5/2)*3 && scale<(KMAINSIZE.width/5/2)*5) {
            [_topButtonView.firstBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.secondBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.thirdBtn setTitleColor:KUIColorFromHex(0xff463c) forState:UIControlStateNormal];
            [_topButtonView.fourthBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.fifthBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        } else if (scale>(KMAINSIZE.width/5/2)*5 && scale<(KMAINSIZE.width/5/2)*7) {
            [_topButtonView.firstBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.secondBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.thirdBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.fourthBtn setTitleColor:KUIColorFromHex(0xff463c) forState:UIControlStateNormal];
            [_topButtonView.fifthBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        }else if (scale>(KMAINSIZE.width/5/2)*7 && scale<(KMAINSIZE.width/5/2)*9) {
            [_topButtonView.firstBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.secondBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.thirdBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.fourthBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.fifthBtn setTitleColor:KUIColorFromHex(0xff463c) forState:UIControlStateNormal];
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
