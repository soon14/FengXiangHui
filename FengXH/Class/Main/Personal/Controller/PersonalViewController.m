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
#import "PersonalDataModel.h"
#import "ChangePasswordViewController.h"
#import "AddressListViewController.h"
#import "MyFocusViewController.h"
#import "MyFootprintViewController.h"
#import "PhoneViewController.h"
#import "PhoneRecordViewController.h"
#import "PhoneShopViewController.h"
#import "PhoneLengthViewController.h"
#import "WebJumpViewController.h"
#import "RefundChangeViewController.h"
#import "PaySuccessViewController.h"
#import "PersonalSettingViewController.h"
#import "PersonalMessageViewController.h"
#import "MyTeamBaseViewController.h"
#import "ShopkeeperCommissionViewController.h"
#import "PromotionPosterViewController.h"
#import "PhoneTopUpViewController.h"
#import "PersonalTopUpViewController.h"
#import "ArticleListViewController.h"
#import "FreshViewController.h"

@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource,CustomActionSheetDelagate>

/** tableView */
@property(nonatomic , strong)UITableView *personalTableView;
/** footerView */
@property(nonatomic , strong)PersonalFooterView *footerView;
/** 数据模型 */
@property(nonatomic , strong)PersonalDataModel *dataModel;

@end

@implementation PersonalViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self requestPersonalViewControllerDada];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"会员中心";

    [self.view addSubview:self.personalTableView];
        
}

#pragma mark - 个人中心数据请求
- (void)requestPersonalViewControllerDada {
    NSString * urlString = @"r=apply.personal";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSDictionary *paramDic = [NSDictionary dictionaryWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken],@"token", nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
//        NSLog(@"%@",responseDic);
        if ([responseDic[@"status"] integerValue] == 1) {
            
            self.dataModel = [PersonalDataModel yy_modelWithDictionary:responseDic[@"result"]];

            [self.personalTableView reloadData];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    
    }];
    
}


#pragma mark - footerView
- (PersonalFooterView *)footerView {
    if (!_footerView) {
        _footerView = [[PersonalFooterView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 150)];
        MJWeakSelf
        _footerView.clickBlock = ^(NSInteger index) {
            [weakSelf footerViewAction:index];
        };
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
        _personalTableView.estimatedRowHeight = 0;
        _personalTableView.estimatedSectionHeaderHeight = 0;
        _personalTableView.estimatedSectionFooterHeight = 0;
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
    } else if (indexPath.section==4) {
        //商学院
        return  CGFLOAT_MIN;
    } else {
        if (indexPath.row==0) {
            return 44;
        } return 90;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0 || section==4) {
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
            firstCell.cellClickBlock = ^(NSInteger index) {
                [self firstCellAction:index];
            };
        }
        firstCell.personalDataModel = self.dataModel;
        return firstCell;
    } else if (indexPath.section==1) {
        //时长金额
        if (indexPath.row==0) {
            PersonalSectionCell *secondSectionCell = [tableView dequeueReusableCellWithIdentifier:@"secondSectionCellID"];
            if (!secondSectionCell) {
                secondSectionCell = [[PersonalSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"secondSectionCellID"];
                [secondSectionCell.titleImageView setImage:[UIImage imageNamed:@"personal_scje"]];
            }
            [secondSectionCell.titleLabel setText:@"时长金额"];
            return secondSectionCell;
        } else {
            PersonalSecondCell *secondCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonalSecondCell class])];
            if (!secondCell) {
                secondCell = [[PersonalSecondCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PersonalSecondCell class])];
                secondCell.cellClickBlock = ^(NSInteger index) {
                    [self secondCellAction:index];
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
                thirdCell.cellClickBlock = ^(NSInteger index) {
                    [self thirdCellAction:index];
                };
            }
            thirdCell.staticsModel = self.dataModel.statics;
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
                fourthCell.cellClickBlock = ^(NSInteger index) {
                    [self fourthCellAction:index];
                };
            }
            return fourthCell;
        }
    } else if (indexPath.section==4) {
        //商学院
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        return cell;
//        if (indexPath.row==0) {
//            PersonalSectionCell *fifthSectionCell = [tableView dequeueReusableCellWithIdentifier:@"fifthSectionCellID"];
//            if (!fifthSectionCell) {
//                fifthSectionCell = [[PersonalSectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"fifthSectionCellID"];
//                [fifthSectionCell.titleImageView setImage:[UIImage imageNamed:@"personal_scje"]];
//                [fifthSectionCell.titleLabel setText:@"商学院（开发中...）"];
//                [fifthSectionCell.moreLabel setText:@"进入学习"];
//            }
//            return fifthSectionCell;
//        } else {
//            PersonalFifthCell *fifthCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonalFifthCell class])];
//            if (!fifthCell) {
//                fifthCell = [[PersonalFifthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PersonalFifthCell class])];
//                fifthCell.cellClickBlock = ^(NSInteger index) {
//                    [self fifthCellAction:index];
//                };
//            }
//            return fifthCell;
//        }
    } else {
        //素材、海报等
        PersonalSixthCell *sixthCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([PersonalSixthCell class])];
        if (!sixthCell) {
            sixthCell = [[PersonalSixthCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([PersonalSixthCell class])];
            sixthCell.cellClickBlock = ^(NSInteger index) {
                [self sixthCellAction:index];
            };
        }
        return sixthCell;
    }
}

