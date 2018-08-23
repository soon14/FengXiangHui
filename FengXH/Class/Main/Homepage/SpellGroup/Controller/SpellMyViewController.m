//
//  SpellMyViewController.m
//  FengXH
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellMyViewController.h"
#import "MySpellHeaderView.h"
#import "InGroupViewController.h"
@interface SpellMyViewController ()<UIScrollViewDelegate>
@property(nonatomic , strong)MySpellHeaderView *mySpellHeaderView;
@property(nonatomic , strong)UIScrollView *basicScrollView;
@property(nonatomic , assign)NSInteger spellType;
@end

@implementation SpellMyViewController

- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _spellType = type;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的团";
    
    //添加返回按钮
    UIBarButtonItem * backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"erji_fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonItemAction)];
    self.navigationItem.leftBarButtonItem = backBarButtonItem;
    [backBarButtonItem setTintColor:KUIColorFromHex(0x9a9a9a)];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //顶部菜单栏
    [self.view addSubview:self.mySpellHeaderView];
    
    //添加子控制器
    [self AddChildViewControllers];
    
    //添加滚动视图
    [self.view addSubview:self.basicScrollView];
    
    [self scrollViewDidEndScrollingAnimation:self.basicScrollView];
}
- (void)backBarButtonItemAction{
    [self.tabBarController.navigationController popViewControllerAnimated:YES];
}
#pragma mark - 顶部菜单型按钮
- (MySpellHeaderView *)mySpellHeaderView {
    if (!_mySpellHeaderView) {
        _mySpellHeaderView = [[MySpellHeaderView alloc]initWithType:1];
        _mySpellHeaderView.frame=CGRectMake(0, 0, KMAINSIZE.width, 42);
        MJWeakSelf
        _mySpellHeaderView.spellTypeBlock = ^(NSInteger index) {
            [weakSelf chooseTheTitle:index];
        };
    }
    return _mySpellHeaderView;
}
#pragma mark - 添加子控制器
- (void)AddChildViewControllers {
    InGroupViewController *allOrderVC = [[InGroupViewController alloc]initWithType:0];
    InGroupViewController *waitPaidVC = [[InGroupViewController alloc]initWithType:1];
    InGroupViewController *waitSendVC = [[InGroupViewController alloc]initWithType:-1];

    
    [self addChildViewController:allOrderVC];
    [self addChildViewController:waitPaidVC];
    [self addChildViewController:waitSendVC];
   
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
        CGFloat scale = scrollView.contentOffset.x/3;
        _mySpellHeaderView.moveLine.frame = CGRectMake(scale, 40, KMAINSIZE.width/3, 2);
        if (scale<KMAINSIZE.width/3/2) {
            [_mySpellHeaderView.firstBtn setTitleColor:KUIColorFromHex(0xff463c) forState:UIControlStateNormal];
            [_mySpellHeaderView.secondBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_mySpellHeaderView.thirdBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        } else if (scale>KMAINSIZE.width/3/2 && scale<(KMAINSIZE.width/3/2)*3) {
            [_mySpellHeaderView.firstBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_mySpellHeaderView.secondBtn setTitleColor:KUIColorFromHex(0xff463c) forState:UIControlStateNormal];
            [_mySpellHeaderView.thirdBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            //NSLog(@"--2--");
        } else if (scale>(KMAINSIZE.width/3/2)*3 && scale<(KMAINSIZE.width/3/2)*5) {
            [_mySpellHeaderView.firstBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_mySpellHeaderView.secondBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_mySpellHeaderView.thirdBtn setTitleColor:KUIColorFromHex(0xff463c) forState:UIControlStateNormal];
            //NSLog(@"--3--");
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
