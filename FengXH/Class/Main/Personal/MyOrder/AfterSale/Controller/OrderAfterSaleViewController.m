//
//  OrderAfterSaleViewController.m
//  FengXH
//
//  Created by sun on 2018/8/15.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "OrderAfterSaleViewController.h"
#import "SpellOrderCommentCheckImageView.h"
#import "SpellOrderCommentPhotoCell.h"
#import "SpellOrderCommentWholeCell.h"
#import "SpellOrderAfterSaleSelectCell.h"
#import "SpellOrderAfterSaleBottomView.h"
#import "SpellOrderAfterSaleMoneyCell.h"
#import "SpellOrderCommentDiscussCell.h"
#import "SpellOrderAfterSaleSelectView.h"

@interface OrderAfterSaleViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

{
    //处理方式选择的行
    NSInteger disposeSelectIndex;
    //退款原因选择的行
    NSInteger reasonSelectIndex;
    //退款原因数组
    NSArray *reasonArr;
    //上传图片成功后返回的图片名字数组
    NSMutableArray *responseImgNameArr;
}

@property(nonatomic,strong)UICollectionView *afterSaleCollectionView;
//放选择的图片的数组
@property(nonatomic,strong)NSMutableArray *mImgArr;
//放选择的图片名字的数组
@property(nonatomic,strong)NSMutableArray *mImgNameArr;
//查看图片view
@property(nonatomic,strong)SpellOrderCommentCheckImageView *checkImgView;
//底部按钮view
@property(nonatomic,strong)SpellOrderAfterSaleBottomView *bottomView;
//请求回来的数据data
@property(nonatomic,strong)NSMutableDictionary *dataDic;
//弹出的处理方式选择view
@property(nonatomic,strong)SpellOrderAfterSaleSelectView *disposeSelectView;
//弹出的退款原因选择view
@property(nonatomic,strong)SpellOrderAfterSaleSelectView *reasonSelectView;
//type
@property(nonatomic,assign)NSInteger type;

@end

@implementation OrderAfterSaleViewController

