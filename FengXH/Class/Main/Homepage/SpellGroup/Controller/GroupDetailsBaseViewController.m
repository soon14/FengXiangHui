//
//  GroupDetailsBaseViewController.m
//  FengXH
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GroupDetailsBaseViewController.h"
#import "GroupDetailsInforTableViewCell.h"
#import "GrpupGoodsDetailsTableViewCell.h"
@interface GroupDetailsBaseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic , assign)NSInteger spellType;
@property(nonatomic ,strong)UITableView *tableView;
@property(nonatomic ,strong)NSArray *dataArr;
@end

@implementation GroupDetailsBaseViewController
//0 拼团详情  1商品详情
- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _spellType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [self.dic objectForKey:@"orders"];
    [self tableView];
    [self setFootView];
    
}
- (void)setFootView{
    UIImageView *footView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 76)];
    if (self.spellType == 0) {
        if ([[self.dic objectForKey:@"n"] integerValue] == 0) {
            footView.image = [UIImage imageNamed:@"success"];
        }else{
            footView.image = [UIImage imageNamed:@"invitation"];
        }
    }else{
        footView.image = [UIImage imageNamed:@"goods"];
    }
    self.tableView.tableFooterView = footView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KTabbarHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = KTableBackgroundColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollEnabled = NO;
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

    if (self.spellType == 0) {
        return _dataArr.count;
    }else{
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    if (self.spellType == 0) {
        return 70;
    }else{
        return 355;
    }
    
    
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.spellType == 0) {
        static NSString *cellID = @"groupCell";
        [tableView registerClass:[GroupDetailsInforTableViewCell class] forCellReuseIdentifier:cellID];
        GroupDetailsInforTableViewCell *groupCell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        groupCell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *str;
        if (indexPath.row == 0) {
            str = [NSString stringWithFormat:@"%@  开团",[self.dic objectForKey:@"starttime"]];
        }else{
            NSString *str1=[NSString stringWithFormat:@"%@",[self.dataArr[indexPath.row] objectForKey:@"paytime"]];
            int x=[[str1 substringToIndex:10] intValue];
            NSDate  *date = [NSDate dateWithTimeIntervalSince1970:x];
            NSTimeZone *zone = [NSTimeZone systemTimeZone];
            NSInteger interval = [zone secondsFromGMTForDate: date];
            NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
            NSString *dataStr = [NSString stringWithFormat:@"%@",localeDate];
            str = [NSString stringWithFormat:@"%@  参团",[dataStr substringWithRange:NSMakeRange(0, 19)]];
        }
        [groupCell setIcon:[_dataArr[indexPath.row] objectForKey:@"avatar"] AndName:[_dataArr[indexPath.row] objectForKey:@"nickname"] AndTime:str];
        return groupCell;
    }else{
        static NSString *cellID = @"goodsCell";
        [tableView registerClass:[GrpupGoodsDetailsTableViewCell class] forCellReuseIdentifier:cellID];
        GrpupGoodsDetailsTableViewCell *goodsCell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
        goodsCell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSDictionary *dataDic = [self.dic objectForKey:@"requesturl"];
        [goodsCell setImg:[dataDic objectForKey:@"imgUrl"]];
        return goodsCell;
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
