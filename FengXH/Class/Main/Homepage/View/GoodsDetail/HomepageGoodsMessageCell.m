//
//  HomepageGoodsMessageCell.m
//  FengXH
//
//  Created by mac on 2018/7/28.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageGoodsMessageCell.h"
#import "HomepageGoodsDetailModel.h"
#import "SDCycleScrollView.h"
#import "HomepageGoodsCodeView.h"


@interface HomepageGoodsMessageCell ()<SDCycleScrollViewDelegate>
{
    NSString *codeImgStr;
}
//顶部banner
@property(nonatomic , strong)SDCycleScrollView *bannerScrollView;
//二维码图片按钮
@property(nonatomic,strong)UIButton *codesBtn;
//分享按钮
@property(nonatomic,strong)UIButton *shareBtn;
//商品名称
@property(nonatomic,strong)UILabel *nameLab;
//商品描述
@property(nonatomic,strong)UILabel *describeLab;
//商品现价
@property(nonatomic,strong)UILabel *realPriceLab;
//商品原价
@property(nonatomic,strong)UILabel *originalPriceLab;
//快递价钱
@property(nonatomic,strong)UILabel *expressPriceLab;
//销量数量
@property(nonatomic,strong)UILabel *salesCountLab;
//是否有货(地址)
@property(nonatomic,strong)UILabel *areaLab;
//折扣
@property(nonatomic,strong)UIView *discountsView;
//折扣label
@property(nonatomic,strong)UILabel *discountsLab;
//标签
@property(nonatomic,strong)UIView *tagsView;


//二维码view
@property(nonatomic,strong)HomepageGoodsCodeView *codeView;


//选择地址

//头像
//xx的小店
//描述
@end
@implementation HomepageGoodsMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        [self addSubview:self.bannerScrollView ];
        
        [self addSubview:self.codesBtn];
        [_codesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.right.mas_offset(-10);
            make.width.height.mas_offset(40);
        }];
        
        [self addSubview:self.shareBtn];
        [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.top.mas_equalTo(self.bannerScrollView.mas_bottom).offset(10);
            make.width.mas_offset(40);
            make.height.mas_offset(40);
        }];
        
        [self addSubview:self.nameLab];
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_equalTo(self.shareBtn.mas_left).offset(-5);
            make.height.mas_offset(40);
            make.top.mas_equalTo(self.bannerScrollView.mas_bottom).offset(10);
        }];
        
        [self addSubview:self.describeLab];
        [_describeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.height.mas_offset(15);
            make.top.mas_equalTo(self.nameLab.mas_bottom).offset(5);
        }];
        
        [self addSubview:self.realPriceLab];
        [_realPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.top.mas_equalTo(self.describeLab.mas_bottom).offset(5);
        }];
        
        [self addSubview:self.originalPriceLab];
        [_originalPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.realPriceLab.mas_right).offset(10);
            make.right.mas_offset(-10);
            make.height.mas_offset(20);
            make.bottom.mas_equalTo(self.realPriceLab);
        }];
        
        //快递
        UILabel *lab1=[[UILabel alloc]init];
        lab1.text=@"快递:";
        lab1.textColor=[UIColor blackColor];
        lab1.font=KFont(14);
        [self addSubview:lab1];
        [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.width.mas_offset(40);
            make.top.mas_equalTo(self.realPriceLab.mas_bottom).offset(10);
            make.height.mas_offset(20);
        }];
        
        [self addSubview:self.expressPriceLab];
        [_expressPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lab1.mas_right).offset(5);
            make.height.top.mas_equalTo(lab1);
        }];
        
        //销量
        UILabel *lab2=[[UILabel alloc]init];
        lab2.text=@"销量:";
        lab2.textColor=[UIColor blackColor];
        lab2.font=KFont(14);
        [self addSubview:lab2];
        [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_offset(40);
            make.left.mas_equalTo(self.expressPriceLab.mas_right).offset(25);
            make.height.top.mas_equalTo(lab1);
        }];
        
        [self addSubview:self.salesCountLab];
        [_salesCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lab2.mas_right).offset(5);
            make.height.top.mas_equalTo(lab1);
        }];
        
        [self addSubview:self.areaLab];
        [_areaLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.height.top.mas_equalTo(lab1);
        }];
        
        
        [self addSubview:self.tagsView];
        [_tagsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.height.mas_offset(0);
        }];
        
        
    }
    return self;
}

