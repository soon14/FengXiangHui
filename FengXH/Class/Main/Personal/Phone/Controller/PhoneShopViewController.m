//
//  PhoneShopViewController.m
//  FengXH
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PhoneShopViewController.h"

@interface PhoneShopViewController ()

@end

@implementation PhoneShopViewController
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, 22+KBottomHeight, 30, 20)];
    [returnBtn setImage:[UIImage imageNamed:@"erji_fanhui"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(btnTarget:) forControlEvents:UIControlEventTouchUpInside];
    returnBtn.tag = 6001;
    [self.view addSubview:returnBtn];
}
- (void)btnTarget:(UIButton *)sender{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
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
