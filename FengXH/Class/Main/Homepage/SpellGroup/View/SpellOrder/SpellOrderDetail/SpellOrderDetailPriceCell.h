//
//  SpellOrderDetailPriceCell.h
//  FengXH
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpellOrderDetailPriceCell : UITableViewCell

//价钱
@property(nonatomic,strong)UILabel *priceLab;
//标题
@property(nonatomic,strong)UILabel *titleLab;

@property(nonatomic,strong)NSDictionary *dataDic;

@end