-(void)setGoodsMessageModel:(HomepageGoodsDetailModel *)goodsMessageModel
{
    _goodsMessageModel=goodsMessageModel;
    
    codeImgStr=goodsMessageModel.share_image;
    
    _bannerScrollView.imageURLStringsGroup=goodsMessageModel.thumb_url;
    
    _nameLab.text=goodsMessageModel.title;
    
    _describeLab.text=goodsMessageModel.subtitle;
    
    _realPriceLab.text=goodsMessageModel.marketprice;
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:goodsMessageModel.productprice==nil?@"":goodsMessageModel.productprice attributes:attribtDic];
    _originalPriceLab.attributedText=attribtStr;
    
    if (goodsMessageModel.issendfree) {
        _expressPriceLab.text=@"包邮";
    }
    else
    {
        _expressPriceLab.text=goodsMessageModel.dispatchprice;
    }
    
    _salesCountLab.text=[NSString stringWithFormat:@"%@%@",goodsMessageModel.sales,goodsMessageModel.unit];
    
    _areaLab.text=goodsMessageModel.city;
    
    if (![goodsMessageModel.discounts  isEqual:[NSNull null]] && goodsMessageModel.discounts != nil && goodsMessageModel.discounts != NULL && [goodsMessageModel.discounts.discountsDefault intValue]>0) {
        if (!_discountsView) {
            [self addSubview:self.discountsView];
            [_discountsView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_offset(0);
                make.top.mas_equalTo(self.areaLab.mas_bottom).offset(10);
                make.height.mas_offset(20);
            }];
            [self createDiscountsUI];
        }
        NSString *str=[NSString stringWithFormat:@"%.2f",[goodsMessageModel.discounts.discountsDefault floatValue]*[goodsMessageModel.marketprice floatValue]/10];
        NSString *discountsStr =[NSString stringWithFormat:@"可享受¥%@的价格",str];
        NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:discountsStr];
        [attribut setAttributes:@{NSForegroundColorAttributeName:KRedColor} range:[discountsStr rangeOfString:[NSString stringWithFormat:@"¥%@",str]]];
        _discountsLab.attributedText = attribut;
        
    }
    
    if (goodsMessageModel.quality) {
        
        if (_tagsView.subviews.count==0) {
            UILabel *lab=[[UILabel alloc]init];
            lab.text=@"正品保证";
            lab.textColor=[UIColor blackColor];
            lab.font=KFont(12);
            [lab sizeToFit];
            [_tagsView addSubview:lab];
            [lab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(10);
                make.top.mas_offset(10);
            }];
            [_tagsView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(lab.height+20);
            }];
        }
        
    }
    
}

-(void)codeAction
{
    if (!_codeView) {
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        [window addSubview:self.codeView];
//        [_codeView.imgView setYy_imageURL:[NSURL URLWithString:codeImgStr]];
        [_codeView.imgView yy_setImageWithURL:[NSURL URLWithString:codeImgStr] placeholder:nil options:YYWebImageOptionProgressiveBlur completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            [_codeView.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset((KMAINSIZE.width-40)/image.size.width*image.size.height);
            }];
        }];
    }
    else
    {
        _codeView.hidden=NO;
    }
}

-(void)shareAction
{
    
    [ShareManager shareWithTitle:_goodsMessageModel.title andMessage:_goodsMessageModel.subtitle andUrl:_goodsMessageModel.share_url andImg:@[_goodsMessageModel.thumb]];
    
}
//创建折扣上面的UI
-(void)createDiscountsUI
{
    //会员
    UILabel *lab1=[[UILabel alloc]init];
    lab1.font=KFont(16);
    lab1.text=@"会员";
    [_discountsView addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_offset(40);
        make.height.mas_offset(20);
        make.centerY.mas_equalTo(_discountsView);
    }];
    
    //店主
    UILabel *lab2=[[UILabel alloc]init];
    lab2.font=KFont(12);
    lab2.text=@"店主";
    lab2.textAlignment=NSTextAlignmentCenter;
    lab2.textColor=KRedColor;
    lab2.layer.borderColor=KRedColor.CGColor;
    lab2.layer.borderWidth=1;
    [_discountsView addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab1.mas_right).offset(10);
        make.width.mas_offset(35);
        make.height.mas_offset(20);
        make.centerY.mas_equalTo(_discountsView);
    }];
    
    _discountsLab=[[UILabel alloc]init];
    _discountsLab.font=KFont(14);
    [_discountsView addSubview:_discountsLab];
    [_discountsLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab2.mas_right).offset(5);
        make.right.mas_offset(-10);
        make.height.mas_offset(20);
        make.centerY.mas_equalTo(_discountsView);
    }];
    
}

