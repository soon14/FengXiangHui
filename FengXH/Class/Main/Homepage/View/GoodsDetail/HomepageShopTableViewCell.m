//
//  HomepageShopTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/7/30.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageShopTableViewCell.h"
#import "HomepageGoodsDetailModel.h"
@interface HomepageShopTableViewCell ()
//店铺logo
@property(nonatomic,strong)UIImageView *shopImgView;
//店铺名字
@property(nonatomic,strong)UILabel *nameLab;
//店铺描述
@property(nonatomic,strong)UILabel *desLab;

@end

@implementation HomepageShopTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        self.backgroundColor=[UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.shopImgView];
        [_shopImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.height.width.mas_offset(50);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        [self addSubview:self.nameLab];
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.shopImgView.mas_right).offset(20);
            make.right.mas_offset(-10);
            make.top.mas_offset(10);
            make.height.mas_offset(20);
        }];
        
        [self addSubview:self.desLab];
        [_desLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.shopImgView.mas_right).offset(20);
            make.right.mas_offset(-10);
            make.top.mas_equalTo(self.nameLab.mas_bottom).offset(5);
            make.bottom.mas_offset(-10);
        }];
        
    }
    return self;
}

-(void)setGoodsShopModel:(HomepageShopdetailModel *)goodsShopModel
{
    [_shopImgView setYy_imageURL:[NSURL URLWithString:goodsShopModel.logo]];
    
    _nameLab.text=goodsShopModel.shopname;
    
    _desLab.text=goodsShopModel.shopDescription;
    
}
#pragma mark----懒加载
-(UIImageView *)shopImgView
{
    if (!_shopImgView) {
        _shopImgView=[[UIImageView alloc]init];
        
    }
    return _shopImgView;
}

-(UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab=[[UILabel alloc]init];
        _nameLab.font=KFont(16);
        _nameLab.textColor=[UIColor blackColor];
    }
    return _nameLab;
}
-(UILabel *)desLab
{
    if (!_desLab) {
        _desLab=[[UILabel alloc]init];
        _desLab.font=KFont(14);
        _desLab.textColor=KUIColorFromHex(0xb2b2b2);
        _desLab.numberOfLines=0;
    }
    return _desLab;
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
