//
//  MyTabBarController.m
//  cpzx
//
//  Created by HubinSun on 2016/11/21.
//  Copyright © 2016年 HubinSun. All rights reserved.
//

#import "MyTabBarController.h"
#import "HBNavigationController.h"
#import "NHomepageViewController.h"
#import "AllGoodsViewController.h"
#import "MyStoreViewController.h"
#import "ShopCartViewController.h"
#import "PersonalViewController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.backgroundColor = [UIColor whiteColor];
    [self initSubVC];
    
    [self setSelectedIndex:0];
}

/**
 初始化 tabbar
 */

- (void)initSubVC{
    
    NHomepageViewController * homeVC = [[NHomepageViewController alloc]init];
    [self setupChildVC:homeVC Title:@"商城首页" UnselectedImageName:@"home_icon_home_nol" SelectedImageName:@"home_icon_home_nol"];
    
    AllGoodsViewController * allGoodsVC = [[AllGoodsViewController alloc]init];
    [self setupChildVC:allGoodsVC Title:@"全部商品" UnselectedImageName:@"home_icon_all_nol" SelectedImageName:@"home_icon_all_nol"];
    
    MyStoreViewController * myStoreVC = [[MyStoreViewController alloc]init];
    [self setupChildVC:myStoreVC Title:@"我的小店" UnselectedImageName:@"home_icon_store_nol" SelectedImageName:@"home_icon_store_nol"];
    
    ShopCartViewController * shopCartVC = [[ShopCartViewController alloc]init];
    [self setupChildVC:shopCartVC Title:@"购物车" UnselectedImageName:@"home_icon_cart_nol" SelectedImageName:@"home_icon_cart_nol"];
    
    PersonalViewController * personalVC = [[PersonalViewController alloc]init];
    [self setupChildVC:personalVC Title:@"会员中心" UnselectedImageName:@"home_icon_mine_nol" SelectedImageName:@"home_icon_mine_nol"];
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
