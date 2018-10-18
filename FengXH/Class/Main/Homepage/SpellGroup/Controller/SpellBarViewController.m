//
//  SpellBarViewController.m
//  FengXH
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellBarViewController.h"
#import "HBNavigationController.h"
#import "SpellHomeViewController.h"//拼团首页
#import "SpellActivityViewController.h"//活动列表
#import "SpellOrderBaseViewController.h"//我的订单
#import "SpellMyViewController.h"//我的团
#import "NPhoneLoginViewController.h"
@interface SpellBarViewController ()<UITabBarDelegate,UITabBarControllerDelegate>

@end

@implementation SpellBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tabBar.backgroundColor = [UIColor whiteColor];
    [self initSubVC];
    self.delegate = self;
    
    [self setSelectedIndex:0];
    
    
    
}
- (void)initSubVC{
    
    SpellHomeViewController * homeVC = [[SpellHomeViewController alloc]init];

    [self setupChildVC:homeVC Title:@"拼团首页" UnselectedImageName:@"home_icon_home_nol" SelectedImageName:@"home_icon_home_nol"];
    
    SpellActivityViewController * allGoodsVC = [[SpellActivityViewController alloc]init];

    [self setupChildVC:allGoodsVC Title:@"活动列表" UnselectedImageName:@"home_icon_all_nol" SelectedImageName:@"home_icon_all_nol"];
    
    SpellOrderBaseViewController * myStoreVC = [[SpellOrderBaseViewController alloc]init];

    [self setupChildVC:myStoreVC Title:@"我的订单" UnselectedImageName:@"home_icon_store_nol" SelectedImageName:@"home_icon_store_nol"];
    
    SpellMyViewController * shopCartVC = [[SpellMyViewController alloc]init];

    [self setupChildVC:shopCartVC Title:@"我的团" UnselectedImageName:@"icon_my" SelectedImageName:@"icon_my"];
    
}

/**
 初始化所有子控制器
 */
- (void)setupChildVC:(UIViewController *)vc Title:(NSString *)title UnselectedImageName:(NSString *)unselectedImageName SelectedImageName:(NSString *)selectedImageName{
    UIImage *unselectedImage = [UIImage imageNamed:unselectedImageName];
    unselectedImage = [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = unselectedImage;
    vc.tabBarItem.selectedImage = selectedImage;
    [self addChildViewController:vc];
    //点击的颜色
    [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:KUIColorFromHex(0xa9a9a9), NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [vc.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:KUIColorFromHex(0x333333), NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    HBNavigationController * navi = [[HBNavigationController alloc]initWithRootViewController:vc];
    self.delegate = self;
    [self addChildViewController:navi];
}



- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    //获得选中的 item

    NSUInteger tabbarIndex = [tabBar.items indexOfObject:item];
    //对应 item 上面的自控制器
    HBNavigationController * HBNavigation = self.childViewControllers[tabbarIndex];
    [(UINavigationController *)HBNavigation popToRootViewControllerAnimated:YES];
    
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    UIViewController *willShowViewController = viewController;
    if ([willShowViewController isKindOfClass:[tabBarController class]]) {
        UITabBarController *tabbar = (UITabBarController *)willShowViewController;
        willShowViewController = tabbar.selectedViewController;
    }
    if ([willShowViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigation = (UINavigationController *)willShowViewController;
        willShowViewController = navigation.visibleViewController;
    }
    
        if ([willShowViewController isKindOfClass:[SpellOrderBaseViewController class]] ||[willShowViewController isKindOfClass:[SpellMyViewController class]]) {
            if (![[NSUserDefaults standardUserDefaults] objectForKey:KUserToken]) {
                NPhoneLoginViewController *loginVC = [[NPhoneLoginViewController alloc] init];
                [self presentViewController:loginVC animated:YES completion:nil];
                return NO;
            }
        }
    return YES;
    
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
