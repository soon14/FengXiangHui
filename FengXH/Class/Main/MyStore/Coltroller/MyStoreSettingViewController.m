//
//  MyStoreSettingViewController.m
//  FengXH
//
//  Created by mac on 2018/8/8.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MyStoreSettingViewController.h"
#import "StoreSettingFirstTableViewCell.h"
#import "StoreSettionSecondTableViewCell.h"
#import "StoreSettionThirdTableViewCell.h"
#import "StoreSettionFourthTableViewCell.h"

@interface MyStoreSettingViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    UIImage *iconImage;//选择的icon图片
    UIImage *shopImage;//选择的店招图片
}

@property(nonatomic,strong)UITableView *settingTableView;

@end

@implementation MyStoreSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"小店设置";
    
    [self.view addSubview:self.settingTableView];
    
    [self settingDataRequest];
    
}
#pragma mark - 数据请求
- (void)settingDataRequest {
//    NSString * urlString = @"r=apply.commission.withdraw";
//    NSString *path = [HBBaseAPI appendAPIurl:urlString];
//    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
//    [DBHUD ShowProgressInview:self.view Withtitle:nil];
//    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:@{@"token":tokenStr} WithSuccessBlock:^(NSDictionary *responseDic) {
//        [DBHUD Hiden:YES fromView:self.view];
//        if ([responseDic[@"status"] integerValue] == 1) {
////            self.dataModel = [ShopkeeperModel yy_modelWithDictionary:responseDic[@"result"]];
//            [self.settingTableView reloadData];
//        } else {
//            [DBHUD ShowInView:self.view withTitle:KRequestError];
//        }
//    } WithFailureBlock:^(NSError *error) {
//        [DBHUD Hiden:YES fromView:self.view];
//        [DBHUD ShowInView:self.view withTitle:KNetworkError];
//    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 4;
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 10;
    } return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view=[[UIView alloc] init];
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(10, 20, KMAINSIZE.width-20, 40)];
    btn.backgroundColor=KUIColorFromHex(0xE9852B);
    [btn setTitle:@"保存设置" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(saveSettingAction) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.cornerRadius=4;
    btn.layer.rasterizationScale = [UIScreen mainScreen].scale;
    btn.layer.shouldRasterize = YES;
    [view addSubview:btn];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {
        return 60;
    }
    else if (indexPath.row==1)
    {
        return 80;
    }
    else if (indexPath.row==2)
    {
        return 130;
    }
    else
    {
        return 80;
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MJWeakSelf;
    if (indexPath.row==0) {
        StoreSettingFirstTableViewCell *firstCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([StoreSettingFirstTableViewCell class])];
        if (!firstCell) {
            firstCell = [[StoreSettingFirstTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([StoreSettingFirstTableViewCell class])];
        }
        return firstCell;
    }
    else if (indexPath.row==1)
    {
        StoreSettionSecondTableViewCell *secondCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([StoreSettionSecondTableViewCell class])];
        if (!secondCell) {
            secondCell = [[StoreSettionSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([StoreSettionSecondTableViewCell class])];
        }
        secondCell.addClick = ^{
            [weakSelf addIconAction];
        };
        return secondCell;
    }
    else if(indexPath.row==2)
    {
        StoreSettionThirdTableViewCell *thirdCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([StoreSettionThirdTableViewCell class])];
        if (!thirdCell) {
            thirdCell = [[StoreSettionThirdTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([StoreSettionThirdTableViewCell class])];
        }
        thirdCell.upLoadClick = ^{
            [weakSelf upLoadImgAction];
        };
        return thirdCell;
    }
    else
    {
        StoreSettionFourthTableViewCell *fourthCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([StoreSettionFourthTableViewCell class])];
        if (!fourthCell) {
            fourthCell = [[StoreSettionFourthTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([StoreSettionFourthTableViewCell class])];
        }
        return fourthCell;
    }
}
#pragma mark------保存设置
-(void)saveSettingAction
{
    
}
#pragma mark-----上传图标
-(void)addIconAction
{
    StoreSettionSecondTableViewCell *iconCell=[self.settingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    [[PhotoHelper sharedInstance] showPhotoActionViewWithController:self andWithBlock:^(id returnValue) {
        
        if (returnValue!=nil) {
            [iconCell.iconBtn setImage:returnValue forState:UIControlStateNormal];
            iconImage=returnValue;
        }
        
    }];
}
#pragma mark----上传店招
-(void)upLoadImgAction
{
    StoreSettionThirdTableViewCell *shopCell=[self.settingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    [[PhotoHelper sharedInstance] showPhotoActionViewWithController:self andWithBlock:^(id returnValue) {
        
        if (returnValue!=nil) {
            [shopCell.imgBtn setImage:returnValue forState:UIControlStateNormal];
            shopImage=returnValue;
        }
        
    }];
}
-(UITableView *)settingTableView
{
    if (!_settingTableView) {
        _settingTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight) style:UITableViewStylePlain];
        _settingTableView.backgroundColor = KTableBackgroundColor;
        _settingTableView.showsVerticalScrollIndicator = NO;
        _settingTableView.dataSource = self;
        _settingTableView.delegate = self;
        _settingTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _settingTableView;
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
