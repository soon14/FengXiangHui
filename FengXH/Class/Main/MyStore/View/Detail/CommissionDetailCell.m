//
//  CommissionDetailCell.m
//  FengXH
//
//  Created by mac on 2018/8/6.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "CommissionDetailCell.h"
#import "CommissionDetailModel.h"

@interface CommissionDetailCell ()
//头像
@property(nonatomic,strong)UIImageView *headImgView;
//名字
@property(nonatomic,strong)UILabel *nameLab;
//中间的大的商品view
@property(nonatomic,strong)UIView *allGoodsView;
//分销等级
@property(nonatomic,strong)UILabel *gradeLab;
//订单编号
@property(nonatomic,strong)UILabel *orderNumLab;
//下单时间
@property(nonatomic,strong)UILabel *timeLab;
//预计佣金
@property(nonatomic,strong)UILabel *predictCommissionLab;


//单个商品背景view
@property(nonatomic,strong)UIView *goodsView;
//商品图片
@property(nonatomic,strong)UIImageView *goodsImgView;
//商品名称
@property(nonatomic,strong)UILabel *goodsName;
//商品数量
@property(nonatomic,strong)UILabel *goodsCountLab;
//单个商品佣金
@property(nonatomic,strong)UILabel *goodsCommissionLab;


@end