#pragma mark-----懒加载
- (SDCycleScrollView *)bannerScrollView {
    if (!_bannerScrollView) {
        _bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 300) delegate:self placeholderImage:nil];
        _bannerScrollView.backgroundColor = [UIColor whiteColor];;
    }
    return _bannerScrollView;
}
-(UIButton *)codesBtn
{
    if (!_codesBtn) {
        _codesBtn=[[UIButton alloc]init];
        [_codesBtn setImage:[UIImage imageNamed:@"二维码"] forState:UIControlStateNormal];
        [_codesBtn addTarget:self action:@selector(codeAction) forControlEvents:UIControlEventTouchUpInside];
    
    }
    return _codesBtn;
}
- (UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
        [_shareBtn setTag:1];
        [_shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}
-(UILabel *)nameLab
{
    if (!_nameLab) {
        _nameLab=[[UILabel alloc]init];
        _nameLab.font=KFont(16);
        _nameLab.textColor=[UIColor blackColor];
        _nameLab.numberOfLines=0;
    }
    return _nameLab;
}
-(UILabel *)describeLab
{
    if (!_describeLab) {
        _describeLab=[[UILabel alloc]init];
        _describeLab.font=KFont(12);
        _describeLab.textColor=KUIColorFromHex(0xb2b2b2);
    }
    return _describeLab;
}
-(UILabel *)realPriceLab
{
    if (!_realPriceLab) {
        _realPriceLab=[[UILabel alloc]init];
        _realPriceLab.font=KFont(28);
        _realPriceLab.textColor=KRedColor;
        [_realPriceLab sizeToFit];
    }
    return _realPriceLab;
}

-(UILabel *)originalPriceLab
{
    if (!_originalPriceLab) {
        _originalPriceLab=[[UILabel alloc]init];
        _originalPriceLab.font=KFont(14);
        _originalPriceLab.textColor=KUIColorFromHex(0xb2b2b2);
    }
    return _originalPriceLab;
}
-(UILabel *)expressPriceLab
{
    if (!_expressPriceLab) {
        _expressPriceLab=[[UILabel alloc]init];
        _expressPriceLab.font=KFont(14);
        _expressPriceLab.textColor=[UIColor blackColor];
        [_expressPriceLab sizeToFit];
    }
    return _expressPriceLab;
}
-(UILabel *)salesCountLab
{
    if (!_salesCountLab) {
        _salesCountLab=[[UILabel alloc]init];
        _salesCountLab.font=KFont(14);
        _salesCountLab.textColor=[UIColor blackColor];
        [_salesCountLab sizeToFit];
    }
    return _salesCountLab;
}
-(UILabel *)areaLab
{
    if (!_areaLab) {
        _areaLab=[[UILabel alloc]init];
        _areaLab.font=KFont(14);
        _areaLab.textColor=[UIColor blackColor];
        [_areaLab sizeToFit];
    }
    return _areaLab;
}
-(UIView *)discountsView
{
    if (!_discountsView) {
        _discountsView=[[UIView alloc]init];
        
    }
    return _discountsView;
}
-(UIView *)tagsView
{
    if (!_tagsView) {
        _tagsView=[[UIView alloc]init];
        _tagsView.backgroundColor=KTableBackgroundColor;
        
    }
    return _tagsView;
}
-(UIView *)codeView
{
    if (!_codeView) {
        _codeView=[[HomepageGoodsCodeView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KBottomHeight)];
    }
    return _codeView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
