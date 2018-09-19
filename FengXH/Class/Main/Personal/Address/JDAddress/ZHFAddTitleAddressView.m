//
//  ZHFAddTitleAddressView.m
//  FengXH
//
//  Created by sun on 2018/8/2.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "ZHFAddTitleAddressView.h"
#import "JDAdressModel.h"

@interface ZHFAddTitleAddressView ()<UIScrollViewDelegate,UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UIScrollView *titleScrollView;
@property(nonatomic,strong)UIScrollView *contentScrollView;
@property(nonatomic,strong)UIButton *radioBtn;
@property(nonatomic,strong)NSMutableArray *titleBtns;
@property(nonatomic,strong)NSMutableArray *titleMarr;
@property(nonatomic,strong)NSMutableArray *tableViewMarr;
@property(nonatomic,strong)UILabel *lineLabel;
@property(nonatomic,strong)NSMutableArray *titleIDMarr;
@property(nonatomic,assign)BOOL isInitalize;
@property(nonatomic,assign)BOOL isclick; //判断是滚动还是点击
@property(nonatomic,strong)NSMutableArray *provinceMarr;//省
@property(nonatomic,strong)NSMutableArray *cityMarr;//市
@property(nonatomic,strong)NSMutableArray *countyMarr;//县
@property(nonatomic,strong)NSMutableArray *townMarr;//乡
@property(nonatomic,strong)NSArray *resultArr;//本地数组
@end
@implementation ZHFAddTitleAddressView
-(NSMutableArray *)titleBtns
{
    if (_titleBtns == nil) {
        _titleBtns = [[NSMutableArray alloc]init];
    }
    return _titleBtns;
}
-(NSMutableArray *)titleMarr
{
    if (_titleMarr == nil) {
        _titleMarr = [[NSMutableArray alloc]init];
    }
    return _titleMarr;
}
-(NSMutableArray *)tableViewMarr
{
    if (_tableViewMarr == nil) {
        _tableViewMarr = [[NSMutableArray alloc]init];
    }
    return _tableViewMarr;
}
-(NSMutableArray *)titleIDMarr
{
    if (_titleIDMarr == nil) {
        _titleIDMarr = [[NSMutableArray alloc]init];
    }
    return _titleIDMarr;
}
-(NSMutableArray *)provinceMarr
{
    if (_provinceMarr == nil) {
        _provinceMarr = [[NSMutableArray alloc]init];
    }
    return _provinceMarr;
}
-(NSMutableArray *)cityMarr
{
    if (_cityMarr == nil) {
        _cityMarr = [[NSMutableArray alloc]init];
    }
    return _cityMarr;
}
-(NSMutableArray *)countyMarr
{
    if (_countyMarr == nil) {
        _countyMarr = [[NSMutableArray alloc]init];
    }
    return _countyMarr;
}
-(NSMutableArray *)townMarr
{
    if (_townMarr == nil) {
        _townMarr = [[NSMutableArray alloc]init];
    }
    return _townMarr;
}
-(UIView *)initAddressView{
    self.frame = CGRectMake(0, 0, KMAINSIZE.width, (KMAINSIZE.height));
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapBtnAndcancelBtnClick)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    //设置添加地址的View
    self.addAddressView = [[UIView alloc]init];
    self.addAddressView.frame = CGRectMake(0, (KMAINSIZE.height), KMAINSIZE.width, _defaultHeight);
    self.addAddressView.backgroundColor = [UIColor whiteColor];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.addAddressView.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(10,10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.addAddressView.bounds;
    maskLayer.path = maskPath.CGPath;
    self.addAddressView.layer.mask = maskLayer;
    [self addSubview:self.addAddressView];
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(40, 10, KMAINSIZE.width - 80, 30)];
    titleLabel.text = _title;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.font = [UIFont systemFontOfSize:17];
    [self.addAddressView addSubview:titleLabel];
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelBtn.frame =CGRectMake(CGRectGetMaxX(self.addAddressView.frame) - 40, 10, 25, 25);
    cancelBtn.tag = 1;
    [cancelBtn setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(tapBtnAndcancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.addAddressView addSubview:cancelBtn];
    
    [self addTableViewAndTitle:0];
    //1.添加标题滚动视图
    [self setupTitleScrollView];
    //2.添加内容滚动视图
    [self setupContentScrollView];
    [self setupAllTitle:0];
    return self;
}
-(void)addAnimate{
    self.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.addAddressView.frame = CGRectMake(0, (KMAINSIZE.height) - self.defaultHeight, KMAINSIZE.width, self.defaultHeight);
    }];
}
-(void)tapBtnAndcancelBtnClick{
    self.hidden = NO;
    [UIView animateWithDuration:0.2 animations:^{
         self.addAddressView.frame = CGRectMake(0, (KMAINSIZE.height), KMAINSIZE.width, 200);
    } completion:^(BOOL finished) {
        self.hidden = YES;
        NSMutableString * titleAddress = [[NSMutableString alloc]init];
        NSMutableString * titleID = [[NSMutableString alloc]init];
        NSInteger  count = 0;
        NSString * str = self.titleMarr[self.titleMarr.count - 1];
        if ([str isEqualToString:@"请选择"]) {
            count = self.titleMarr.count - 1;
        }
        else{
            count = self.titleMarr.count;
        }
        for (int i = 0; i< count ; i++) {
            [titleAddress appendString:[[NSString alloc]initWithFormat:@" %@",self.titleMarr[i]]];
            if (i == count - 1) {
                [titleID appendString:[[NSString alloc]initWithFormat:@"%@",self.titleIDMarr[i]]];
            }
            else{
                [titleID appendString:[[NSString alloc]initWithFormat:@"%@,",self.titleIDMarr[i]]];
            }
        }
        [self.delegate1 cancelBtnClick:titleAddress titleID:titleID];
    }];
}
-(void)setupTitleScrollView{
    //TitleScrollView和分割线
    self.titleScrollView = [[UIScrollView alloc]init];
    self.titleScrollView.frame = CGRectMake(0, 50, KMAINSIZE.width, _titleScrollViewH);
    [self.addAddressView addSubview:self.titleScrollView];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.titleScrollView.frame), KMAINSIZE.width, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    [self.addAddressView addSubview:(lineView)];
}
-(void)setupContentScrollView{
    //ContentScrollView
    CGFloat y  =  CGRectGetMaxY(self.titleScrollView.frame) + 1;
     self.contentScrollView = [[UIScrollView alloc]init];
    self.contentScrollView.frame = CGRectMake(0, y, KMAINSIZE.width, self.defaultHeight - y);
    [self.addAddressView addSubview:self.contentScrollView];
    self.contentScrollView.delegate = self;
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.bounces = NO;
}
-(void)setupAllTitle:(NSInteger)selectId{
    for ( UIView * view in [self.titleScrollView subviews]) {
         [view removeFromSuperview];
    }
    [self.titleBtns removeAllObjects];
    CGFloat btnH = self.titleScrollViewH;
    _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
    _lineLabel.backgroundColor = [UIColor redColor];
    [self.titleScrollView addSubview:(_lineLabel)];
    CGFloat x = 10;
    //NSLog(@"%@",self.titleMarr);
    for (int i = 0; i < self.titleMarr.count ; i++) {
        NSString   *title = self.titleMarr[i];
        CGFloat titlelenth = title.length * 15;
        UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [titleBtn setTitle:title forState:UIControlStateNormal];
        titleBtn.tag = i;
        [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
         [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        titleBtn.selected = NO;
        titleBtn.frame = CGRectMake(x, 0, titlelenth, btnH);
        x  = titlelenth + 10 + x;
        [titleBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleBtns addObject:titleBtn];
        if (i == selectId) {
            [self titleBtnClick:titleBtn];
        }
        [self.titleScrollView addSubview:(titleBtn)];
        self.titleScrollView.contentSize =CGSizeMake(x, 0);
        self.titleScrollView.showsHorizontalScrollIndicator = NO;
        self.contentScrollView.contentSize = CGSizeMake(self.titleMarr.count * KMAINSIZE.width, 0);
        self.contentScrollView.showsHorizontalScrollIndicator = NO;
    }
}
-(void)titleBtnClick:(UIButton *)titleBtn{
    self.radioBtn.selected = NO;
    titleBtn.selected = YES;
    [self setupOneTableView:titleBtn.tag];
    CGFloat x  = titleBtn.tag * KMAINSIZE.width;
    self.contentScrollView.contentOffset = CGPointMake(x, 0);
    self.lineLabel.frame = CGRectMake(CGRectGetMinX(titleBtn.frame), self.titleScrollViewH - 3,titleBtn.frame.size.width, 3);
    self.radioBtn = titleBtn;
    self.isclick = YES;
   
}

-(void)setupOneTableView:(NSInteger)btnTag{
    UITableView  * contentView= self.tableViewMarr[btnTag];
    if  (btnTag == 0) {
        [self getAddressMessageDataAddressID:1 provinceIdOrCityId:0];
    }
    if (contentView.superview != nil) {
        return;
    }
    CGFloat  x= btnTag * KMAINSIZE.width;
    contentView.frame = CGRectMake(x, 0, KMAINSIZE.width, self.contentScrollView.bounds.size.height);
    contentView.delegate = self;
    contentView.dataSource = self;
    [self.contentScrollView addSubview:(contentView)];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSInteger leftI  = scrollView.contentOffset.x / KMAINSIZE.width;
    if (scrollView.contentOffset.x / KMAINSIZE.width != leftI){
        self.isclick = NO;
    }
    if (self.isclick == NO) {
        if (scrollView.contentOffset.x / KMAINSIZE.width == leftI){
            UIButton * titleBtn  = self.titleBtns[leftI];
            [self titleBtnClick:titleBtn];
        }
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 0) {
        return self.provinceMarr.count;
    }
    else if (tableView.tag == 1) {
        return self.cityMarr.count;
    }
    else if (tableView.tag == 2){
        return self.countyMarr.count;
    }
    else if (tableView.tag == 3){
        return self.townMarr.count;
    }
    else{
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * AddressAdministerCellIdentifier = @"AddressAdministerCellIdentifier";
    UITableViewCell *cell = (UITableViewCell*)[tableView dequeueReusableCellWithIdentifier:AddressAdministerCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AddressAdministerCellIdentifier];
    }
    if (tableView.tag == 0) {
        JDAdressModel * provinceModel = self.provinceMarr[indexPath.row];
        cell.textLabel.text = provinceModel.name;
    }
    else if (tableView.tag == 1) {
        JDAdressModel *cityModel = self.cityMarr[indexPath.row];
        cell.textLabel.text= cityModel.name;
    }
    else if (tableView.tag == 2){
        JDAdressModel * countyModel  = self.countyMarr[indexPath.row];
        cell.textLabel.text = countyModel.name;
    }
    else if (tableView.tag == 3){
        JDAdressModel * townModel  = self.townMarr[indexPath.row];
        cell.textLabel.text = townModel.name;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    cell.textLabel.textColor = [UIColor grayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 0 || tableView.tag == 1 || tableView.tag == 2){
        if (tableView.tag == 0){
            JDAdressModel *provinceModel = self.provinceMarr[indexPath.row];
            NSString * provinceID = [NSString stringWithFormat:@"%ld",(long)provinceModel.addressID];
            //1. 修改选中ID
            if (self.titleIDMarr.count > 0){
                [self.titleIDMarr replaceObjectAtIndex:tableView.tag withObject:provinceID];
            }
            else{
                [self.titleIDMarr addObject:provinceID];
            }
            //2.修改标题
              [self.titleMarr replaceObjectAtIndex:tableView.tag withObject:provinceModel.name];
            //请求网络 添加市区
            [self getAddressMessageDataAddressID:2 provinceIdOrCityId:provinceID];
        }
        else if (tableView.tag == 1){
            JDAdressModel * cityModel = self.cityMarr[indexPath.row];
            NSString * cityID = [NSString stringWithFormat:@"%ld",(long)cityModel.addressID];
             [self.titleMarr replaceObjectAtIndex:tableView.tag withObject:cityModel.name];
            //1. 修改选中ID
            if (self.titleIDMarr.count > 1){
                [self.titleIDMarr replaceObjectAtIndex:tableView.tag withObject:cityID];
            }
            else{
                 [self.titleIDMarr addObject:cityID];
            }
            //网络请求，添加县城
            [self getAddressMessageDataAddressID:3 provinceIdOrCityId:cityID];
        }
        else if (tableView.tag == 2) {
            JDAdressModel * countyModel = self.countyMarr[indexPath.row];
            NSString * countyID = [NSString stringWithFormat:@"%ld",(long)countyModel.addressID];
            [self.titleMarr replaceObjectAtIndex:tableView.tag withObject:countyModel.name];
            //1. 修改选中ID
            if (self.titleIDMarr.count > 2){
                [self.titleIDMarr replaceObjectAtIndex:tableView.tag withObject:countyID];
            }
            else{
                [self.titleIDMarr addObject:countyID];
            }
            //2.修改标题
            [self.titleMarr replaceObjectAtIndex:tableView.tag withObject:countyModel.name];
            //网络请求，添加县城
            [self getAddressMessageDataAddressID:4 provinceIdOrCityId:countyID];
        }
    }
    else if (tableView.tag == 3) {
        JDAdressModel * townModel = self.townMarr[indexPath.row];
        NSString * townID = [NSString stringWithFormat:@"%ld",(long)townModel.addressID];
        [self.titleMarr replaceObjectAtIndex:tableView.tag withObject:townModel.name];
        //1. 修改选中ID
        if (self.titleIDMarr.count > 3){
            [self.titleIDMarr replaceObjectAtIndex:tableView.tag withObject:townID];
        }
        else{
            [self.titleIDMarr addObject:townID];
        }
        [self setupAllTitle:tableView.tag];
        [self tapBtnAndcancelBtnClick];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  40;
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass(touch.view.classForCoder) isEqualToString: @"UITableViewCellContentView"] || touch.view == self.addAddressView || touch.view == self.titleScrollView) {
        return NO;
    }
    return YES;
}
//添加tableView和title
-(void)addTableViewAndTitle:(NSInteger)tableViewTag{
    UITableView * tableView2 = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 200) style:UITableViewStylePlain];
    tableView2.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView2.tag = tableViewTag;
    [self.tableViewMarr addObject:tableView2];
    [self.titleMarr addObject:@"请选择"];
}
//改变title
-(void)changeTitle:(NSInteger)replaceTitleMarrIndex{
    [self.titleMarr replaceObjectAtIndex:replaceTitleMarrIndex withObject:@"请选择"];
    NSInteger index = [self.titleMarr indexOfObject:@"请选择"];
    NSInteger count = self.titleMarr.count;
    NSInteger loc = index + 1;
    NSInteger range = count - index;
    [self.titleMarr removeObjectsInRange:NSMakeRange(loc, range - 1)];
    [self.tableViewMarr removeObjectsInRange:NSMakeRange(loc, range - 1)];
}
//移除多余的title和tableView,收回选择器
-(void)removeTitleAndTableViewCancel:(NSInteger)index{
    NSInteger indexAddOne = index + 1;
    NSInteger indexsubOne = index - 1;
    if (self.tableViewMarr.count >= indexAddOne){
        [self.titleMarr removeObjectsInRange:NSMakeRange(index, self.titleMarr.count - indexAddOne)];
        [self.tableViewMarr removeObjectsInRange:NSMakeRange(index, self.tableViewMarr.count - indexAddOne)];
    }
    [self setupAllTitle:indexsubOne];
    [self tapBtnAndcancelBtnClick];
}