-(instancetype)initWithType:(NSInteger)type
{
    if (self=[super init]) {
        _type=type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _mImgArr=[[NSMutableArray alloc]init];
    
    _mImgNameArr=[[NSMutableArray alloc]init];
    
    reasonArr=@[@"不想要了",@"卖家缺货",@"拍错了/订单信息错误",@"其他"];
    
    disposeSelectIndex=0;
    
    reasonSelectIndex=0;
    
    [self AfterSaleRequest];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(selectRow:) name:@"select" object:nil];
    
}
-(void)selectRow:(NSNotification *)noti
{
    NSDictionary *dic=noti.userInfo;
    if ([dic[@"type"] isEqualToNumber:@0]) {
        //处理方式
        disposeSelectIndex=[dic[@"selectRow"] integerValue];
        
    }
    else
    {
        //退款原因
        reasonSelectIndex=[dic[@"selectRow"] integerValue];
        
    }
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:[dic[@"type"] integerValue]];
    [self.afterSaleCollectionView reloadSections:indexSet];
}
-(void)AfterSaleRequest
{
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    NSDictionary *paramsDic=@{@"token":tokenStr,@"orderid":_orderId};
    NSString * urlString = @"r=apply.order.refund";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramsDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        NSLog(@"----%@",responseDic);
        if ([responseDic[@"status"] integerValue] == 1) {
            
            _dataDic = [NSMutableDictionary dictionaryWithDictionary:responseDic[@"result"]];
//            _dataDic=responseDic[@"result"];
            [_dataDic setObject:@[@"退款(仅退款不退货)"] forKey:@"handle"];
            
            [self.view addSubview:self.afterSaleCollectionView];
            
            if (_type==0) {
                
                [self.view addSubview:self.bottomView];
                
            }
            
        } else {
            [DBHUD ShowInView:self.view withTitle:responseDic[@"message"]];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 7;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==4) {
        SpellOrderCommentWholeCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SpellOrderCommentWholeCell class]) forIndexPath:indexPath];
        cell.titleLab.text=@"上传凭证";
        return cell;
    }
    else if (indexPath.section==2)
    {
        SpellOrderCommentDiscussCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SpellOrderCommentDiscussCell class]) forIndexPath:indexPath];
        cell.titleLab.text=@"退款说明";
        if (_type==1) {
            cell.introTextView.text=_dataDic[@"content"];
            cell.introTextView.editable=NO;
            cell.introTextView.placeholder=@"";
        }
        else
        {
            cell.introTextView.placeholder=@"请填写退款说明";
        }
        return cell;
    }
    else if (indexPath.section==0||indexPath.section==1)
    {
        SpellOrderAfterSaleSelectCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SpellOrderAfterSaleSelectCell class]) forIndexPath:indexPath];
        if (_type==1) {
            cell.arrowsImgView.hidden=YES;
        }
        if (indexPath.section==1) {
            cell.titleLab.text=@"退款原因";
            if (_type==0) {
                cell.contentLab.text=reasonArr[reasonSelectIndex];
            }
            else
            {
                cell.contentLab.text=_dataDic[@"reason"];
            }
        }
        else
        {
            cell.titleLab.text=@"处理方式";
            if (_type==0) {
                cell.contentLab.text=_dataDic[@"handle"][disposeSelectIndex];
            }
            else
            {
                cell.contentLab.text=_dataDic[@"handle"];
            }
        }
        return cell;
    }
    else if (indexPath.section==5)
    {
        SpellOrderCommentPhotoCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SpellOrderCommentPhotoCell class]) forIndexPath:indexPath];
        if (indexPath.row==_mImgArr.count) {
            cell.photoImgView.image=[UIImage imageNamed:@"添加"];
            
        }
        else
        {
            cell.photoImgView.image=_mImgArr[indexPath.row];
            
        }
        return cell;
    }
    else if(indexPath.section==3)
    {
        SpellOrderAfterSaleMoneyCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SpellOrderAfterSaleMoneyCell class]) forIndexPath:indexPath];
        if (_type==0) {
            if (_dataDic[@"maxprice"]) {
                cell.moneyTextField.text=_dataDic[@"maxprice"]?_dataDic[@"maxprice"]:@"";
            }
        }
        else
        {
            if (_dataDic[@"maxprice"]) {
                cell.moneyTextField.text=_dataDic[@"maxprice"];
            }
            cell.moneyTextField.enabled=NO;
        }
        return cell;
    }
    else
    {
        UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
        UILabel *lab=[cell.contentView viewWithTag:33];
        if (!lab) {
            lab=[[UILabel alloc]initWithFrame:CGRectMake(10, 20, KMAINSIZE.width-20, 20)];
            lab.textColor=KRedColor;
            lab.font=KFont(14);
            lab.tag=33;
            [cell.contentView addSubview:lab];
        }
        
        lab.text=[NSString stringWithFormat:@"*提示：您可退款的最大金额为¥%@",_dataDic[@"maxprice"]];
        
        return cell;
    }
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section==5) {
        if (_type==0) {
            return _mImgArr.count+1;
        }
        else
        {
            return 0;
        }
    }
    else
    {
        if (_type==1&&section==4) {
            return 0;
        }
        else
        {
            return 1;
        }
    }
    
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_type==0) {
        if (indexPath.section==5) {
            if (indexPath.row==_mImgArr.count) {
                if (_mImgArr.count<3) {
                    //打开相机或者相册
                    MJWeakSelf
                    [[PhotoHelper sharedInstance] showPhotoActionViewWithController:self andWithBlock:^(id returnValue) {
                        
                        [weakSelf addPictureWithImage:returnValue];
                        
                    }];
                }
                else
                {
                    [JHSysAlertUtil presentAlertViewWithTitle:nil message:@"最多上传3张照片" confirmTitle:@"知道了" handler:nil];
                }
                
            }
            else
            {
                
                if (!_checkImgView) {
                    UIWindow *window=[UIApplication sharedApplication].keyWindow;
                    [window addSubview:self.checkImgView];
                    [_checkImgView upDateUIWithPicture:_mImgArr andIndex:indexPath.row];
                }
                else
                {
                    _checkImgView.hidden=NO;
                    [_checkImgView upDateUIWithPicture:_mImgArr andIndex:indexPath.row];
                }
                
            }
            
        }
        else if (indexPath.section==0)
        {
            //弹出选择view
            if (!_disposeSelectView) {
                UIWindow *window=[UIApplication sharedApplication].keyWindow;
                [window addSubview:self.disposeSelectView];
                _disposeSelectView.dataArr=_dataDic[@"handle"];
            }
            else
            {
                _disposeSelectView.hidden=NO;
            }
        }
        else if (indexPath.section==1)
        {
            if (!_reasonSelectView) {
                UIWindow *window=[UIApplication sharedApplication].keyWindow;
                [window addSubview:self.reasonSelectView];
                _reasonSelectView.dataArr=reasonArr;
            }
            else
            {
                _reasonSelectView.hidden=NO;
            }
        }
    }
    
    
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat collectionViewWidth = collectionView.frame.size.width;
    
    if (indexPath.section==5)
    {
        return CGSizeMake(80, 80);
        
    }
    else
    {
        return CGSizeMake(collectionViewWidth, 60);
    }
    
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section==5) {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
    else
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section==5) {
        return 10.0;
    }
    else
    {
        return CGFLOAT_MIN;
    }
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section==5) {
        return 10.0;
    }
    else
    {
        return CGFLOAT_MIN;
    }
}

