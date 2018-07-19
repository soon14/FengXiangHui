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
#import "PersonalSectionCell.h"
#import "PersonalFooterView.h"
#import "LoginViewController.h"
#import "MyOrderBaseViewController.h"

@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource>

/** tableView */
@property(nonatomic , strong)UITableView *personalTableView;
/** footerView */
@property(nonatomic , strong)PersonalFooterView *footerView;

@end

@implementation PersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员中心";

    [self.view addSubview:self.personalTableView];
}

#pragma mark - footerView
- (PersonalFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[PersonalFooterView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 50)];
    }
    return _footerView;
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
        _personalTableView.tableFooterView = self.footerView;
    }
    return _personalTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0 || section==5) {
        return 1;
    } return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return 155;
    } else if (indexPath.section==5) {
        return 180;
    } else {
        if (indexPath.row==0) {
            return 44;
        } return 90;
    }
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
            MJWeakSelf
            firstCell.cellClickBlock = ^(NSInteger index) {
                [weakSelf firstCellAction:index];
            };
        }
        return firstCell;
    } else if (indexPath.section==1) {
        //时长金额
        if (indexPath.row==0) {
            PersonalSectionCell *secondSectionCell = [tableView dequeueReusableCellWithIdentifier:@"secondSectionCellID"];
            if (!secondSectionCell) {
                secondSectionCell = [[PersonalSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"secondSectionCellID"];
                [secondSectionCell.titleImageView setImage:[UIImage imageNamed:@"personal_scje"]];
            }
            [secondSectionCell.titleLabel setText:@"时长金额：0元"];
            return secondSectionCell;
        } else {
            PersonalSecondCell *secondCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonalSecondCell class])];
            if (!secondCell) {
                secondCell = [[PersonalSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PersonalSecondCell class])];
                MJWeakSelf
                secondCell.cellClickBlock = ^(NSInteger index) {
                    [weakSelf secondCellAction:index];
                };
            }
            return secondCell;
        }
    } else if (indexPath.section==2) {
        //我的订单
        if (indexPath.row==0) {
            PersonalSectionCell *thirdSectionCell = [tableView dequeueReusableCellWithIdentifier:@"thirdSectionCellID"];
            if (!thirdSectionCell) {
                thirdSectionCell = [[PersonalSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"thirdSectionCellID"];
                [thirdSectionCell.titleImageView setImage:[UIImage imageNamed:@"personal_wodedingdan"]];
                [thirdSectionCell.titleLabel setText:@"我的订单"];
                [thirdSectionCell.moreLabel setText:@"查看全部"];
            }
            return thirdSectionCell;
        } else {
            PersonalThirdCell *thirdCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonalThirdCell class])];
            if (!thirdCell) {
                thirdCell = [[PersonalThirdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PersonalThirdCell class])];
                MJWeakSelf
                thirdCell.cellClickBlock = ^(NSInteger index) {
                    [weakSelf thirdCellAction:index];
                };
            }
            return thirdCell;
        }
    } else if (indexPath.section==3) {
        //我的小店
        if (indexPath.row==0) {
            PersonalSectionCell *fourthSectionCell = [tableView dequeueReusableCellWithIdentifier:@"fourthSectionCellID"];
            if (!fourthSectionCell) {
                fourthSectionCell = [[PersonalSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fourthSectionCellID"];
                [fourthSectionCell.titleImageView setImage:[UIImage imageNamed:@"personal_wodexiaodian"]];
                [fourthSectionCell.titleLabel setText:@"我的小店"];
                [fourthSectionCell.moreLabel setText:@"查看全部"];
            }
            return fourthSectionCell;
        } else {
            PersonalFourthCell *fourthCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonalFourthCell class])];
            if (!fourthCell) {
                fourthCell = [[PersonalFourthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PersonalFourthCell class])];
                MJWeakSelf
                fourthCell.cellClickBlock = ^(NSInteger index) {
                    [weakSelf fourthCellAction:index];
                };
            }
            return fourthCell;
        }
    } else if (indexPath.section==4) {
        //商学院
        if (indexPath.row==0) {
            PersonalSectionCell *fifthSectionCell = [tableView dequeueReusableCellWithIdentifier:@"fifthSectionCellID"];
            if (!fifthSectionCell) {
                fifthSectionCell = [[PersonalSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fifthSectionCellID"];
                [fifthSectionCell.titleImageView setImage:[UIImage imageNamed:@"personal_scje"]];
                [fifthSectionCell.titleLabel setText:@"商学院（开发中...）"];
                [fifthSectionCell.moreLabel setText:@"进入学习"];
            }
            return fifthSectionCell;
        } else {
            PersonalFifthCell *fifthCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonalFifthCell class])];
            if (!fifthCell) {
                fifthCell = [[PersonalFifthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PersonalFifthCell class])];
                MJWeakSelf
                fifthCell.cellClickBlock = ^(NSInteger index) {
                    [weakSelf fifthCellAction:index];
                };
            }
            return fifthCell;
        }
    } else {
        //素材、海报等
        PersonalSixthCell *sixthCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonalSixthCell class])];
        if (!sixthCell) {
            sixthCell = [[PersonalSixthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PersonalSixthCell class])];
        }
        return sixthCell;
    }
}

