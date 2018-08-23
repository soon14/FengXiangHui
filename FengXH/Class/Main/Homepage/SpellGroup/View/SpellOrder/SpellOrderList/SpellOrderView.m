//
//  SpellOrderView.m
//  FengXH
//
//  Created by mac on 2018/8/9.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderView.h"
#import "SpellOrderListModel.h"

@interface SpellOrderView ()
//type
@property(nonatomic,assign)NSInteger orderType;


@end

@implementation SpellOrderView

-(instancetype)initWithType:(NSInteger)type  andFrame:(CGRect)frame
{
    
    if (self=[super initWithFrame:frame]) {
        
        _orderType=type;
        
        [self createUI];
    }
    
    return self;
    
}
-(void)createUI
{
    _topView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 40)];
    [self addSubview:_topView];
    
    //待付款右边的箭头
    UIImageView *imgView=[[UIImageView alloc]init];
    imgView.image=[UIImage imageNamed:@"home_icon_arrow"];
    [_topView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-20);
        make.width.mas_offset(7);
        make.height.mas_offset(13);
        make.centerY.mas_equalTo(_topView.mas_centerY);
    }];
    
    _statusLab=[[UILabel alloc]init];
    _statusLab.font=KFont(14);
    [_topView addSubview:_statusLab];
    [_statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(imgView.mas_left).offset(-5);
        make.width.mas_offset(50);
        make.height.mas_offset(20);
        make.centerY.mas_equalTo(_topView.mas_centerY);
    }];
    
    _orderNumLab=[[UILabel alloc]init];
    _orderNumLab.textColor=KUIColorFromHex(0x333333);
    _orderNumLab.font=KFont(14);
    [_topView addSubview:_orderNumLab];
    [_orderNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_equalTo(_statusLab.mas_left).offset(5);
        make.height.mas_offset(20);
        make.centerY.mas_equalTo(_topView.mas_centerY);
    }];
    
    _goodsView=[[UIView alloc]initWithFrame:CGRectMake(0, 40, KMAINSIZE.width, 70)];
    _goodsView.backgroundColor=KTableBackgroundColor;
    [self addSubview:_goodsView];
    
    _goodsImgView=[[UIImageView alloc]init];
    [_goodsView addSubview:_goodsImgView];
    [_goodsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.height.width.mas_offset(50);
        make.centerY.mas_equalTo(_goodsView.mas_centerY);
    }];
    
    _goodsNameLab=[[UILabel alloc]init];
    _goodsNameLab.font=KFont(15);
    _goodsNameLab.numberOfLines=0;
    [_goodsView addSubview:_goodsNameLab];
    [_goodsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_goodsImgView.mas_right).offset(5);
        make.height.mas_offset(40);
        make.top.mas_offset(10);
        make.width.mas_offset(200);
    }];
    
    _goodsSinglePriceLab=[[UILabel alloc]init];
    _goodsSinglePriceLab.textColor=KUIColorFromHex(0x333333);
    _goodsSinglePriceLab.font=KFont(14);
    _goodsSinglePriceLab.textAlignment=NSTextAlignmentRight;
    _goodsSinglePriceLab.adjustsFontSizeToFitWidth=YES;
    [_goodsView addSubview:_goodsSinglePriceLab];
    [_goodsSinglePriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.left.mas_equalTo(_goodsNameLab.mas_right).offset(5);
        make.height.mas_offset(20);
        make.top.mas_offset(20);
    }];
    
    _goodsCountLab=[[UILabel alloc]init];
    _goodsCountLab.textColor=KUIColorFromHex(0xb2b2b2);
    _goodsCountLab.font=KFont(13);
    _goodsCountLab.textAlignment=NSTextAlignmentRight;
    _goodsCountLab.adjustsFontSizeToFitWidth=YES;
    [_goodsView addSubview:_goodsCountLab];
    [_goodsCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.left.mas_equalTo(_goodsNameLab.mas_right).offset(5);
        make.height.mas_offset(20);
        make.top.mas_equalTo(_goodsSinglePriceLab.mas_bottom).offset(5);
    }];
    
    _allPriceLab=[[UILabel alloc]init];
    _allPriceLab.textColor=KUIColorFromHex(0x333333);
    _allPriceLab.font=KFont(14);
    _allPriceLab.textAlignment=NSTextAlignmentRight;
    [self addSubview:_allPriceLab];
    [_allPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.top.mas_equalTo(_goodsView.mas_bottom).offset(10);
        make.height.mas_offset(20);
    }];
    
    //底部的线
    UILabel *lineLab=[[UILabel alloc]init];
    lineLab.backgroundColor=KLineColor;
    [self addSubview:lineLab];
    [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
    
    
    switch (_orderType) {
        case 0:
            _statusLab.textColor=KRedColor;
            break;
        case 1:
            _statusLab.textColor=KUIColorFromHex(0x53B862);
            break;
        case 2:
            _statusLab.textColor=KUIColorFromHex(0x333333);
            break;
        case 3:
            _statusLab.textColor=KUIColorFromHex(0x53B862);
            break;
        case 4:
            _statusLab.textColor=KUIColorFromHex(0x333333);
            break;
        default:
            break;
    }
    
    
}

-(void)setDataModel:(SpellOrderListDataModel *)dataModel
{
    
    _orderNumLab.text=[NSString stringWithFormat:@"订单号：%@",dataModel.orderno];
    
    [_goodsImgView setYy_imageURL:[NSURL URLWithString:dataModel.thumb]];
    
    _goodsNameLab.text=dataModel.title;
    
    _goodsCountLab.text=[NSString stringWithFormat:@"*%@",dataModel.goodsnum];
    
    _statusLab.text=dataModel.statusstr;
    
    
    NSString *goodsPrice;
    if (dataModel.is_team==1) {
        goodsPrice=dataModel.groupsprice;
    }
    else
    {
        goodsPrice=dataModel.singleprice;
    }
    NSString *str1=[NSString stringWithFormat:@"¥%@/1%@",goodsPrice,dataModel.units];
    NSMutableAttributedString *attribut1 = [[NSMutableAttributedString alloc] initWithString:str1];
    [attribut1 setAttributes:@{NSForegroundColorAttributeName:KRedColor} range:[str1 rangeOfString:[NSString stringWithFormat:@"¥%@",goodsPrice]]];
    _goodsSinglePriceLab.attributedText = attribut1;
    
    
    NSString *str2=[NSString stringWithFormat:@"运费¥%@元，共%@个商品，总额¥%@元",dataModel.freight,dataModel.goodsnum,dataModel.price];
    NSMutableAttributedString *attribut2 = [[NSMutableAttributedString alloc] initWithString:str2];
    [attribut2 setAttributes:@{NSForegroundColorAttributeName:KRedColor} range:[str2 rangeOfString:[NSString stringWithFormat:@"¥%@",dataModel.freight]]];
    [attribut2 setAttributes:@{NSForegroundColorAttributeName:KRedColor} range:[str2 rangeOfString:dataModel.goodsnum]];
    [attribut2 setAttributes:@{NSForegroundColorAttributeName:KRedColor} range:[str2 rangeOfString:[NSString stringWithFormat:@"¥%@",dataModel.price]]];
    _allPriceLab.attributedText = attribut2;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
