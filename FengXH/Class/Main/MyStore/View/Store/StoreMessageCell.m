//
//  StoreMessageCell.m
//  FengXH
//
//  Created by mac on 2018/7/23.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "StoreMessageCell.h"
#import "StoreModel.h"
@interface StoreMessageCell ()
//头像
@property(nonatomic,strong)UIImageView *headImgView  ;
//名字
@property(nonatomic,strong)UILabel *nameLab;
//职位
@property(nonatomic,strong)UILabel *positionLab;
//推荐人头像
@property(nonatomic,strong)UIImageView *referrerHeadImg;
//推荐人名字
@property(nonatomic,strong)UILabel *referrerName;
//vip图标
@property(nonatomic,strong)UIImageView *vipImageView;
//推荐人职位
@property(nonatomic,strong)UILabel *referrerPosition;
//推荐人电话
@property(nonatomic,strong)UILabel *referrerPhoneNum;
//邀请码
@property(nonatomic,strong)UILabel *inviteCode;
//设置按钮
@property(nonatomic,strong)UIButton *settingButton;

@end
@implementation StoreMessageCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = KRedColor;
        
        [self addSubview:self.headImgView];
//        _headImgView.backgroundColor=[UIColor cyanColor];
        [_headImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(80);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
        }];

        [self addSubview:self.nameLab];
        
        [self addSubview:self.positionLab];
        _positionLab.text=@"<店主>";
        [_positionLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headImgView.mas_right).offset(20);
            make.top.mas_equalTo(self.nameLab.mas_bottom).offset(5);
            make.height.mas_offset(20);
            make.width.mas_offset(60);
        }];
        
        //推荐人
        UILabel *lab=[[UILabel alloc]init];
        lab.text=@"推荐人";
        lab.font = KFont(15);
        lab.textColor = [UIColor whiteColor];
        [self addSubview:lab];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headImgView.mas_right).offset(20);
            make.top.mas_equalTo(self.positionLab.mas_bottom).offset(20);
            make.height.mas_offset(20);
            make.width.mas_offset(50);
        }];
        
        [self addSubview:self.referrerHeadImg];
        [_referrerHeadImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lab.mas_right).offset(5);
            make.width.mas_offset(30);
            make.height.mas_offset(30);
            make.centerY.mas_equalTo(lab.mas_centerY);
        }];
