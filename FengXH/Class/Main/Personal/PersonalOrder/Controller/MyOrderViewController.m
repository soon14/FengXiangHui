//
//  MyOrderViewController.m
//  FengXH
//
//  Created by sun on 2018/7/19.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MyOrderViewController.h"

@interface MyOrderViewController ()

@property(nonatomic , assign)NSInteger orderType;

@end

@implementation MyOrderViewController

- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _orderType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 20)];
    [label setText:[NSString stringWithFormat:@"%ld",_orderType]];
    label.center = self.view.center;
    [self.view addSubview:label];
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
