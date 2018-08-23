//
//  MyTeamTableViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/7.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "MyTeamTableViewCell.h"
#import "MyTeamModel.h"

@interface MyTeamTableViewCell ()
//头像
@property(nonatomic,strong)UIImageView *headImgView;
//名字
@property(nonatomic,strong)UILabel *nameLab;
//成为店主时间
@property(nonatomic,strong)UILabel *timeLab;
//手机号
@property(nonatomic,strong)UILabel *phoneLab;
//赚多少钱
@property(nonatomic,strong)UILabel *moneyLab;
//成员数量
@property(nonatomic,strong)UILabel *memberCountLab;

@end

@implementation MyTeamTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        _headImgView=[[UIImageView alloc]init];
        _headImgView.layer.cornerRadius=20;
        _headImgView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        _headImgView.layer.shouldRasterize = YES;
        _headImgView.layer.masksToBounds=YES;
        [self addSubview:_headImgView];
        [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_offset(40);
            make.left.mas_offset(10);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        _nameLab=[[UILabel alloc]init];
        _nameLab.textColor=KUIColorFromHex(0x333333);
        _nameLab.font=KFont(16);
        _nameLab.adjustsFontSizeToFitWidth=YES;
        [self addSubview:_nameLab];
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_headImgView.mas_right).offset(10);
            make.height.mas_offset(20);
            make.top.mas_offset(10);
            make.width.mas_offset(210);
        }];

        
        _timeLab=[[UILabel alloc]init];
        _timeLab.font=KFont(14);
        _timeLab.numberOfLines=0;
        _timeLab.textColor=KUIColorFromHex(0xb2b2b2);
        [self addSubview:_timeLab];
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_headImgView.mas_right).offset(10);
            make.width.mas_offset(200);
            make.top.mas_equalTo(_nameLab.mas_bottom).offset(5);
            make.height.mas_offset(35);
        }];
        
        _phoneLab=[[UILabel alloc]init];
        _phoneLab.font=KFont(14);
        _phoneLab.textColor=KUIColorFromHex(0xb2b2b2);
        [self addSubview:_phoneLab];
        [_phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_headImgView.mas_right).offset(10);
            make.width.mas_offset(200);
            make.top.mas_equalTo(_timeLab.mas_bottom).offset(5);
            make.height.mas_offset(20);
        }];
        
        //竖着的分割线
        UILabel *lineLab=[[UILabel alloc]init];
        lineLab.backgroundColor=KUIColorFromHex(0xb2b2b2);
        [self addSubview:lineLab];
        [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_nameLab.mas_right).offset(0);
            make.width.mas_offset(1);
            make.top.mas_offset(10);
            make.bottom.mas_offset(-10);
        }];
        
        _moneyLab=[[UILabel alloc]init];
        _moneyLab.font=KFont(16);
        _moneyLab.textColor=KUIColorFromHex(0x333333);
        _moneyLab.textAlignment=NSTextAlignmentRight;
        [self addSubview:_moneyLab];
        [_moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.left.mas_equalTo(lineLab.mas_right).offset(0);
            make.top.mas_offset(20);
            make.height.mas_offset(20);
        }];
        
        _memberCountLab=[[UILabel alloc]init];
        _memberCountLab.font=KFont(16);
        _memberCountLab.textColor=KUIColorFromHex(0x333333);
        _memberCountLab.textAlignment=NSTextAlignmentRight;
        [self addSubview:_memberCountLab];
        [_memberCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.left.mas_equalTo(lineLab.mas_right).offset(0);
            make.top.mas_equalTo(_moneyLab.mas_bottom).offset(10);
            make.height.mas_offset(20);
        }];
        
        
        
    }
    return self;
}
-(void)setDataModel:(MyTeamDataModel *)dataModel
{
    [_headImgView setYy_imageURL:[NSURL URLWithString:dataModel.avatar]];
    if (dataModel.icon==1) {
        _nameLab.text=[NSString stringWithFormat:@"⭐️ %@",dataModel.nickname];
    }
    else
    {
        _nameLab.text=dataModel.nickname;
    }
    
    _timeLab.text=dataModel.texts_agent;
    _phoneLab.text=[NSString stringWithFormat:@"手机号:%@",dataModel.mobile];
    _moneyLab.text=[NSString stringWithFormat:@"%@",dataModel.commission_total];
    _memberCountLab.text=dataModel.agentcount;
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
