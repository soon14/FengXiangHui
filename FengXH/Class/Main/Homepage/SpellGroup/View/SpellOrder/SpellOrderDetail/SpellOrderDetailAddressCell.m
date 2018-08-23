//
//  SpellOrderDetailAddressCell.m
//  FengXH
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderDetailAddressCell.h"
#import "SpellOrderDetailModel.h"

@interface SpellOrderDetailAddressCell ()
//图标
@property(nonatomic,strong)UIImageView *iconImgView;
//上面的label
@property(nonatomic,strong)UILabel *topLab;
//下面的label
@property(nonatomic,strong)UILabel *bottomLab;
//右侧的箭头
@property(nonatomic,strong)UIImageView *arrowsImgView;

@end

@implementation SpellOrderDetailAddressCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        _iconImgView=[[UIImageView alloc]init];
        [self addSubview:_iconImgView];
        [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(20);
            make.width.height.mas_offset(13);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        _topLab=[[UILabel alloc]init];
        _topLab.textColor=KUIColorFromHex(0x333333);
        _topLab.font=KFont(15);
        _topLab.text=@"#######";
        _topLab.adjustsFontSizeToFitWidth=YES;
        [self addSubview:_topLab];
        [_topLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconImgView.mas_right).offset(20);
            make.top.mas_offset(10);
            make.right.mas_offset(-40);
        }];
        
        
        _bottomLab=[[UILabel alloc]init];
        _bottomLab.textColor=KUIColorFromHex(0xb2b2b2);
        _bottomLab.font=KFont(15);
        _bottomLab.text=@"#######";
        _bottomLab.adjustsFontSizeToFitWidth=YES;
        [self addSubview:_bottomLab];
        [_bottomLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_iconImgView.mas_right).offset(20);
            make.bottom.mas_offset(-10);
            make.right.mas_offset(-40);
        }];
        
    }
    return self;
}

-(void)setDataModel:(SpellOrderDetailAddressModel *)dataModel
{
    _topLab.text=[NSString stringWithFormat:@"%@ %@",dataModel.realname,dataModel.mobile];
    
    
    _bottomLab.text=[NSString stringWithFormat:@"%@%@%@%@%@",dataModel.province,dataModel.city,dataModel.area,dataModel.streetdatavalue,dataModel.address];
}

-(void)setType:(NSInteger)type
{
    if (type==0) {
        [self addSubview:self.arrowsImgView];
        [_arrowsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-20);
            make.height.mas_offset(13);
            make.width.mas_offset(7);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        _topLab.textColor=KRedColor;
        
        _iconImgView.image=[UIImage imageNamed:@"物流"];
        
        [_iconImgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(16);
        }];
    }
    else
    {
        _iconImgView.image=[UIImage imageNamed:@"定位"];
        [_iconImgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(16);
        }];
    }
}
-(UIImageView *)arrowsImgView
{
    if (!_arrowsImgView) {
        _arrowsImgView=[[UIImageView alloc]init];
        _arrowsImgView.image=[UIImage imageNamed:@"home_icon_arrow"];
    }
    return _arrowsImgView;
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