#pragma mark - didSelectRowAtIndexPath
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            PhoneTopUpViewController *vc = [[PhoneTopUpViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
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
            self.tabBarController.selectedIndex=2;
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
    UIViewController *vc;
    switch (index) {
        case 0: {
            PersonalMessageViewController *mVC=[[PersonalMessageViewController alloc]init];
            mVC.headUrlStr=_dataModel.avatar;
            mVC.nickName=_dataModel.nickname;
            vc=mVC;
        }
            break;
        case 1: {
            
            vc=[[PersonalSettingViewController alloc]init];

        }
            break;
        case 2: {
            //[DBHUD ShowInView:self.view withTitle:@"充值"];
            PersonalTopUpViewController *vc = [[PersonalTopUpViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            vc.str = _dataModel.credit2;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
        case 3: {
            //积分兑换
            WebJumpViewController *webVC = [[WebJumpViewController alloc] init];
            webVC.jumpURL = @"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=diypage&id=29";
            webVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webVC animated:YES];
            
        }
            break;
            
        default:
            break;
    }
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 通话时长
- (void)secondCellAction:(NSInteger)index {
    switch (index) {
        case 0: {
            
            PhoneViewController *phoneVC = [[PhoneViewController alloc]init];
            phoneVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:phoneVC animated:YES];
        }
            break;
        case 1: {
            
            PhoneRecordViewController *vc = [[PhoneRecordViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2: {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://shop.xmhualao.com/home/index?id=e1106916-a66c-4e9c-9693-3d9c6aeeb1b0"]];
            
        }
            break;
        case 3: {
            [DBHUD ShowInView:self.view withTitle:@"时长充值"];
            PhoneLengthViewController *vc = [[PhoneLengthViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
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
            RefundChangeViewController *VC = [[RefundChangeViewController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
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
    UIViewController *vc;
    switch (index) {
        case 0: {
            [DBHUD ShowInView:self.view withTitle:@"邀请加入"];
        }
            break;
        case 1: {
            [DBHUD ShowInView:self.view withTitle:@"开店礼包"];
            NSString *jumpURLString = @"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=apply.diypage&id=156";
            FreshViewController *vc = [[FreshViewController alloc]init];
            vc.urlStr = jumpURLString;
            vc.typeColor = @"white";
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2: {
            vc=[[MyTeamBaseViewController alloc]init];
        }
            break;
        case 3: {
            vc=[[ShopkeeperCommissionViewController alloc]init];
        }
            break;
        case 4: {
            [DBHUD ShowInView:self.view withTitle:@"店铺管家"];
        }
            break;
            
        default:
            break;
    }
    vc.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:vc animated:YES];
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

#pragma mark -  素材、海报、优惠券、活动资讯、收藏、足迹、地址、邀请
- (void)sixthCellAction:(NSInteger)index {
    switch (index) {
        case 0: {
            //我的素材
            /** 跳转至赏金文章 */
            ArticleListViewController *articleVC = [[ArticleListViewController alloc] init];
            articleVC.jumpURL = @"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=article.list";
            articleVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:articleVC animated:YES];
        }
            break;
        case 1: {
            PromotionPosterViewController *vc=[[PromotionPosterViewController alloc]init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2: {
            WebJumpViewController *webVC = [[WebJumpViewController alloc] init];
            webVC.jumpURL = @"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=sale.coupon.my";
            webVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webVC animated:YES];
        }
            break;
        case 3: {//兑换码
            WebJumpViewController *webVC = [[WebJumpViewController alloc] init];
            webVC.jumpURL = [NSString stringWithFormat:@"https://www.vipfxh.com/app/index.php?i=7&c=entry&m=ewei_shopv2&do=mobile&r=exchange&codetype=1&all=1&token=%@",[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken]];
            webVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:webVC animated:YES];
        }
            break;
        case 4: {
            MyFocusViewController *VC = [[MyFocusViewController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 5: {
            MyFootprintViewController *VC = [[MyFootprintViewController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 6: {
            AddressListViewController *VC = [[AddressListViewController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 7: {
            [DBHUD ShowInView:self.view withTitle:@"邀请绑定"];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - 修改密码、退出登录
- (void)footerViewAction:(NSInteger)index {
    switch (index) {
        case 0: {
            ChangePasswordViewController *VC = [[ChangePasswordViewController alloc] init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
        case 1: {
            CustomActionSheet *sheet = [[CustomActionSheet alloc]initWithTitle:@"是否确定退出登录" otherButtonTitles:@[@"确定"]];
            sheet.delegate = self;
            [sheet show];
            
        }
            break;
        default:
            break;
    }
}

#pragma mark - CustomActionSheetDelegate
- (void)sheet:(CustomActionSheet *)sheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [ShareManager clearUserInfo];
    [self.tabBarController setSelectedIndex:0];
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
