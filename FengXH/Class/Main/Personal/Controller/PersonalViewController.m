//
//  PersonalViewController.m
//  FengXH
//
//  Created by sun on 2018/7/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalFirstCell.h"
#import "PersonalSecondCell.h"
#import "PersonalThirdCell.h"
#import "PersonalFourthCell.h"
#import "PersonalFifthCell.h"
#import "PersonalSixthCell.h"

@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property(nonatomic , strong)UITableView *personalTableView;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员中心";

    [self.view addSubview:self.personalTableView];
}

#pragma mark - tableView
- (UITableView *)personalTableView {
    if (!_personalTableView) {
        _personalTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KTabbarHeight) style:UITableViewStylePlain];
        _personalTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _personalTableView.backgroundColor = KTableBackgroundColor;
        _personalTableView.showsVerticalScrollIndicator = NO;
        _personalTableView.dataSource = self;
        _personalTableView.delegate = self;
    }
    return _personalTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 150;
    } return 134;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return CGFLOAT_MIN;
    } return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        PersonalFirstCell *firstCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonalFirstCell class])];
        if (!firstCell) {
            firstCell = [[PersonalFirstCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PersonalFirstCell class])];
        }
        return firstCell;
    } else if (indexPath.section==1) {
        //时长金额
        PersonalSecondCell *secondCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonalSecondCell class])];
        if (!secondCell) {
            secondCell = [[PersonalSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PersonalSecondCell class])];
        }
        return secondCell;
    } else if (indexPath.section==2) {
        //我的订单
        PersonalThirdCell *thirdCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonalThirdCell class])];
        if (!thirdCell) {
            thirdCell = [[PersonalThirdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PersonalThirdCell class])];
        }
        return thirdCell;
    } else if (indexPath.section==3) {
        //我的小店
        PersonalFourthCell *fourthCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonalFourthCell class])];
        if (!fourthCell) {
            fourthCell = [[PersonalFourthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PersonalFourthCell class])];
        }
        return fourthCell;
    } else if (indexPath.section==4) {
        //商学院
        PersonalFifthCell *fifthCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonalFifthCell class])];
        if (!fifthCell) {
            fifthCell = [[PersonalFifthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PersonalFifthCell class])];
        }
        return fifthCell;
    } else {
        //素材、海报等
        PersonalSixthCell *sixthCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonalSixthCell class])];
        if (!sixthCell) {
            sixthCell = [[PersonalSixthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PersonalSixthCell class])];
        }
        return sixthCell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
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
