//
//  DetailBaseViewController.m
//  FengXH
//
//  Created by mac on 2018/7/25.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "DetailBaseViewController.h"
#import "DetailTopView.h"
#import "DetailViewController.h"

@interface DetailBaseViewController ()<UIScrollViewDelegate>

@property(nonatomic , strong)UIScrollView *basicScrollView;

@property(nonatomic , assign)NSInteger detailType;

@property(nonatomic,strong)UIViewController *currentVC;

@end

@implementation DetailBaseViewController

- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _detailType = type;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (_detailType==0) {
        self.title = @"佣金明细";
    }
    else
    {
        self.title = @"提现明细";
    }
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    //顶部view
    [self.view addSubview:self.topButtonView];
    
    //添加子控制器
    [self AddChildViewControllers];
    
    //添加滚动视图
    [self.view addSubview:self.basicScrollView];
    
    [self scrollViewDidEndScrollingAnimation:self.basicScrollView];
    
}
- (DetailTopView *)topButtonView {
    if (!_topButtonView) {
        _topButtonView = [[DetailTopView alloc]initWithType:self.detailType];
        _topButtonView.frame=CGRectMake(0, 0, KMAINSIZE.width, 82);
        MJWeakSelf
        _topButtonView.detailTypeBlock = ^(NSInteger index) {
            [weakSelf chooseTheTitle:index];
        };
    }
    return _topButtonView;
}

#pragma mark - 添加子控制器
- (void)AddChildViewControllers {
    DetailViewController *firstVC = [[DetailViewController alloc]initWithType:0];
    DetailViewController *secondVC = [[DetailViewController alloc]initWithType:1];
    DetailViewController *thirdVC = [[DetailViewController alloc]initWithType:2];
    DetailViewController *fourthVC = [[DetailViewController alloc]initWithType:3];
   
    [self addChildViewController:firstVC];
    [self addChildViewController:secondVC];
    [self addChildViewController:thirdVC];
    [self addChildViewController:fourthVC];
    
    if (_detailType==1) {
        DetailViewController *fifthVC = [[DetailViewController alloc]initWithType:4];
        fifthVC.detailType=_detailType;
        [self addChildViewController:fifthVC];
    }
    
    firstVC.detailType=_detailType;
    secondVC.detailType=_detailType;
    thirdVC.detailType=_detailType;
    fourthVC.detailType=_detailType;
}

#pragma mark - 底层 scrollView
- (UIScrollView *)basicScrollView {
    if (!_basicScrollView) {
        _basicScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 82, KMAINSIZE.width, KMAINSIZE.height-82)];
        _basicScrollView.delegate = self;
        _basicScrollView.pagingEnabled = YES;
        _basicScrollView.showsHorizontalScrollIndicator = NO;
        _basicScrollView.contentSize = CGSizeMake(self.childViewControllers.count*KMAINSIZE.width, KMAINSIZE.height-82);
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

#pragma mark - 顶部类型按钮被点击
- (void)chooseTheTitle:(NSInteger)index {
    CGPoint offset = self.basicScrollView.contentOffset;
    offset.x = index * self.basicScrollView.frame.size.width;
    [self.basicScrollView setContentOffset:offset animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    int count;
    if (_detailType==0) {
        count=4;
    }
    else
    {
        count=5;
    }
    
    if (scrollView == self.basicScrollView) {
        CGFloat scale = scrollView.contentOffset.x/count;
        _topButtonView.moveLine.frame = CGRectMake(scale, 80, KMAINSIZE.width/count, 2);
        if (scale<KMAINSIZE.width/count/2) {
            [_topButtonView.firstBtn setTitleColor:KUIColorFromHex(0xff463c) forState:UIControlStateNormal];
            [_topButtonView.secondBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.thirdBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.fourthBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.fifthBtn setTitleColor:KUIColorFromHex(0x666666)forState:UIControlStateNormal];
        } else if (scale>KMAINSIZE.width/count/2 && scale<(KMAINSIZE.width/count/2)*3) {
            [_topButtonView.firstBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.secondBtn setTitleColor:KUIColorFromHex(0xff463c) forState:UIControlStateNormal];
            [_topButtonView.thirdBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.fourthBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.fifthBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        } else if (scale>(KMAINSIZE.width/count/2)*3 && scale<(KMAINSIZE.width/count/2)*5) {
            [_topButtonView.firstBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.secondBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.thirdBtn setTitleColor:KUIColorFromHex(0xff463c) forState:UIControlStateNormal];
            [_topButtonView.fourthBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.fifthBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        } else if (scale>(KMAINSIZE.width/count/2)*5 && scale<(KMAINSIZE.width/count/2)*7) {
            [_topButtonView.firstBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.secondBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.thirdBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.fourthBtn setTitleColor:KUIColorFromHex(0xff463c) forState:UIControlStateNormal];
            [_topButtonView.fifthBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        }else if (scale>(KMAINSIZE.width/count/2)*7 && scale<(KMAINSIZE.width/count/2)*9) {
            [_topButtonView.firstBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.secondBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.thirdBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.fourthBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.fifthBtn setTitleColor:KUIColorFromHex(0xff463c) forState:UIControlStateNormal];
        }
        if (scrollView.contentOffset.x < -KMAINSIZE.width/4) {
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
