//
//  SpellOrderAfterSaleSelectView.m
//  FengXH
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderAfterSaleSelectView.h"
#import "SpellOrderAfterSalePresentCell.h"

@interface SpellOrderAfterSaleSelectView ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

{
    NSInteger selectRow;
}

@property(nonatomic,strong)UITableView *selectTableView;

@property(nonatomic,assign)NSInteger type;


@end

@implementation SpellOrderAfterSaleSelectView

-(instancetype)initWithType:(NSInteger)type andFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        _type=type;
        
        self.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.7f];
        
        UITapGestureRecognizer *tapGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction)];
        tapGes.delegate=self;
        [self addGestureRecognizer:tapGes];
        
        _selectTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
        _selectTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        _selectTableView.dataSource=self;
        _selectTableView.delegate=self;
        _selectTableView.backgroundColor=KTableBackgroundColor;
        [self addSubview:_selectTableView];
        [_selectTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(20);
            make.right.mas_offset(-20);
            make.height.mas_offset(300);
            make.centerY.mas_equalTo(self.mas_centerY);
        }];
        
        selectRow=0;
        
    }
    return self;
}
-(void)setDataArr:(NSArray *)dataArr
{
    _dataArr=dataArr;
    if (_dataArr.count<6) {
        [_selectTableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(50*_dataArr.count);
        }];
    }
    [_selectTableView reloadData];
}
//手势代理方法
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:_selectTableView]) {
        return NO;
    }
    
    return YES;
    
}
-(void)closeAction
{
    self.hidden=YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"select" object:nil userInfo:@{@"type":[NSNumber numberWithInteger:_type],@"selectRow":[NSNumber numberWithInteger:selectRow]}];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArr.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return 50;
    
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
    
    SpellOrderAfterSalePresentCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[SpellOrderAfterSalePresentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.titleLab.text=_dataArr[indexPath.row];
    if (indexPath.row==selectRow) {
        cell.rightImgView.image=[UIImage imageNamed:@"shopCar_btn_check_sel"];
    }
    else
    {
        cell.rightImgView.image=[UIImage imageNamed:@"shopCar_btn_check_nor"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    selectRow=indexPath.row;
    
    [tableView reloadData];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
