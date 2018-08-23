//
//  PhoneRecordViewController.m
//  FengXH
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PhoneRecordViewController.h"
#import "PhoneRecordTableViewCell.h"
#import <AddressBook/AddressBook.h>
#import "PhoneViewController.h"
@interface PhoneRecordViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic ,strong) NSArray *dataArr;
@property (nonatomic ,strong) UITableView *tableView;
@end

@implementation PhoneRecordViewController

- (void)viewWillAppear:(BOOL)animated{
    self.dataArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"PhoneData"];
    [self.tableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"通话记录";
    self.dataArr = [[NSUserDefaults standardUserDefaults] objectForKey:@"PhoneData"];
    [self tableView];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KTabbarHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
    
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"titleCell";
    [tableView registerClass:[PhoneRecordTableViewCell class] forCellReuseIdentifier:cellID];
    PhoneRecordTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    titleCell.selectionStyle = UITableViewCellSelectionStyleNone;
    [titleCell setTitle:[_dataArr[indexPath.row] objectForKey:@"phoneNum"] andTime:[_dataArr[indexPath.row] objectForKey:@"time"]];
    return titleCell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PhoneViewController *vc = [[PhoneViewController alloc]init];
    vc.phoneNum = [_dataArr[indexPath.row] objectForKey:@"phoneNum"];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
