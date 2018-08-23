//
//  HomepageGoodsDetailController.h
//  FengXH
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "BaseViewController.h"

@class HomepageGoodsDetailModel;

typedef void(^GoodsSelectBlock)(void);

@interface HomepageGoodsDetailController : BaseViewController

// tableView
@property(nonatomic , strong)UITableView *goodsTableView;

@property(nonatomic,strong)NSString *selectText;

@property(nonatomic,strong)HomepageGoodsDetailModel *dataModel;

@property(nonatomic , strong)GoodsSelectBlock selectBlock;


- (instancetype)initWithType:(NSInteger)type;//0商品 1详情

-(void)reloadData;



@end