//(以下注释部分是网络请求)
- (void)getAddressMessageDataAddressID:(NSInteger)addressID provinceIdOrCityId:(NSString *)provinceIdOrCityId{
    NSString * addressUrl = @"r=apply.jdaddress";
    NSString *path = [HBBaseAPI appendAPIurl:addressUrl];
    NSDictionary *parameters = [[NSDictionary alloc]init];
        if(addressID == 2){
            //请求市区需要传递的参数
            parameters = @{@"add" : @"city",
                           @"upid" : provinceIdOrCityId};
        }
        else if(addressID == 3){
            //请求县需要传递的参数
            parameters = @{@"add" : @"county",
                           @"upid" : provinceIdOrCityId};
        }
        else if(addressID == 4){
            //请求镇需要传递的参数
            parameters = @{@"add" : @"towns",
                           @"upid" : provinceIdOrCityId};
        }
    //网络请求
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:parameters WithSuccessBlock:^(NSDictionary *responseDic) {
        if ([responseDic[@"status"] integerValue] == 1) {
            NSArray *arr = [[NSArray alloc]init];
            switch (addressID) {
                case 1:
                    //拿到省列表
                    arr =  responseDic[@"result"][@"list"];
                    [self caseProvinceArr:arr];
                    break;
                case 2:
                    //拿到市列表
                    arr = responseDic[@"result"][@"list"];
                    [self caseCityArr:arr];
                    break;
                case 3:
                    //拿到县列表
                    arr = responseDic[@"result"][@"list"];
                    [self caseCountyArr:arr];
                    break;
                case 4:
                    //拿到乡镇列表
                    arr = responseDic[@"result"][@"list"];
                    [self caseTownArr:arr];
                    break;
                    
                default:
                    break;
            }
            if (self.tableViewMarr.count >= addressID){
                UITableView * tableView1  = self.tableViewMarr[addressID - 1];
                [tableView1 reloadData];
            }
            
        } else {
            NSLog(@"请求数据失败");
        }
    } WithFailureBlock:^(NSError *error) {
        NSLog(@"网络请求失败");
    }];
}
-(void)caseProvinceArr:(NSArray *)provinceArr{
    if (provinceArr.count > 0){
        [self.provinceMarr removeAllObjects];
        for (int i = 0; i < provinceArr.count; i++) {
            NSDictionary *dic1 = provinceArr[i];
            JDAdressModel *provinceModel =  [JDAdressModel yy_modelWithDictionary:dic1];
            [self.provinceMarr addObject:provinceModel];
        }
    }else{
        [self tapBtnAndcancelBtnClick];
    }
}
-(void)caseCityArr:(NSArray *)cityArr{
    if (cityArr.count > 0){
        [self.cityMarr removeAllObjects];
        for (int i = 0; i < cityArr.count; i++) {
            NSDictionary *dic1 = cityArr[i];
            JDAdressModel *cityModel = [JDAdressModel yy_modelWithDictionary:dic1];
            [self.cityMarr addObject:cityModel];
        }
        if (self.tableViewMarr.count >= 2){
            [self changeTitle:1];
        }
        else{
            [self addTableViewAndTitle:1];
        }
        [self setupAllTitle:1];
    }
    else{
        //没有对应的市
        [self removeTitleAndTableViewCancel:1];
    }
}

