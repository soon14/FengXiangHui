//
//  IntegralGoodsDetailInfoCell.m
//  FengXH
//
//  Created by sun on 2018/9/28.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "IntegralGoodsDetailGoodsInfoCell.h"
#import "IntegralGoodsDetailResultModel.h"

@interface IntegralGoodsDetailGoodsInfoCell ()
{
    /** timer */
    dispatch_source_t _timer;
}
/** day */
@property(nonatomic , copy)NSString *dayString;
/** hour */
@property(nonatomic , copy)NSString *hourString;
/** min */
@property(nonatomic , copy)NSString *minuteString;
/** sec */
@property(nonatomic , copy)NSString *secondString;

/** 商品图 */
@property(nonatomic , strong)UIImageView *goodsImageView;
/** 商品名 */
@property(nonatomic , strong)UILabel *goodsNameLabel;
/** 邮费 */
@property(nonatomic , strong)UILabel *freightLabel;
/** 积分+价格 */
@property(nonatomic , strong)UILabel *priceLabel;
/** 原价 */
@property(nonatomic , strong)UILabel *productPriceLabel;
/** 倒计时 */
@property(nonatomic , strong)UILabel *countDownLabel;

@end

@implementation IntegralGoodsDetailGoodsInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.goodsImageView];
        [self.goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_offset(0);
            make.height.mas_equalTo(360*KScreenRatio);
        }];
        
        [self.goodsImageView addSubview:self.countDownLabel];
        [self.countDownLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_offset(0);
            make.height.mas_equalTo(40);
        }];
        
        [self.contentView addSubview:self.goodsNameLabel];
        [self.goodsNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.top.mas_equalTo(_goodsImageView.mas_bottom).offset(20);
            make.right.mas_offset(-15);
        }];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:KLineColor];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.top.mas_equalTo(_goodsImageView.mas_bottom).offset(75);
            make.height.mas_equalTo(0.5);
        }];
        
        [self.contentView addSubview:self.freightLabel];
        [self.freightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(15);
            make.top.mas_equalTo(line.mas_bottom).offset(20);
        }];
        
        [self.contentView addSubview:self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_freightLabel.mas_left);
            make.top.mas_equalTo(_freightLabel.mas_bottom).offset(10);
        }];
        
        [self.contentView addSubview:self.productPriceLabel];
        [self.productPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(_priceLabel.mas_bottom).offset(-5);
            make.right.mas_offset(-20);
        }];
        
    }
    return self;
}

- (void)setDetailResultModel:(IntegralGoodsDetailResultModel *)detailResultModel {
    _detailResultModel = detailResultModel;
    //商品图片
    [self.goodsImageView setYy_imageURL:[NSURL URLWithString:_detailResultModel.thumb]];
    //商品类型
    if (_detailResultModel.goodstype == 0) {
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" 商品  %@",_detailResultModel.title]];
        [aString addAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:KRedColor} range:NSMakeRange(0, 4)];
        [self.goodsNameLabel setAttributedText:aString];
    } else if (_detailResultModel.goodstype == 1) {
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" 优惠券  %@",_detailResultModel.title]];
        [aString addAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:KRedColor} range:NSMakeRange(0, 5)];
        [self.goodsNameLabel setAttributedText:aString];
    } else if (_detailResultModel.goodstype == 2) {
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" 余额  %@",_detailResultModel.title]];
        [aString addAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:KRedColor} range:NSMakeRange(0, 4)];
        [self.goodsNameLabel setAttributedText:aString];
    } else if (_detailResultModel.goodstype == 3) {
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" 红包  %@",_detailResultModel.title]];
        [aString addAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:KRedColor} range:NSMakeRange(0, 4)];
        [self.goodsNameLabel setAttributedText:aString];
    } else {
        NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" 其他  %@",_detailResultModel.title]];
        [aString addAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSBackgroundColorAttributeName:KRedColor} range:NSMakeRange(0, 4)];
        [self.goodsNameLabel setAttributedText:aString];
    }
    //邮费
    if ([_detailResultModel.dispatch floatValue] > 0) {
        [self.freightLabel setText:[NSString stringWithFormat:@"邮费：¥%.2lf",[_detailResultModel.dispatch floatValue]]];
    } else {
        [self.freightLabel setText:@"免邮费"];
    }
    //积分、价格
    if ([_detailResultModel.money floatValue] > 0) {
        NSString *creditString = [NSString stringWithFormat:@"%ld",(long)_detailResultModel.credit];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@积分 + ¥%.2lf",creditString,[_detailResultModel.money floatValue]]];
        [attributedString addAttributes:@{NSFontAttributeName:KFont(12)} range:NSMakeRange(creditString.length, 2)];
        NSRange range = [[NSString stringWithFormat:@"%@积分 + ¥%.2lf",creditString,[_detailResultModel.money floatValue]] rangeOfString:@"¥"];
        [attributedString addAttributes:@{NSFontAttributeName:KFont(15)} range:range];
        [self.priceLabel setAttributedText:attributedString];
    } else {
        NSString *creditString = [NSString stringWithFormat:@"%ld",(long)_detailResultModel.credit];
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@积分",creditString]];
        [attributedString addAttributes:@{NSFontAttributeName:KFont(12)} range:NSMakeRange(creditString.length, 2)];
        [self.priceLabel setAttributedText:attributedString];
    }
    //原价
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"原价：¥%.2lf",[_detailResultModel.price floatValue]]];
    [attString addAttributes:@{NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid), NSStrikethroughColorAttributeName:[UIColor lightGrayColor], NSBaselineOffsetAttributeName:@(0)} range:NSMakeRange(0, attString.length)];
    [self.productPriceLabel setAttributedText:attString];
    if (_detailResultModel.timeend) {
        [self.countDownLabel setHidden:NO];
        [self downSecondHandle:_detailResultModel.timeend];
    }
}