#pragma mark--------cheackImageView的Block
-(void)cancelAction
{
    _checkImgView.hidden=YES;
    [self.afterSaleCollectionView reloadData];
}
-(void)deleteImgWithIndex:(NSInteger)index
{
    
    [_mImgArr removeObjectAtIndex:index];
    [_mImgNameArr removeObjectAtIndex:index];
    
    if (index!=0) {
        
        index=index-1;
        
        [_checkImgView upDateUIWithPicture:_mImgArr andIndex:index];
        
    }
    else
    {
        if (_mImgArr.count==0) {
            
            [self cancelAction];
            
        }
        else
        {
            
            [_checkImgView upDateUIWithPicture:_mImgArr andIndex:index];
            
        }
        
    }
    
}

#pragma mark - 拍照后保存照片
-(void)addPictureWithImage:(UIImage *)image
{
    if(image!=nil){
        //在默认的每行图片数组中  添加新拍的图片
        
        [_mImgArr insertObject:image atIndex:_mImgArr.count];
        [_mImgNameArr insertObject:[NSString stringWithFormat:@"imgFile0\";filename=\"%@",[ShareManager getNowTimeTimestamp]] atIndex:_mImgNameArr.count];
        
    }
    
    [self.afterSaleCollectionView reloadData];
    
}