-(void)caseCountyArr:(NSArray *)countyArr{
    if (countyArr.count > 0){
        [self.countyMarr removeAllObjects];
        for (int i = 0; i < countyArr.count; i++) {
            NSDictionary *dic1 = countyArr[i];
            JDAdressModel *countyModel = [JDAdressModel yy_modelWithDictionary:dic1];
            [self.countyMarr addObject:countyModel];
        }
        if (self.tableViewMarr.count >= 3){
           [self changeTitle:2];
        }
        else{
            [self addTableViewAndTitle:2];
        }
        [self setupAllTitle:2];
    }
    else{
        //没有对应的县
        [self removeTitleAndTableViewCancel:2];
    }
}

-(void)caseTownArr:(NSArray *)townArr{
    if (townArr.count > 0){
        [self.townMarr removeAllObjects];
        for (int i = 0; i < townArr.count; i++) {
            NSDictionary *dic1 = townArr[i];
            JDAdressModel *townModel = [JDAdressModel yy_modelWithDictionary:dic1];
            [self.townMarr addObject:townModel];
        }
        if (self.tableViewMarr.count >= 4){
           [self changeTitle:3];
        }
        else{
            [self addTableViewAndTitle:3];
        }
        [self setupAllTitle:3];
    }
    else{
        //没有对应的乡镇
        [self removeTitleAndTableViewCancel:3];
    }
}

@end