#pragma mark - didSelectRowAtIndexPath
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            [DBHUD ShowInView:self.view withTitle:@"时长金额"];
        }
    } else if (indexPath.section==2) {
        if (indexPath.row==0) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            MyOrderBaseViewController *allOrderVC = [[MyOrderBaseViewController alloc] initWithType:AllOrder];
            allOrderVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:allOrderVC animated:YES];
        }
    } else if (indexPath.section==3) {
        if (indexPath.row==0) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            [DBHUD ShowInView:self.view withTitle:@"我的小店"];
        }
    } else if (indexPath.section==4) {
        if (indexPath.row==0) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            [DBHUD ShowInView:self.view withTitle:@"商学院"];
        }
    }
}

#pragma mark - 个人资料
- (void)firstCellAction:(NSInteger)index {
    switch (index) {
        case 0: {
            [DBHUD ShowInView:self.view withTitle:@"个人资料"];
        }
            break;
        case 1: {
            [DBHUD ShowInView:self.view withTitle:@"设置"];
            [self presentLoginViewController];
        }
            break;
        case 2: {
            [DBHUD ShowInView:self.view withTitle:@"充值"];
        }
            break;
        case 3: {
            [DBHUD ShowInView:self.view withTitle:@"兑换"];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 通话时长
- (void)secondCellAction:(NSInteger)index {
    switch (index) {
        case 0: {
            [DBHUD ShowInView:self.view withTitle:@"云通话"];
        }
            break;
        case 1: {
            [DBHUD ShowInView:self.view withTitle:@"通话记录"];
        }
            break;
        case 2: {
            [DBHUD ShowInView:self.view withTitle:@"抵扣商城"];
        }
            break;
        case 3: {
            [DBHUD ShowInView:self.view withTitle:@"时长充值"];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 我的订单
- (void)thirdCellAction:(NSInteger)index {
    switch (index) {
        case 0: {
            MyOrderBaseViewController *allOrderVC = [[MyOrderBaseViewController alloc] initWithType:waitingForPayOrder];
            allOrderVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:allOrderVC animated:YES];
        }
            break;
        case 1: {
            MyOrderBaseViewController *allOrderVC = [[MyOrderBaseViewController alloc] initWithType:waitingForSendOrder];
            allOrderVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:allOrderVC animated:YES];
        }
            break;
        case 2: {
            MyOrderBaseViewController *allOrderVC = [[MyOrderBaseViewController alloc] initWithType:waitingForReceiveOrder];
            allOrderVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:allOrderVC animated:YES];
        }
            break;
        case 3: {
            [DBHUD ShowInView:self.view withTitle:@"退换货"];
        }
            break;
        case 4: {
            [self.tabBarController setSelectedIndex:3];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 我的小店
- (void)fourthCellAction:(NSInteger)index {
    switch (index) {
        case 0: {
            [DBHUD ShowInView:self.view withTitle:@"邀请加入"];
        }
            break;
        case 1: {
            [DBHUD ShowInView:self.view withTitle:@"开店礼包"];
        }
            break;
        case 2: {
            [DBHUD ShowInView:self.view withTitle:@"我的团队"];
        }
            break;
        case 3: {
            [DBHUD ShowInView:self.view withTitle:@"佣金收益"];
        }
            break;
        case 4: {
            [DBHUD ShowInView:self.view withTitle:@"店铺管家"];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 商学院
- (void)fifthCellAction:(NSInteger)index {
    switch (index) {
        case 0: {
            [DBHUD ShowInView:self.view withTitle:@"新手攻略"];
        }
            break;
        case 1: {
            [DBHUD ShowInView:self.view withTitle:@"进阶必听"];
        }
            break;
        case 2: {
            [DBHUD ShowInView:self.view withTitle:@"店主风采"];
        }
            break;
        case 3: {
            [DBHUD ShowInView:self.view withTitle:@"空中课堂"];
        }
            break;
        case 4: {
            [DBHUD ShowInView:self.view withTitle:@"活动资讯"];
        }
            break;
            
        default:
            break;
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
