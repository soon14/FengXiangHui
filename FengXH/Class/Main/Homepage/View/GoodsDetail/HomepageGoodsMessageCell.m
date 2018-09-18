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
    /** timer */
    dispatch_source_t _timer;
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
//商品价格view
@property(nonatomic,strong)UIView *priceView;
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


/*****************是秒杀商品的时候那部分秒杀倒计时view*******************/

//秒杀view
@property(nonatomic,strong)UIView *seckillView;
//现价
@property(nonatomic,strong)UILabel *priceLab;
//原价
@property(nonatomic,strong)UILabel *oldPriceLab;
//已出售百分比
@property(nonatomic,strong)UILabel *salePercentLab;
//距结束（开始）还有
@property(nonatomic,strong)UILabel *timeLab;
//倒计时 时
@property(nonatomic,strong)UILabel *hourLab;
//倒计时 分
@property(nonatomic,strong)UILabel *minuteLab;
//倒计时 秒
@property(nonatomic,strong)UILabel *secondLab;

/** day */
@property(nonatomic , copy)NSString *dayString;
/** hour */
@property(nonatomic , copy)NSString *hourString;
/** min */
@property(nonatomic , copy)NSString *minuteString;
/** sec */
@property(nonatomic , copy)NSString *secondString;

/*************************************************************/

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
            make.top.mas_equalTo(self.shareBtn.mas_top);
        }];
        
        [self addSubview:self.describeLab];
        [_describeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.height.mas_offset(0);
            make.top.mas_equalTo(self.nameLab.mas_bottom).offset(5);
        }];
        
        [self addSubview:self.priceView];
        [_priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.top.mas_equalTo(self.describeLab.mas_bottom).offset(0);
            make.height.mas_offset(0);
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
            make.top.mas_equalTo(self.priceView.mas_bottom).offset(5);
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
    if (_goodsMessageModel==nil) {
        
        _goodsMessageModel=goodsMessageModel;
        
        if (![goodsMessageModel.seckillinfo  isEqual:[NSNull null]] && goodsMessageModel.seckillinfo != nil && goodsMessageModel.seckillinfo != NULL ) {
            
            //是秒杀的商品
            [self crecteSeckillUI];
            
            [_shareBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.bannerScrollView.mas_bottom).offset(10+70);
            }];
            
        }
        else
        {
            [_priceView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(30);
            }];
            
            [_priceView addSubview:self.realPriceLab];
            [_realPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_offset(10);
                make.top.mas_offset(0);
            }];
            
            [_priceView addSubview:self.originalPriceLab];
            [_originalPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.realPriceLab.mas_right).offset(10);
                make.right.mas_offset(-10);
                make.height.mas_offset(20);
                make.bottom.mas_equalTo(self.realPriceLab);
            }];
            
        }
        
        
        if (![goodsMessageModel.discounts  isEqual:[NSNull null]] && goodsMessageModel.discounts != nil && goodsMessageModel.discounts != NULL && [goodsMessageModel.discounts.discountsDefault intValue]>0)
        {
            [self createDiscountsUI];
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
                    make.height.mas_offset(40);
                }];
            }
            
        }
    }
    
    _goodsMessageModel=goodsMessageModel;
    
    [self updateData];
    
    
}
#pragma mark-------更新数据
-(void)updateData
{
    codeImgStr=_goodsMessageModel.share_image;
    
    _bannerScrollView.imageURLStringsGroup=_goodsMessageModel.thumb_url;
    
    _nameLab.text=_goodsMessageModel.title;
    
    if (![_goodsMessageModel.subtitle  isEqual:[NSNull null]] && _goodsMessageModel.subtitle != nil && _goodsMessageModel.subtitle != NULL && ![_goodsMessageModel.subtitle isEqualToString:@""]) {
        
        [_describeLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(15);
        }];
        _describeLab.text=_goodsMessageModel.subtitle;
    }
    
    if (_goodsMessageModel.issendfree) {
        _expressPriceLab.text=@"包邮";
    }
    else
    {
        _expressPriceLab.text=_goodsMessageModel.dispatchprice;
    }
    
    _salesCountLab.text=[NSString stringWithFormat:@"%@%@",_goodsMessageModel.sales,_goodsMessageModel.unit];
    
    _areaLab.text=_goodsMessageModel.city;
    
    if (![_goodsMessageModel.seckillinfo  isEqual:[NSNull null]] && _goodsMessageModel.seckillinfo != nil && _goodsMessageModel.seckillinfo != NULL ) {
        
        //是秒杀的商品
        _priceLab.text=[NSString stringWithFormat:@"¥%@",_goodsMessageModel.seckillinfo.price];
        
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:_goodsMessageModel.seckillinfo.oldprice==nil?@"":_goodsMessageModel.seckillinfo.oldprice attributes:attribtDic];
        _oldPriceLab.attributedText=attribtStr;
        
        _salePercentLab.text=[NSString stringWithFormat:@"已出售%ld%%",(long)_goodsMessageModel.seckillinfo.percent];
        
        CGFloat nowTimeStmp = [[ShareManager getNowTimeTimestamp] doubleValue];
        if (nowTimeStmp <= [_goodsMessageModel.seckillinfo.starttime doubleValue]) {
            [self downSecondHandle:_goodsMessageModel.seckillinfo.starttime];
        } else if (nowTimeStmp > [_goodsMessageModel.seckillinfo.starttime doubleValue] && nowTimeStmp < [_goodsMessageModel.seckillinfo.endtime doubleValue]) {
            [self downSecondHandle:_goodsMessageModel.seckillinfo.endtime];
        }
        
    }
    else
    {
        _realPriceLab.text=_goodsMessageModel.marketprice;
        
        NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:_goodsMessageModel.productprice==nil?@"":_goodsMessageModel.productprice attributes:attribtDic];
        _originalPriceLab.attributedText=attribtStr;
    }
    
    if (![_goodsMessageModel.discounts  isEqual:[NSNull null]] && _goodsMessageModel.discounts != nil && _goodsMessageModel.discounts != NULL && [_goodsMessageModel.discounts.discountsDefault intValue]>0) {

        NSString *str=[NSString stringWithFormat:@"%.2f",[_goodsMessageModel.discounts.discountsDefault floatValue]*[_goodsMessageModel.marketprice floatValue]/10];
        NSString *discountsStr =[NSString stringWithFormat:@"可享受¥%@的价格",str];
        NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc] initWithString:discountsStr];
        [attribut setAttributes:@{NSForegroundColorAttributeName:KRedColor} range:[discountsStr rangeOfString:[NSString stringWithFormat:@"¥%@",str]]];
        _discountsLab.attributedText = attribut;
        
    }
}
#pragma mark-------商品二维码
-(void)codeAction
{
    if (!_codeView) {
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        [window addSubview:self.codeView];
        [_codeView.imgView yy_setImageWithURL:[NSURL URLWithString:codeImgStr] placeholder:nil options:YYWebImageOptionProgressiveBlur completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
            [_codeView.imgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_equalTo((KMAINSIZE.width-40)/image.size.width*image.size.height);
            }];
        }];
    }
    else
    {
        _codeView.hidden=NO;
    }
}
#pragma mark-------分享
-(void)shareAction
{
    
    [ShareManager shareWithTitle:_goodsMessageModel.title andMessage:_goodsMessageModel.subtitle andUrl:_goodsMessageModel.share_url andImg:@[_goodsMessageModel.thumb]];
    
}
#pragma mark-------创建秒杀部分的view
-(void)crecteSeckillUI
{
    _seckillView=[[UIView alloc]init];
    _seckillView.backgroundColor = KRedColor;
    [self addSubview:_seckillView];
    [_seckillView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(_bannerScrollView.mas_bottom).offset(0);
        make.height.mas_offset(70);
    }];
    
    _priceLab=[[UILabel alloc]init];
    _priceLab.textColor=[UIColor whiteColor];
    _priceLab.font=KFont(28);
    [_priceLab sizeToFit];
    [_seckillView addSubview:_priceLab];
    [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.mas_equalTo(_seckillView.mas_centerY);
    }];
    
    //原价
    UILabel *lab=[[UILabel alloc]init];
    lab.font=KFont(12);
    lab.text=@"原价";
    lab.textColor=[UIColor whiteColor];
    lab.textAlignment=NSTextAlignmentCenter;
    lab.layer.borderWidth=1;
    lab.layer.borderColor=[UIColor whiteColor].CGColor;
    lab.layer.cornerRadius=4;
    lab.layer.rasterizationScale = [UIScreen mainScreen].scale;
    lab.layer.shouldRasterize = YES;
    [_seckillView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_priceLab.mas_right).offset(10);
        make.width.mas_offset(30);
        make.height.mas_offset(20);
        make.top.mas_offset(10);
    }];
    
    _oldPriceLab=[[UILabel alloc]init];
    _oldPriceLab.font=KFont(14);
    _oldPriceLab.textColor=[UIColor whiteColor];
    [_oldPriceLab sizeToFit];
    [_seckillView addSubview:_oldPriceLab];
    [_oldPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab.mas_left);
        make.bottom.mas_offset(-10);
    }];
    
    UIView *rightView=[[UIView alloc]init];
    rightView.backgroundColor=KUIColorFromHex(0xFCED4F);
    [_seckillView addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_offset(0);
        make.width.mas_offset(105);
    }];
    
    _timeLab=[[UILabel alloc]init];
    _timeLab.textColor=KRedColor;
    _timeLab.font=KFont(14);
    _timeLab.textAlignment=NSTextAlignmentCenter;
    [rightView addSubview:_timeLab];
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(10);
        make.height.mas_offset(20);
    }];
    
    for (int i=0; i<3; i++) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(((105-30)/3+10)*i+5, 40, (105-30)/3, (105-30)/3)];
        label.backgroundColor=[UIColor brownColor];
        label.textColor=[UIColor whiteColor];
        label.font=KFont(14);
        label.textAlignment=NSTextAlignmentCenter;
        label.layer.cornerRadius=4;
        label.layer.rasterizationScale = [UIScreen mainScreen].scale;
        label.layer.shouldRasterize = YES;
        [rightView addSubview:label];
        
        if (i==0||i==1) {
            //创建中间的2个冒号
            UILabel *separateLab=[[UILabel alloc]initWithFrame:CGRectMake(((105-30)/3+10)*i+5+(105-30)/3, 40, 10, (105-30)/3)];
            separateLab.text=@":";
            separateLab.textAlignment=NSTextAlignmentCenter;
            separateLab.textColor=KUIColorFromHex(0x333333);
            [rightView addSubview:separateLab];
            
        }
        
        
        switch (i) {
            case 0:
                _hourLab=label;
                break;
            case 1:
                _minuteLab=label;
                break;
            case 2:
                _secondLab=label;
                break;
            default:
                break;
        }
    }
    
    _salePercentLab=[[UILabel alloc]init];
    _salePercentLab.textColor=[UIColor whiteColor];
    _salePercentLab.font=KFont(14);
    _salePercentLab.textAlignment=NSTextAlignmentRight;
    [_seckillView addSubview:_salePercentLab];
    [_salePercentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(rightView.mas_left).offset(-10);
        make.top.mas_offset(10);
        make.width.mas_offset(100);
        make.height.mas_offset(20);
    }];
    
    //百分比进度条下面的label
    UILabel *lab1=[[UILabel alloc]init];
    lab1.layer.borderWidth=1;
    lab1.layer.borderColor=KUIColorFromHex(0xFCED4F).CGColor;
    lab1.layer.cornerRadius=10;
    lab1.layer.rasterizationScale = [UIScreen mainScreen].scale;
    lab1.layer.shouldRasterize = YES;
    lab1.layer.masksToBounds=YES;
    [_seckillView addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(rightView.mas_left).offset(-10);
        make.bottom.mas_offset(-10);
        make.width.mas_offset(100);
        make.height.mas_offset(20);
    }];
    
    //百分比进度条上面的label
    UILabel *lab2=[[UILabel alloc]init];
    lab2.backgroundColor=KUIColorFromHex(0xFCED4F);
    [lab1 addSubview:lab2];
    CGFloat percentValue=[[NSString stringWithFormat:@"%ld",(long)_goodsMessageModel.seckillinfo.percent] floatValue];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_offset(0);
        make.width.mas_offset(percentValue/100*100);
    }];
}
#pragma mark-------创建折扣上面的UI
-(void)createDiscountsUI
{
    [self addSubview:self.discountsView];
    [_discountsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(self.areaLab.mas_bottom).offset(10);
        make.height.mas_offset(20);
    }];
    
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
//
- (void)downSecondHandle:(NSString *)aTimeString {
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *endDate = [dateFormatter dateFromString:[self timeWithTimeIntervalString:aTimeString]]; //结束时间
    NSDate *endDate_tomorrow = [[NSDate alloc] initWithTimeIntervalSinceReferenceDate:([endDate timeIntervalSinceReferenceDate])];
    NSDate *startDate = [NSDate date];
    NSTimeInterval timeInterval =[endDate_tomorrow timeIntervalSinceDate:startDate];
    
    if (_timer==nil) {
        __block int timeout = timeInterval; //倒计时时间
        if (timeout!=0) {
            MJWeakSelf
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
            dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout<=0){ //倒计时结束，关闭
                    dispatch_source_cancel(_timer);
                    _timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                       
                        weakSelf.hourLab.text=@"00";
                        weakSelf.minuteLab.text=@"00";
                        weakSelf.secondLab.text=@"00";
                        
                    });
                } else {
                    int days = (int)(timeout/(3600*24));
                    if (days==0) {
                        self.dayString = @"";
                    }
                    int hours = (int)((timeout-days*24*3600)/3600);
                    int minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    int second = timeout-days*24*3600-hours*3600-minute*60;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        if (days==0) {
                            self.dayString = @"";
                        } else {
                            self.dayString = [NSString stringWithFormat:@"%d天",days];
                        }
                        if (hours<10) {
                            self.hourString = [NSString stringWithFormat:@"0%d",hours];
                        } else {
                            self.hourString = [NSString stringWithFormat:@"%d",hours];
                        }
                        if (minute<10) {
                            self.minuteString = [NSString stringWithFormat:@"0%d",minute];
                        }else{
                            self.minuteString = [NSString stringWithFormat:@"%d",minute];
                        }
                        if (second<10) {
                            self.secondString = [NSString stringWithFormat:@"0%d",second];
                        }else{
                            self.secondString = [NSString stringWithFormat:@"%d",second];
                        }
                        
                        CGFloat nowTimeStmp = [[ShareManager getNowTimeTimestamp] doubleValue];
                        if (nowTimeStmp <= [_goodsMessageModel.seckillinfo.starttime doubleValue]) {
                            weakSelf.timeLab.text=@"距开始还有";
                            weakSelf.hourLab.text=_hourString;
                            weakSelf.minuteLab.text=_minuteString;
                            weakSelf.secondLab.text=_secondString;
                            
                        } else if (nowTimeStmp > [_goodsMessageModel.seckillinfo.starttime doubleValue] && nowTimeStmp < [_goodsMessageModel.seckillinfo.endtime doubleValue]) {
                            weakSelf.timeLab.text=@"距结束还有";
                            weakSelf.hourLab.text=_hourString;
                            weakSelf.minuteLab.text=_minuteString;
                            weakSelf.secondLab.text=_secondString;
                        }
                    });
                    timeout--;
                }
            });
            dispatch_resume(_timer);
        }
    }
}
//时间戳转换为日期格式(毫秒的时间戳)
- (NSString *)timeWithTimeIntervalString:(NSString *)timeString {
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
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
-(UIView *)priceView
{
    if (!_priceView) {
        _priceView=[[UIView alloc]init];
    }
    return _priceView;
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
