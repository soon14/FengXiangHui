//
//  SpellGroupDetailsViewController.m
//  FengXH
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellGroupDetailsViewController.h"
#import "SDCycleScrollView.h"//轮播
#import "SpellGoodsDetailsFootView.h"//底部三个按钮
#import "SpellGoodsDetailsTableViewCell.h"//商品介绍
#import "SpellGoodsDetailsModel.h"//数据模型
#import "OpenGroupTableViewCell.h"//拼团玩法
#import "SDWebImageCompat.h"
#import "ImagedetailsTableViewCell.h"//详情
#import "SDWebImageFrame.h"
#import "GroupOperatingViewController.h"//团购
#import "CreateGroupOrderViewController.h"//创建订单。单独购买
@interface SpellGroupDetailsViewController ()<SDCycleScrollViewDelegate,SpellGoodsDetailsFootViewDelegate,UITableViewDelegate,UITableViewDataSource>
/** 轮播 */
@property(nonatomic , strong)SDCycleScrollView *bannerScrollView;
@property(nonatomic , strong)UITableView *tableView;
@property(nonatomic , strong)SpellGoodsDetailsFootView *footView;
//data
@property(nonatomic , strong)NSDictionary *dataDic;
@property(nonatomic , strong)NSArray *bannerImageArray;
//商品详情
@property(nonatomic , strong)NSArray *detailsArr;
@property(nonatomic , strong)NSMutableArray *sizeArr;
@property(nonatomic , strong)UIImageView *headerView;
@end

@implementation SpellGroupDetailsViewController
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBar.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"拼团详情";
    
    [self spellHomeDataRequest];
    
    
    
}
- (SpellGoodsDetailsFootView *)footView{
    if (!_footView) {
        _footView = [[SpellGoodsDetailsFootView alloc]initWithFrame:CGRectMake(0, KMAINSIZE.height-50-KNaviHeight-KBottomHeight, KMAINSIZE.width, 50+KBottomHeight)];
        _footView.delegate = self;
        [self.view addSubview:self.footView];
    }
    return _footView;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KTabbarHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = KTableBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)spellHomeDataRequest {
    NSString * urlString = @"r=apply.groups.goods";
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:@{@"token":tokenStr,@"id":self.goodsId} WithSuccessBlock:^(NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 1) {
            self.dataDic = [responseDic objectForKey:@"result"];
            self.bannerImageArray = [self.dataDic objectForKey:@"thumb_url"];
            self.detailsArr = [self.dataDic objectForKey:@"content"];
            _sizeArr = [[NSMutableArray alloc] init];
            NSArray *footArr = @[[self.dataDic objectForKey:@"price"],[self.dataDic objectForKey:@"groupsprice"]];
            
            MJWeakSelf;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                NSArray *content = [_dataDic objectForKey:@"content"];
                for (int i = 0; i<content.count; i++) {
                    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",content[i]]]];
                    UIImage *image = [UIImage imageWithData:data];
                    [weakSelf.sizeArr addObject:[NSString stringWithFormat:@"%f",image.size.height]];
                        
                    }
            dispatch_async(dispatch_get_main_queue(), ^{
                    //线程组执行完毕后的操作 在这里写
                [weakSelf.footView setData:footArr];
                [DBHUD Hiden:YES fromView:self.view];
                if ([self.bannerImageArray isEqual:[NSNull null]]) {
                    
                    [self.headerView setYy_imageURL:[NSURL URLWithString:[self.dataDic objectForKey:@"thumb"]]];
                    self.tableView.tableHeaderView = self.headerView;
                }else{
                    self.bannerScrollView.imageURLStringsGroup = self.bannerImageArray;
                    self.tableView.tableHeaderView = self.bannerScrollView;
                }
                
                        [weakSelf.tableView reloadData];
                        
                    });
                });
                
            
        } else if ([responseDic[@"status"] integerValue] == 401) {
            [self presentLoginViewControllerWithSuccessBlock:^{
                [self spellHomeDataRequest];
            } WithFailureBlock:^{
                
            }];
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
        }
        
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        
    }];
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = [_dataDic objectForKey:@"content"];
    return 2+arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        return 125;
    }else if (indexPath.row == 1){
        return 45;
    }else{
        
        if (_sizeArr.count<1) {
            return 10;
        }else{
            return [_sizeArr[indexPath.row - 2] integerValue]/2;
        }
        
    
    }
    
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = nil;
    if (indexPath.row == 0) {
        cellID = @"titleCell";
    }else if (indexPath.row == 1) {
        cellID = @"openCell";
    }else{
        cellID = @"imageCell";
    }
    if (indexPath.row == 0) {
        [tableView registerClass:[SpellGoodsDetailsTableViewCell class] forCellReuseIdentifier:cellID];
        SpellGoodsDetailsTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        titleCell.selectionStyle = UITableViewCellSelectionStyleNone;
        SpellGoodsDetailsModel *model = [SpellGoodsDetailsModel yy_modelWithDictionary:_dataDic];
        [titleCell setData:model];

        return titleCell;
    }else if(indexPath.row == 1){

        [tableView registerClass:[OpenGroupTableViewCell class] forCellReuseIdentifier:cellID];
        OpenGroupTableViewCell *openCell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        openCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return openCell;
    }else{
        [tableView registerClass:[ImagedetailsTableViewCell class] forCellReuseIdentifier:cellID];
        ImagedetailsTableViewCell *imageCell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        imageCell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *content = [_dataDic objectForKey:@"content"];
        if (_sizeArr.count>0) {
            [imageCell setStr:content[indexPath.row - 2]];
        }
        
        return imageCell;

        
    }

    
        

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
- (SDCycleScrollView *)bannerScrollView {
    if (!_bannerScrollView) {
        _bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 390*KScreenRatio) delegate:self placeholderImage:nil];
        _bannerScrollView.backgroundColor = [UIColor whiteColor];
        
        
    }
    return _bannerScrollView;
}
- (UIImageView *)headerView{
    if (!_headerView) {
        _headerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 390*KScreenRatio)];
    }
    return _headerView;
}
- (void)onItemClick:(NSInteger)data{
    if (data == 0) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (data == 1){
        //单独购买
        NSLog(@"111");
        CreateGroupOrderViewController *vc = [[CreateGroupOrderViewController alloc]init];
        vc.goodsId = self.goodsId;
        vc.type = @"single";
        vc.heads = @"";
        vc.teamid = @"";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (data == 2){
        //团购
        NSLog(@"222");
        GroupOperatingViewController *vc = [[GroupOperatingViewController alloc]init];
        vc.goodsId = self.goodsId;
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
