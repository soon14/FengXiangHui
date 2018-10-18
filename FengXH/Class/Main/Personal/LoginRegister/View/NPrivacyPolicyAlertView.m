//
//  NPrivacyPolicyAlertView.m
//  FengXH
//
//  Created by sun on 2018/10/16.
//  Copyright © 2018 HubinSun. All rights reserved.
//

#import "NPrivacyPolicyAlertView.h"

@interface NPrivacyPolicyAlertView ()<UITableViewDelegate,UITableViewDataSource>

/** 弹窗 */
@property(nonatomic , strong)UIView *contentView;
/** title */
@property(nonatomic , strong)UILabel *titleLabel;
/** 不同意 */
@property(nonatomic , strong)UIButton *disAgreeButton;
/** 同意 */
@property(nonatomic , strong)UIButton *agreeButton;
/** contentLabel */
@property(nonatomic , strong)YYLabel *contentLabel;
/** tableView */
@property(nonatomic , strong)UITableView *contentTableView;

@end

@implementation NPrivacyPolicyAlertView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        
        [self addSubview:self.contentView];
        [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mas_centerX);
            make.centerY.mas_equalTo(self.mas_centerY);
            make.width.mas_equalTo(300);
            make.height.mas_equalTo(400);
        }];
        [self CAtransitionLoad];
        
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.mas_offset(0);
            make.height.mas_equalTo(60);
        }];
        
        [self.contentView addSubview:self.disAgreeButton];
        [self.disAgreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_offset(0);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(42);
        }];
        
        [self.contentView addSubview:self.agreeButton];
        [self.agreeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_offset(0);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(42);
        }];
        
        UIView *line = [[UIView alloc] init];
        [line setBackgroundColor:KLineColor];
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.bottom.mas_equalTo(_disAgreeButton.mas_top);
            make.height.mas_equalTo(0.5);
        }];
        
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.bottom.mas_equalTo(line.mas_top).offset(-10);
            make.height.mas_equalTo(40);
        }];
        NSMutableAttributedString *text  = [[NSMutableAttributedString alloc] initWithString: @"点击同意即表示您已阅读并同意《疯享汇隐私政策》"];
        text.yy_font = KFont(14);
        text.yy_lineSpacing = 5;
        MJWeakSelf
        [text yy_setTextHighlightRange:NSMakeRange(14, 9) color:KRedColor backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
            if (weakSelf.agreePolicyBlock) {
                weakSelf.agreePolicyBlock(3);
            }
        }];
        self.contentLabel.attributedText = text;  //设置富文本
        
        [self.contentView addSubview:self.contentTableView];
        [self.contentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_titleLabel.mas_bottom);
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.bottom.mas_equalTo(_contentLabel.mas_top).offset(-10);
        }];
        
    }
    return self;
}


#pragma 动画效果
- (void)CAtransitionLoad {
    CATransition *transitionViewIn =[CATransition animation];
    // 动画时间.
    transitionViewIn.duration = 0.3;
    transitionViewIn.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    // 过渡效果.
    transitionViewIn.type = kCATransitionFade;
    [[self.contentView layer] addAnimation:transitionViewIn forKey:nil];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NPrivacyPolicyAlertCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([NPrivacyPolicyAlertCell class])];
    cell.contentString = @"在您注册为疯享汇用户的过程中，您需要完成我们的注册流程并通过点击同意的形式在线签署以下协议，请您务必仔细阅读、充分理解协议中的条款内容后再点击同意：\n《疯享汇隐私政策》\n【请您注意】如果您不同意上述协议或其中任何条款约定，请您停止注册。您停止注册后将仅可以浏览我们的商品信息但无法享受我们的产品或服务。如您按照注册流程提示填写信息、阅读并点击同意上述协议且完成全部注册流程后，即表示您已充分阅读、理解并接受协议的全部内容；并表明您也同意疯享汇可以依据以上的隐私政策内容来处理您的个人信息。如您对以上协议内容有任何疑问，您可随时与我们联系。";
    return cell;
}

#pragma mark - action
- (void)agreeButtonAction:(UIButton *)sender {
    if (self.agreePolicyBlock) {
        self.agreePolicyBlock(sender.tag);
    }
}

#pragma mark - lazy
- (UITableView *)contentTableView {
    if (!_contentTableView) {
        _contentTableView = [[UITableView alloc] init];
        _contentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _contentTableView.showsVerticalScrollIndicator = NO;
        _contentTableView.dataSource = self;
        _contentTableView.delegate = self;
        [_contentTableView registerClass:[NPrivacyPolicyAlertCell class] forCellReuseIdentifier:NSStringFromClass([NPrivacyPolicyAlertCell class])];
    }
    return _contentTableView;
}

- (YYLabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[YYLabel alloc] init];
        [_contentLabel setTextColor:KUIColorFromHex(0x333333)];
        [_contentLabel setNumberOfLines:0];
    }
    return _contentLabel;
}

- (UIButton *)agreeButton {
    if (!_agreeButton) {
        _agreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_agreeButton setTitle:@"同意" forState:UIControlStateNormal];
        [_agreeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_agreeButton.titleLabel setFont:KFont(15)];
        [_agreeButton setBackgroundColor:KRedColor];
        [_agreeButton setTag:0];
        [_agreeButton addTarget:self action:@selector(agreeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreeButton;
}

- (UIButton *)disAgreeButton {
    if (!_disAgreeButton) {
        _disAgreeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_disAgreeButton setTitle:@"不同意" forState:UIControlStateNormal];
        [_disAgreeButton setTitleColor:KUIColorFromHex(0x333333) forState:UIControlStateNormal];
        [_disAgreeButton.titleLabel setFont:KFont(15)];
        [_disAgreeButton setTag:1];
        [_disAgreeButton addTarget:self action:@selector(agreeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _disAgreeButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:[UIFont boldSystemFontOfSize:17]];
        [_titleLabel setText:@"隐私政策"];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        [_contentView setBackgroundColor:[UIColor whiteColor]];
        [_contentView.layer setMasksToBounds:YES];
        [_contentView.layer setCornerRadius:5];
    }
    return _contentView;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end


@interface NPrivacyPolicyAlertCell ()

/** label */
@property(nonatomic , strong)YYLabel *contentLabel;

@end

@implementation NPrivacyPolicyAlertCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.right.mas_offset(0);
        }];
        
    }
    return self;
}

- (void)setContentString:(NSString *)contentString {
    _contentString = contentString;
    NSMutableAttributedString *aString = [[NSMutableAttributedString alloc] initWithString:_contentString];
    [aString setYy_font:KFont(14)];
    [aString setYy_lineSpacing:5];
    [self.contentLabel setAttributedText:aString];
}

- (YYLabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[YYLabel alloc] init];
        [_contentLabel setTextColor:KUIColorFromHex(0x333333)];
//        [_contentLabel setFont:KFont(14)];
        [_contentLabel setNumberOfLines:0];
    }
    return _contentLabel;
}

@end
