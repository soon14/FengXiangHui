//
//  HBNavigationController.m
//  cpzx
//
//  Created by HubinSun on 16/6/13.
//  Copyright © 2016年 HubinSun. All rights reserved.
//

#import "HBNavigationController.h"

@interface HBNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

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
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17]}];

    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
    [self.navigationBar setTintColor:[UIColor whiteColor]];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.navigationBar.frame.size.height-0.5, self.navigationBar.frame.size.width, 0.5)];
    [line setBackgroundColor:KLineColor];
    [self.navigationBar addSubview:line];
}

#pragma mark 解决返回手势失效问题
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if (self.viewControllers.count > 1) {
        return YES;
    } return NO;
}

#pragma mark 重写返回按钮
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        UIBarButtonItem * backBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"erji_fanhui"] style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonItemAction)];
        viewController.navigationItem.leftBarButtonItem = backBarButtonItem;
        [backBarButtonItem setTintColor:KUIColorFromHex(0x9a9a9a)];
    }
    [super pushViewController:viewController animated:animated];
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