//        _referrerHeadImg.backgroundColor=[UIColor blueColor];
        
        [self addSubview:self.referrerName];
        [_referrerName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.referrerHeadImg.mas_right).offset(5);
            make.width.mas_offset(20);
            make.height.mas_offset(20);
            make.centerY.mas_equalTo(lab.mas_centerY);
        }];
        
        /*
        //vip
        [self addSubview:self.vipImageView];
        [_vipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(15);
            make.height.mas_offset(15);
            make.left.mas_equalTo(self.referrerName.mas_right).offset(5);
            make.centerY.mas_equalTo(self.referrerName.mas_centerY);
        }];
        
        [self addSubview:self.referrerPosition];
        [_referrerPosition mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.vipImageView.mas_right).offset(5);
            make.right.mas_offset(-10);
            make.height.mas_offset(20);
            make.centerY.mas_equalTo(lab.mas_centerY);
        }];
        _referrerPosition.text=@"(罗经理)";
        */
         
        [self addSubview:self.referrerPhoneNum];
        [_referrerPhoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headImgView.mas_right).offset(20);
            make.top.mas_equalTo(lab.mas_bottom).offset(10);
            make.height.mas_offset(20);
            make.right.mas_offset(-10);
        }];
        
        [self addSubview:self.inviteCode];
        [_inviteCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.headImgView.mas_right).offset(20);
            make.top.mas_equalTo(self.referrerPhoneNum.mas_bottom).offset(10);
            make.height.mas_offset(20);
            make.right.mas_offset(-10);
        }];
        
        //底部的线
        UILabel *lineLab=[[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-1, KMAINSIZE.width, 1)];
        lineLab.backgroundColor=[UIColor whiteColor];
        [self addSubview:lineLab];
        
        [self.contentView addSubview:self.settingButton];
        [self.settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.right.mas_offset(-0);
            make.width.height.mas_equalTo(45);
        }];
        
    }
    return self;
}
-(void)setStoreMessageData:(StoreModel *)storeMessageData
{
    [_headImgView setYy_imageURL:[NSURL URLWithString:storeMessageData.avatar]];
    _nameLab.text=storeMessageData.nickname;
    [_referrerHeadImg setYy_imageURL:[NSURL URLWithString:storeMessageData.uavatar]];
    _referrerName.text=storeMessageData.upmember;
    _referrerPhoneNum.text=[NSString stringWithFormat:@"推荐人电话:%@",storeMessageData.umobile];
    _inviteCode.text=[NSString stringWithFormat:@"邀请码:%@",storeMessageData.mid];
    
    [_referrerName mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(self.referrerName.text.length*15+5);
    }];
}
#pragma mark - buttonAction
- (void)cellButtonAction
{
    if (self.cellClickBlock) {
        self.cellClickBlock();
    }
}
#pragma mark----懒加载
-(UIImageView *)headImgView
{
    if (!_headImgView) {
        _headImgView=[[UIImageView alloc] init];
        _headImgView.layer.cornerRadius=40;
        _headImgView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        _headImgView.layer.shouldRasterize = YES;
        _headImgView.layer.masksToBounds=YES;
    }
    return _headImgView;
}
-(UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(110, 10, KMAINSIZE.width-120, 20)];
        _nameLab.font = KFont(15);
        _nameLab.textColor = [UIColor whiteColor];
    }
    return _nameLab;
}
-(UILabel *)positionLab
{
    if (!_positionLab) {
        _positionLab = [[UILabel alloc] init];
        _positionLab.font = KFont(14);
        _positionLab.textColor = [UIColor orangeColor];
        _positionLab.textAlignment=NSTextAlignmentCenter;
        _positionLab.layer.cornerRadius=10;
        _positionLab.layer.rasterizationScale = [UIScreen mainScreen].scale;
        _positionLab.layer.shouldRasterize = YES;
        _positionLab.layer.borderColor=[UIColor whiteColor].CGColor;
        _positionLab.layer.borderWidth=1;
    }
    return _positionLab;
}
-(UIImageView *)referrerHeadImg
{
    if (!_referrerHeadImg) {
        _referrerHeadImg=[[UIImageView alloc] init];
        _referrerHeadImg.layer.cornerRadius=15;
        _referrerHeadImg.layer.rasterizationScale = [UIScreen mainScreen].scale;
        _referrerHeadImg.layer.shouldRasterize = YES;
        _referrerHeadImg.layer.masksToBounds=YES;
    }
    return _referrerHeadImg;
}
-(UILabel *)referrerName
{
    if (!_referrerName) {
        _referrerName = [[UILabel alloc] init];
        _referrerName.font = KFont(15);
        _referrerName.textColor = [UIColor whiteColor];
    }
    return _referrerName;
}
-(UIImageView *)vipImageView
{
    if (!_vipImageView) {
        _vipImageView=[[UIImageView alloc] init];
        
    }
    return _vipImageView;
}
-(UILabel *)referrerPosition
{
    if (!_referrerPosition) {
        _referrerPosition = [[UILabel alloc] init];
        _referrerPosition.font = KFont(15);
        _referrerPosition.textColor = [UIColor whiteColor];
    }
    return _referrerPosition;
}
-(UILabel *)referrerPhoneNum
{
    if (!_referrerPhoneNum) {
        _referrerPhoneNum = [[UILabel alloc] init];
        _referrerPhoneNum.font = KFont(15);
        _referrerPhoneNum.textColor = [UIColor whiteColor];
    }
    return _referrerPhoneNum;
}
-(UILabel *)inviteCode
{
    if (!_inviteCode) {
        _inviteCode = [[UILabel alloc] init];
        _inviteCode.font = KFont(15);
        _inviteCode.textColor = [UIColor whiteColor];
    }
    return _inviteCode;
}
- (UIButton *)settingButton
{
    if (!_settingButton) {
        _settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_settingButton setImage:[UIImage imageNamed:@"personal_btn_set"] forState:UIControlStateNormal];
        [_settingButton setTag:1];
        [_settingButton addTarget:self action:@selector(cellButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_settingButton setHidden:YES];
    }
    return _settingButton;
}


@end