@implementation CommissionDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        _headImgView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 25, 25)];
        [self addSubview:_headImgView];
        
        _nameLab=[[UILabel alloc]init];
        _nameLab.font=KFont(18);
        _nameLab.textColor=KUIColorFromHex(0x333333);
        [self addSubview:_nameLab];
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_headImgView.mas_right).offset(10);
            make.centerY.mas_equalTo(_headImgView);
            make.right.mas_offset(-10);
            make.height.mas_offset(20);
        }];
        
        _allGoodsView=[[UIView alloc]init];
        _allGoodsView.backgroundColor=KUIColorFromHex(0xeeeeee);
        [self addSubview:_allGoodsView];
        [_allGoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_headImgView.mas_bottom).offset(10);
            make.left.right.mas_offset(0);
            make.height.mas_offset(0);
        }];
        
        _gradeLab=[[UILabel alloc]init];
        _gradeLab.textColor=KUIColorFromHex(0xb2b2b2);
        _gradeLab.font=KFont(16);
        [self addSubview:_gradeLab];
        [_gradeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.top.mas_equalTo(_allGoodsView.mas_bottom).offset(20);
            make.height.mas_offset(20);
        }];
        
        _orderNumLab=[[UILabel alloc]init];
        _orderNumLab.textColor=KUIColorFromHex(0xb2b2b2);
        _orderNumLab.font=KFont(16);
        [self addSubview:_orderNumLab];
        [_orderNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.top.mas_equalTo(_gradeLab.mas_bottom).offset(5);
            make.height.mas_offset(20);
        }];
        
        _timeLab=[[UILabel alloc]init];
        _timeLab.textColor=KUIColorFromHex(0xb2b2b2);
        _timeLab.font=KFont(16);
        [self addSubview:_timeLab];
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.top.mas_equalTo(_orderNumLab.mas_bottom).offset(5);
            make.height.mas_offset(20);
        }];
        
        //预计佣金上面的分割线
        UILabel *bottomLine=[[UILabel alloc]init];
        bottomLine.backgroundColor=KUIColorFromHex(0xb2b2b2);
        [self addSubview:bottomLine];
        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.height.mas_offset(1);
            make.top.mas_equalTo(_timeLab.mas_bottom).offset(10);
        }];
        
        _predictCommissionLab=[[UILabel alloc]init];
        _predictCommissionLab.textAlignment=NSTextAlignmentRight;
        _predictCommissionLab.font=KFont(16);
        _predictCommissionLab.textColor=KUIColorFromHex(0x333333);
        [self addSubview:_predictCommissionLab];
        [_predictCommissionLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.bottom.mas_offset(-10);
            make.top.mas_equalTo(bottomLine.mas_bottom).offset(10);
            make.left.mas_offset(10);
        }];
        
        
    }
    return self;
}
-(void)setDataModel:(CommissionDetailListModel *)dataModel
{
    _dataModel=dataModel;
    
    [_headImgView setYy_imageURL:[NSURL URLWithString:dataModel.buyer.avatar]];
    
    _nameLab.text=dataModel.buyer.nickname;
    
    _gradeLab.text=[NSString stringWithFormat:@"分销等级：%@",dataModel.level];
    
    _orderNumLab.text=[NSString stringWithFormat:@"订单编号：%@",dataModel.ordersn];
    
    _timeLab.text=[NSString stringWithFormat:@"下单时间：%@",dataModel.createtime];
    
    NSString *str=[NSString stringWithFormat:@"预计佣金：+%@",dataModel.commission];
    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:str];
    [attribut setAttributes:@{NSForegroundColorAttributeName:KUIColorFromHex(0xb2b2b2)} range:[str rangeOfString:@"预计佣金："]];
    _predictCommissionLab.attributedText = attribut;
    
    
    for (UIView *view in _allGoodsView.subviews) {
        [view removeFromSuperview];
    }
    [self createGoodsView];
    
}
-(void)createGoodsView
{
    [_allGoodsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(60*_dataModel.order_goods.count);
    }];
    
    for (int i=0; i<_dataModel.order_goods.count; i++) {
        _goodsView=[[UIView alloc]init];
        [_allGoodsView addSubview:_goodsView];
        [_goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(60*i);
            make.left.right.mas_offset(0);
            make.height.mas_offset(60);
        }];
        
        _goodsImgView=[[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
        [_goodsView addSubview:_goodsImgView];
        
        _goodsName=[[UILabel alloc]init];
        _goodsName.font=KFont(16);
        _goodsName.textColor=KUIColorFromHex(0x333333);
        _goodsName.numberOfLines=0;
        [_goodsView addSubview:_goodsName];
        [_goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goodsImgView.mas_right).offset(10);
            make.height.mas_offset(40);
            make.width.mas_offset(240);
            make.top.mas_offset(0);
        }];
        
        _goodsCountLab=[[UILabel alloc]init];
        _goodsCountLab.textColor=KUIColorFromHex(0xb2b2b2);
        _goodsCountLab.font=KFont(12);
        [_goodsView addSubview:_goodsCountLab];
        [_goodsCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goodsImgView.mas_right).offset(10);
            make.width.mas_offset(240);
            make.top.mas_equalTo(_goodsName.mas_bottom).offset(5);
            make.bottom.mas_offset(-5);
        }];
        
        //商品view里面的竖线
        UILabel *lineLab=[[UILabel alloc]init];
        lineLab.backgroundColor=KUIColorFromHex(0xb2b2b2);
        [_goodsView addSubview:lineLab];
        [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.width.mas_offset(1);
            make.left.mas_equalTo(_goodsName.mas_right).offset(5);
            make.bottom.mas_offset(-10);
        }];
        
        //商品view里面的”预计“
        UILabel *lab=[[UILabel alloc]init];
        lab.text=@"预计";
        lab.textColor=KUIColorFromHex(0x333333);
        lab.textAlignment=NSTextAlignmentRight;
        lab.font=KFont(16);
        [_goodsView addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.height.mas_offset(20);
            make.top.mas_offset(15);
            make.left.mas_equalTo(lineLab.mas_right).offset(5);
        }];
        
        _goodsCommissionLab=[[UILabel alloc]init];
        _goodsCommissionLab.font=KFont(16);
        _goodsCommissionLab.adjustsFontSizeToFitWidth=YES;
        _goodsCommissionLab.textColor=KUIColorFromHex(0x333333);
        _goodsCommissionLab.textAlignment=NSTextAlignmentRight;
        [_goodsView addSubview:_goodsCommissionLab];
        [_goodsCommissionLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.bottom.mas_offset(-5);
            make.top.mas_equalTo(lab.mas_bottom).offset(5);
            make.left.mas_equalTo(lineLab.mas_right).offset(5);
        }];
        
        [_goodsImgView setYy_imageURL:[NSURL URLWithString:[_dataModel.order_goods[i] thumb]]];
        _goodsName.text=[_dataModel.order_goods[i] title];
        _goodsCountLab.text=[NSString stringWithFormat:@"*%@",[_dataModel.order_goods[i] total]];
        _goodsCommissionLab.text=[NSString stringWithFormat:@"+%@",[_dataModel.order_goods[i] commission]];
        
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
