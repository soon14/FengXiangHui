//
//  SpellOrderDetailGoodsCell.m
//  FengXH
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderDetailGoodsCell.h"
#import "SpellOrderDetailModel.h"

@interface SpellOrderDetailGoodsCell ()
//顶部店铺部分的view
@property(nonatomic,strong)UIView *topView;
//店铺名字
@property(nonatomic,strong)UILabel *shopNameLab;
//商品view
@property(nonatomic,strong)UIView *goodsView;
//商品图片
@property(nonatomic,strong)UIImageView *goodsImgView;
//商品名字
@property(nonatomic,strong)UILabel *goodsNameLab;
//单价
@property(nonatomic,strong)UILabel *goodsSinglePriceLab;
//商品数量
@property(nonatomic,strong)UILabel *goodsCountLab;

@end


@implementation SpellOrderDetailGoodsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
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
        
        //左边店铺的图标
        UIImageView *shopIconView=[[UIImageView alloc]init];
        shopIconView.image=[UIImage imageNamed:@"店铺"];
        [_topView addSubview:shopIconView];
        [shopIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.width.mas_offset(14);
            make.height.mas_offset(14);
            make.centerY.mas_equalTo(_topView.mas_centerY);
        }];
        
        _shopNameLab=[[UILabel alloc]init];
        _shopNameLab.textColor=KUIColorFromHex(0x333333);
        _shopNameLab.font=KFont(15);
        [_topView addSubview:_shopNameLab];
        [_shopNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(shopIconView.mas_right).offset(5);
            make.right.mas_equalTo(imgView.mas_left).offset(5);
            make.height.mas_offset(20);
            make.centerY.mas_equalTo(_topView.mas_centerY);
        }];
        
        _goodsView=[[UIView alloc]initWithFrame:CGRectMake(0, 40, KMAINSIZE.width, 100)];
        [self addSubview:_goodsView];
        
        _goodsImgView=[[UIImageView alloc]init];
        [_goodsView addSubview:_goodsImgView];
        [_goodsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.height.width.mas_offset(70);
            make.top.mas_offset(10);
        }];
        
        _goodsNameLab=[[UILabel alloc]init];
        _goodsNameLab.font=KFont(15);
        _goodsNameLab.numberOfLines=0;
        _goodsNameLab.textColor=KUIColorFromHex(0x333333);
        [_goodsView addSubview:_goodsNameLab];
        [_goodsNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_goodsImgView.mas_right).offset(5);
            make.height.mas_offset(40);
            make.top.mas_offset(10);
            make.width.mas_offset(200);
        }];
        
        _goodsSinglePriceLab=[[UILabel alloc]init];
        _goodsSinglePriceLab.textColor=KUIColorFromHex(0x333333);
        _goodsSinglePriceLab.font=KFont(15);
        _goodsSinglePriceLab.textAlignment=NSTextAlignmentRight;
        _goodsSinglePriceLab.adjustsFontSizeToFitWidth=YES;
        [_goodsView addSubview:_goodsSinglePriceLab];
        [_goodsSinglePriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.left.mas_equalTo(_goodsNameLab.mas_right).offset(5);
            make.height.mas_offset(20);
            make.top.mas_offset(10);
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
            make.top.mas_equalTo(_goodsSinglePriceLab.mas_bottom).offset(10);
        }];
        
        
    }
    return self;
}

-(void)setDataModel:(SpellOrderDetailGoodsModel *)dataModel
{
    _shopNameLab.text=dataModel.shopname;
    
    [_goodsImgView setYy_imageURL:[NSURL URLWithString:dataModel.thumb]];
    
    _goodsNameLab.text=dataModel.title;
    
    _goodsSinglePriceLab.text=[NSString stringWithFormat:@"¥%@/1%@",dataModel.groupsprice,dataModel.units];
    
    _goodsCountLab.text=[NSString stringWithFormat:@"*%@",dataModel.goodsnum];
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
