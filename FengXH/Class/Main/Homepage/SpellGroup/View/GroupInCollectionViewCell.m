//
//  GroupInCollectionViewCell.m
//  FengXH
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GroupInCollectionViewCell.h"
#import "M80AttributedLabel.h"
@interface GroupInCollectionViewCell()
@property (nonatomic ,strong) M80AttributedLabel *title;
@property (nonatomic ,strong) NSString *num;
@end
@implementation GroupInCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_offset(0);
            make.top.mas_offset(10);
            
        }];
    }
    return self;
}
- (M80AttributedLabel *)title{
    if (!_title) {
        _title = [[M80AttributedLabel alloc]init];
        
        _title.textAlignment = kCTTextAlignmentCenter;
    }
    return _title;
}
- (void)setTime:(NSString *)str_hour AndStartTime:(NSString *)str_minute AndNum:(NSString *)num Andcount:(NSString *)str_second{
    _num = num;
    [_title setText:@"拼团剩余    "];
    [_title appendAttributedText:[[NSAttributedString alloc]initWithString:str_hour attributes:@{NSFontAttributeName:KFont(14),NSForegroundColorAttributeName:KUIColorFromHex(0xec6258)}]];
    [_title appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"小时"] attributes:@{NSFontAttributeName:KFont(14),NSForegroundColorAttributeName:[UIColor blackColor]}]];
    [_title appendAttributedText:[[NSAttributedString alloc]initWithString:str_minute attributes:@{NSFontAttributeName:KFont(14),NSForegroundColorAttributeName:KUIColorFromHex(0xec6258)}]];
    [_title appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"分"] attributes:@{NSFontAttributeName:KFont(14),NSForegroundColorAttributeName:[UIColor blackColor]}]];
    [_title appendAttributedText:[[NSAttributedString alloc]initWithString:str_second attributes:@{NSFontAttributeName:KFont(14),NSForegroundColorAttributeName:KUIColorFromHex(0xec6258)}]];
    [_title appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"秒，还差"] attributes:@{NSFontAttributeName:KFont(14),NSForegroundColorAttributeName:[UIColor blackColor]}]];
    [_title appendAttributedText:[[NSAttributedString alloc]initWithString:self.num attributes:@{NSFontAttributeName:KFont(14),NSForegroundColorAttributeName:KUIColorFromHex(0xec6258)}]];
    [_title appendAttributedText:[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"人"] attributes:@{NSFontAttributeName:KFont(14),NSForegroundColorAttributeName:[UIColor blackColor]}]];

}


@end
