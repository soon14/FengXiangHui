//
//  ConfirmOrderSelectCouponView.m
//  FengXH
//
//  Created by sun on 2018/8/8.
//  Copyright © 2018年 HubinSun. All rights reserved.
//


#import "ConfirmOrderSelectCouponView.h"
#import "ConfirmOrderSelectCouponCell.h"
#import "ConfirmOrderCouponResultModel.h"

#define MainViewHeight (400+KBottomHeight)
#define ButtonHeight (45+KBottomHeight)

@interface ConfirmOrderSelectCouponView ()<UITableViewDelegate,UITableViewDataSource>

/** 主视图 */
@property(nonatomic , strong)UIView *mainView;
/** 确定使用优惠券 */
@property(nonatomic , strong)UIButton *confirmSelectButton;
/** 不使用优惠券 */
@property(nonatomic , strong)UIButton *unSelectButton;
/** tableView */
@property(nonatomic , strong)UITableView *couponTableView;

@end

@implementation ConfirmOrderSelectCouponView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KTableBackgroundColor;
        
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        //设置自己的 frame 为全屏
        self.frame = keyWindow.bounds;
        [keyWindow addSubview:self];
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.frame = self.bounds;
        [self addSubview:backBtn];
        [backBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *mainView = [[UIView alloc]initWithFrame:CGRectMake(0, KMAINSIZE.height, KMAINSIZE.width, MainViewHeight)];
        self.mainView = mainView;
        mainView.backgroundColor = KTableBackgroundColor;
        [self addSubview:mainView];
        
        [self initUI];
        
    }
    return self;
}

- (void)show {
    [UIView animateWithDuration:0.22 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        self.mainView.frame = CGRectMake(0, KMAINSIZE.height-MainViewHeight, KMAINSIZE.width, MainViewHeight);
    }];
}

- (void)closeView {
    [UIView animateWithDuration:0.22 animations:^{
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        self.mainView.frame = CGRectMake(0, KMAINSIZE.height, KMAINSIZE.width, MainViewHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - initUI
- (void)initUI {
    [self.mainView addSubview:self.unSelectButton];
    [self.unSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_offset(0);
        make.width.mas_equalTo(KMAINSIZE.width/2);
        make.height.mas_equalTo(ButtonHeight);
    }];
    
    [self.mainView addSubview:self.confirmSelectButton];
    [self.confirmSelectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_offset(0);
        make.width.mas_equalTo(KMAINSIZE.width/2);
        make.height.mas_equalTo(ButtonHeight);
    }];
    
    UIView *line = [[UIView alloc] init];
    [line setBackgroundColor:KLineColor];
    [self.mainView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(_unSelectButton.mas_top);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.mainView addSubview:self.couponTableView];
    
}

#pragma mark - tableView
- (UITableView *)couponTableView {
    if (!_couponTableView) {
        _couponTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, MainViewHeight-ButtonHeight) style:UITableViewStylePlain];
        _couponTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _couponTableView.backgroundColor = KTableBackgroundColor;
        _couponTableView.showsVerticalScrollIndicator = NO;
        _couponTableView.dataSource = self;
        _couponTableView.delegate = self;
        _couponTableView.estimatedRowHeight = 0;
        _couponTableView.estimatedSectionHeaderHeight = 0;
        _couponTableView.estimatedSectionFooterHeight = 0;
        [_couponTableView registerClass:[ConfirmOrderSelectCouponCell class] forCellReuseIdentifier:NSStringFromClass([ConfirmOrderSelectCouponCell class])];
    }
    return _couponTableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.couponResultModel.list.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return 10;
    } return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ConfirmOrderSelectCouponCell *couponCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ConfirmOrderSelectCouponCell class])];
    couponCell.couponModel = self.couponResultModel.list[indexPath.section];
    MJWeakSelf
    couponCell.couponSelectedBlock = ^(ConfirmOrderCouponResultListModel *couponModel, BOOL selected) {
        [weakSelf couponSelectAction:couponModel Selected:selected];
    };
    return couponCell;
}

#pragma mark - 优惠券选择被点击
- (void)couponSelectAction:(ConfirmOrderCouponResultListModel *)couponModel Selected:(BOOL)selected {
    if (selected) {
        for (ConfirmOrderCouponResultListModel *tempModel in self.couponResultModel.list) {
            tempModel.selected = NO;
        }
        couponModel.selected = YES;
    } else {
        couponModel.selected = selected;
    }
}

#pragma mark - 不使用优惠券点击
- (void)unSelectButtonAction:(UIButton *)sender {
    for (ConfirmOrderCouponResultListModel *tempModel in self.couponResultModel.list) {
        tempModel.selected = NO;
    }
    [self closeView];
}

#pragma mark - 使用优惠券按钮
- (void)confirmSelectButtonAction:(UIButton *)sender {
    ConfirmOrderCouponResultListModel *couponModel = [[ConfirmOrderCouponResultListModel alloc] init];
    for (ConfirmOrderCouponResultListModel *tempModel in self.couponResultModel.list) {
        if (tempModel.selected == YES) {
            couponModel = tempModel;
            break;
        }
    }
    if (self.couponSelectedBlock) {
        [self closeView];
        self.couponSelectedBlock(couponModel);
    }    
}

#pragma mark - lazy
- (UIButton *)unSelectButton {
    if (!_unSelectButton) {
        _unSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_unSelectButton setBackgroundColor:[UIColor whiteColor]];
        [_unSelectButton setTitle:@"不使用优惠券" forState:UIControlStateNormal];
        [_unSelectButton setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
        [_unSelectButton.titleLabel setFont:KFont(14)];
        [_unSelectButton addTarget:self action:@selector(unSelectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _unSelectButton;
}

- (UIButton *)confirmSelectButton {
    if (!_confirmSelectButton) {
        _confirmSelectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmSelectButton setBackgroundColor:KRedColor];
        [_confirmSelectButton setTitle:@"确定使用" forState:UIControlStateNormal];
        [_confirmSelectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_confirmSelectButton.titleLabel setFont:KFont(14)];
        [_confirmSelectButton addTarget:self action:@selector(confirmSelectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmSelectButton;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