#pragma mark-----底部按钮绑定方法(取消和提交申请)
-(void)bottomBtnAction:(NSInteger)index
{
    if (index==0) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        if (_mImgArr.count>0) {
            [self upLoadImageAndSubminApply];
        }
        else
        {
            [self submitApplyWithImageStr:@""];
        }
        
    }
}
-(void)upLoadImageAndSubminApply
{
    MJWeakSelf;
    
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        responseImgNameArr=[[NSMutableArray alloc]init];
        //创建一个线程组
        dispatch_group_t requestGroup = dispatch_group_create();
        
        //因为AFN异步请求会自动创建子线程 所以这里不需要再创建
        NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
        NSString * urlString = [NSString stringWithFormat:@"r=apply.util.uploader&file=imgFile0"];
        NSString *path = [HBBaseAPI appendAPIurl:urlString];
        for (int i=0; i<_mImgArr.count; i++) {
            
            //线程组enter（将下面的线程加入到组中）
            dispatch_group_enter(requestGroup);
            
            [[HBNetWork sharedManager] requestWithPath:path WithParams:@{@"token":tokenStr} WithImageName:@"imgFile0" WithImage:_mImgArr[i] WithSuccessBlock:^(NSDictionary *responseDic) {
                if ([responseDic[@"status"] integerValue] == 1) {
                    
                    [responseImgNameArr addObject:responseDic[@"result"][@"url"]];
                    
                } else {
                    
                }
                //请求结束后 将线程从线程组中移出
                dispatch_group_leave(requestGroup);
            } WithFailureBlock:^(NSError *error) {
                //请求结束后 将线程从线程组中移出
                dispatch_group_leave(requestGroup);
            }];
        }
        //等待线程组执行完毕
        dispatch_group_wait(requestGroup, DISPATCH_TIME_FOREVER);
        //调用主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            //线程组执行完毕后的操作 在这里写
            [DBHUD Hiden:YES fromView:weakSelf.view];
            NSString *str=@"";
            for (int i=0; i<responseImgNameArr.count; i++) {
                if (i==0) {
                    str=responseImgNameArr[0];
                }
                else
                {
                    str=[NSString stringWithFormat:@"%@,%@",str,responseImgNameArr[i]];
                }
            }
            [weakSelf submitApplyWithImageStr:str];
            
        });
        
    });
    
}
-(void)submitApplyWithImageStr:(NSString *)imgStr
{
    SpellOrderAfterSaleMoneyCell *moneyCell=(SpellOrderAfterSaleMoneyCell *)[_afterSaleCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
    NSString *price=moneyCell.moneyTextField.text;
    if (![ShareManager isNumber:price]) {
        [DBHUD ShowInView:self.view withTitle:@"请输入正确的金额"];
        return;
    }
    
    if ([price floatValue]>[_dataDic[@"maxprice"] floatValue]) {
        [DBHUD ShowInView:self.view withTitle:[NSString stringWithFormat:@"最大只能退款%@元",_dataDic[@"maxprice"]]];
        return;
    }
    
    
    SpellOrderCommentDiscussCell *contentCell=(SpellOrderCommentDiscussCell *)[_afterSaleCollectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    NSString *contentStr;
    if (contentCell.introTextView.text==nil) {
        contentStr=@"";
    }
    else
    {
        contentStr=contentCell.introTextView.text;
    }
    
    
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    NSDictionary *paramsDic=@{@"token":tokenStr,@"orderid":_orderId,@"price":price,@"rtype":@0,@"reason":reasonArr[reasonSelectIndex],@"content":contentStr,@"images":imgStr};
    NSString * urlString = @"r=apply.order.refund.submit";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramsDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
    
}
#pragma mark-----commentCollectionView
-(UICollectionView *)afterSaleCollectionView
{
    if (!_afterSaleCollectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _afterSaleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight-50) collectionViewLayout:flowLayout];
        _afterSaleCollectionView.backgroundColor = KTableBackgroundColor;
        
        //注册选择cell
        [_afterSaleCollectionView registerClass:[SpellOrderAfterSaleSelectCell class] forCellWithReuseIdentifier:NSStringFromClass([SpellOrderAfterSaleSelectCell class])];
        //注册cell
        [_afterSaleCollectionView registerClass:[SpellOrderCommentWholeCell class] forCellWithReuseIdentifier:NSStringFromClass([SpellOrderCommentWholeCell class])];
        //注册晒图cell
        [_afterSaleCollectionView registerClass:[SpellOrderCommentPhotoCell class] forCellWithReuseIdentifier:NSStringFromClass([SpellOrderCommentPhotoCell class])];
        //注册cell
        [_afterSaleCollectionView registerClass:[SpellOrderAfterSaleMoneyCell class] forCellWithReuseIdentifier:NSStringFromClass([SpellOrderAfterSaleMoneyCell class])];
        //注册cell
        [_afterSaleCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
        //注册cell
        [_afterSaleCollectionView registerClass:[SpellOrderCommentDiscussCell class] forCellWithReuseIdentifier:NSStringFromClass([SpellOrderCommentDiscussCell class])];
        
        _afterSaleCollectionView.delegate=self;
        _afterSaleCollectionView.dataSource=self;
        
    }
    return _afterSaleCollectionView;
}
-(SpellOrderCommentCheckImageView *)checkImgView
{
    if (!_checkImgView) {
        
        MJWeakSelf;
        
        _checkImgView=[[SpellOrderCommentCheckImageView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height)];
        
        _checkImgView.cancelBlock = ^(NSInteger index) {
            [weakSelf cancelAction];
        };
        
        _checkImgView.deleteBlock = ^(NSInteger index) {
            [weakSelf deleteImgWithIndex:index];
        };
        
    }
    
    return _checkImgView;
}
-(SpellOrderAfterSaleBottomView *)bottomView
{
    if (!_bottomView) {
        MJWeakSelf;
        
        _bottomView=[[SpellOrderAfterSaleBottomView alloc]initWithFrame:CGRectMake(0, KMAINSIZE.height-KBottomHeight-50-KNaviHeight, KMAINSIZE.width, 50)];
        
        _bottomView.btnBlock = ^(NSInteger index) {
            
            [weakSelf bottomBtnAction:index];
            
        };
        
    }
    return _bottomView;
}
-(SpellOrderAfterSaleSelectView *)disposeSelectView
{
    if (!_disposeSelectView) {
        _disposeSelectView=[[SpellOrderAfterSaleSelectView alloc]initWithType:0 andFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height)];
        
    }
    return _disposeSelectView;
}
-(SpellOrderAfterSaleSelectView *)reasonSelectView
{
    if (!_reasonSelectView) {
        _reasonSelectView=[[SpellOrderAfterSaleSelectView alloc]initWithType:1 andFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height)];
        
    }
    return _reasonSelectView;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