#pragma mark - 倒计时
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
                        [weakSelf.countDownLabel setText:[NSString stringWithFormat:@"\t\t\t\t剩余 00:00:00"]];
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
                            self.dayString = @"0";
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
                        if (nowTimeStmp <= [_detailResultModel.timeend doubleValue]) {
                            [weakSelf.countDownLabel setText:[NSString stringWithFormat:@"\t\t\t\t剩余 %@天%@小时%@分%@秒", _dayString, _hourString, _minuteString, _secondString]];
                        } else if (nowTimeStmp > [_detailResultModel.timeend doubleValue] && nowTimeStmp < [_detailResultModel.timeend doubleValue]) {
                            [weakSelf.countDownLabel setText:[NSString stringWithFormat:@"\t\t\t\t剩余 %@天%@小时%@分%@秒", _dayString, _hourString, _minuteString, _secondString]];
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


#pragma mark - lazy
- (UILabel *)countDownLabel {
    if (!_countDownLabel) {
        _countDownLabel = [[UILabel alloc] init];
        [_countDownLabel setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.15]];
        [_countDownLabel setTextColor:[UIColor whiteColor]];
        [_countDownLabel setFont:KFont(14)];
        [_countDownLabel setHidden:YES];
    }
    return _countDownLabel;
}

- (UILabel *)productPriceLabel {
    if (!_productPriceLabel) {
        _productPriceLabel = [[UILabel alloc] init];
        [_productPriceLabel setTextColor:KUIColorFromHex(0x999999)];
        [_productPriceLabel setFont:KFont(12)];
    }
    return _productPriceLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        [_priceLabel setTextColor:KRedColor];
        [_priceLabel setFont:KFont(24)];
    }
    return _priceLabel;
}

- (UILabel *)freightLabel {
    if (!_freightLabel) {
        _freightLabel = [[UILabel alloc] init];
        [_freightLabel setTextColor:KUIColorFromHex(0x999999)];
        [_freightLabel setFont:KFont(12)];
    }
    return _freightLabel;
}

- (UILabel *)goodsNameLabel {
    if (!_goodsNameLabel) {
        _goodsNameLabel = [[UILabel alloc] init];
        [_goodsNameLabel setTextColor:KUIColorFromHex(0x333333)];
        [_goodsNameLabel setFont:KFont(15)];
        [_goodsNameLabel setNumberOfLines:2];
    }
    return _goodsNameLabel;
}

- (UIImageView *)goodsImageView {
    if (!_goodsImageView) {
        _goodsImageView = [[UIImageView alloc] init];
    }
    return _goodsImageView;
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
