//
//  HBNavigationController.m
//  cpzx
//
//  Created by HubinSun on 16/6/13.
//  Copyright © 2016年 HubinSun. All rights reserved.
//

#import "HBNavigationController.h"

@interface HBNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic , weak) id PopDelegate;

@end

@implementation HBNavigationController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationBar setTranslucent:NO];
//    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont fontWithName:@"Arial" size:24]}];
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    self.PopDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationBar.frame.size.height-0.5, self.navigationBar.frame.size.width, 0.5)];
    [line setBackgroundColor:KLineColor];
    [self.navigationBar addSubview:line];
}

#pragma mark 解决返回手势失效问题
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (viewController == self.viewControllers[0]) {
        self.interactivePopGestureRecognizer.delegate = self.PopDelegate;
    }else{
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}

#pragma mark 重写返回按钮
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    BOOL ishide = [[NSUserDefaults standardUserDefaults] boolForKey:@"hideLeftItem"];
    if (viewController != self.viewControllers[0] && ishide != YES) {
        UIBarButtonItem * backBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"erji_fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonItemAction)];
        viewController.navigationItem.leftBarButtonItem = backBarButtonItem;
        // 去除返回按钮文字
        [backBarButtonItem setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
        [backBarButtonItem setTintColor:KUIColorFromHex(0x9a9a9a)];
    }
}

- (void)backBarButtonItemAction
{
    [self popViewControllerAnimated:YES];
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
