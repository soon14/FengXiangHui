//
//  HomepageBaseGoodsDetailController.m
//  FengXH
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageBaseGoodsDetailController.h"
#import "MyTeamTopView.h"
#import "HomepageGoodsDetailController.h"
#import "HomepageGoodsDetailBottomView.h"
#import "HomepageGoodsDetailModel.h"
#import "HomepageGoodsSelectView.h"
#import "ConfirmOrderViewController.h"
#import "QMChatRoomViewController.h"
#import <QMChatSDK/QMChatSDK.h>
#import <QMChatSDK/QMChatSDK-Swift.h>

#import "QMChatRoomGuestBookViewController.h"
#import "QMAlert.h"
#import "QMManager.h"

#define ServiceAppKey @"23327890-e082-11e7-82ef-59ca8660f8ce"

@interface HomepageBaseGoodsDetailController ()<UIScrollViewDelegate>
{
    BOOL isFavorite;
    
    NSDictionary *selectGoodsDic;
    
}
//scrollview
@property(nonatomic,strong)UIScrollView *baseScrollView;
//顶部view
@property(nonatomic , strong)MyTeamTopView *topButtonView;
//底部view
@property(nonatomic , strong)HomepageGoodsDetailBottomView *bottomView;
//客服按钮
@property(nonatomic,strong)UIButton *serviceBtn;
//model
@property(nonatomic)HomepageGoodsDetailModel *dataModel;
//记录当前的视图控制器
@property(nonatomic,strong)UIViewController *currentVC;
//选择商品数量view
@property(nonatomic,strong)HomepageGoodsSelectView *selectView;


@property (nonatomic, assign) BOOL isPushed;
@property (nonatomic, assign) BOOL isConnecting;
@property (nonatomic, strong) UIActivityIndicatorView *indicatorView;
@property (nonatomic, copy) NSDictionary * dictionary;

@end

@implementation HomepageBaseGoodsDetailController

- (void)viewWillAppear:(BOOL)animated {
    self.isPushed = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"商品详情";
    
    isFavorite=NO;
    
    //顶部view
    [self.view addSubview:self.topButtonView];
    
    //添加子控制器
    [self AddChildViewControllers];
    
    //添加scrollview
    [self.view addSubview:self.baseScrollView];
    
    [self scrollViewDidEndScrollingAnimation:self.baseScrollView];
    
    [self httpRequest];
    
    //客服相关
    self.isConnecting = NO;
    self.isPushed = NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerSuccess:) name:CUSTOM_LOGIN_SUCCEED object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(registerFailure:) name:CUSTOM_LOGIN_ERROR_USER object:nil];
    
}
-(void)addBottomViewAndServiceButton
{
    //添加底部view
    [self.view addSubview:self.bottomView];
    //添加客服按钮
    [self.view addSubview:self.serviceBtn];
    [_serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.mas_equalTo(self.bottomView.mas_top).offset(-5);
        make.height.width.mas_offset(30);
    }];
}
//数据请求
-(void)httpRequest
{
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    NSString * urlString = @"r=apply.goods.detail";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    NSDictionary *paramDic;
    if (tokenStr.length>0) {
        paramDic=@{@"id":self.goodsId?self.goodsId:@"",@"token":tokenStr};
    }
    else
    {
        paramDic=@{@"id":self.goodsId?self.goodsId:@""};
    }
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            [self addBottomViewAndServiceButton];
            
            self.dataModel = [HomepageGoodsDetailModel yy_modelWithDictionary:responseDic[@"result"]];
            
            if (_dataModel.isFavorite) {
                [_bottomView.attentionBtn setTitleColor:KRedColor forState:UIControlStateNormal];
                [_bottomView.attentionBtn setImage:[UIImage imageNamed:@"关注红"] forState:UIControlStateNormal];
                isFavorite=YES;
                isFavorite = YES;
            }
            _bottomView.attentionBtn.userInteractionEnabled=YES;
            for (int i=0;i<2;i++) {
                UIViewController *childVC=self.childViewControllers[i];
                HomepageGoodsDetailController *vc=(HomepageGoodsDetailController *)childVC;
                
                vc.dataModel=self.dataModel;
                
                [vc reloadData];
            }
        
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        
    }];
}
#pragma mark - 添加子控制器
- (void)AddChildViewControllers {
    
    HomepageGoodsDetailController *goodsVC = [[HomepageGoodsDetailController alloc]initWithType:0];
    MJWeakSelf
    goodsVC.selectBlock = ^{
        [weakSelf selectViewShowWithType:0];
    };
    HomepageGoodsDetailController *detailVC = [[HomepageGoodsDetailController alloc]initWithType:1];
    
    [self addChildViewController:goodsVC];
    [self addChildViewController:detailVC];
    
    
}
#pragma mark -<UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView == self.baseScrollView) {
        NSInteger index = scrollView.contentOffset.y / scrollView.frame.size.height;
        UIViewController *chileview = self.childViewControllers[index];
        CGRect frame = {{0, scrollView.contentOffset.y }, scrollView.frame.size};
        chileview.view.frame = frame;
        [self.currentVC.view removeFromSuperview];
        [scrollView addSubview:chileview.view];
        self.currentVC=chileview;
        
    }
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.baseScrollView) {
        CGFloat scale = scrollView.contentOffset.y/2;
        _topButtonView.moveLine.frame = CGRectMake(scale/scrollView.height*scrollView.width, 40, KMAINSIZE.width/2, 2);
        if (scale<scrollView.height/2/2) {
            [_topButtonView.stairShopkeeper setTitleColor:KUIColorFromHex(0xff463c) forState:UIControlStateNormal];
            [_topButtonView.secondShopkeeper setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            
        } else if (scale>scrollView.height/2/2 && scale<(scrollView.height/2/2)*3) {
            [_topButtonView.stairShopkeeper setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_topButtonView.secondShopkeeper setTitleColor:KUIColorFromHex(0xff463c) forState:UIControlStateNormal];
            
        }
        
    }
    
}

#pragma mark - 顶部类型按钮被点击
- (void)chooseTheTitle:(NSInteger)index {
    CGPoint offset = self.baseScrollView.contentOffset;
    offset.y = index * self.baseScrollView.frame.size.height;
    [self.baseScrollView setContentOffset:offset animated:YES];
}

#pragma mark-----底部按钮被点击
-(void)bottomBtnClick:(NSInteger)index
{
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    if (tokenStr.length<=0) {
        [self presentLoginViewController];
        return;
    }
    switch (index) {
        case 0:
            if (isFavorite==YES) {
                //已关注 点击要取消关注
                [_bottomView.attentionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                [_bottomView.attentionBtn setImage:[UIImage imageNamed:@"关注"] forState:UIControlStateNormal];
                
            }
            else
            {
                //未关注 点击要关注
                [_bottomView.attentionBtn setTitleColor:KRedColor forState:UIControlStateNormal];
                [_bottomView.attentionBtn setImage:[UIImage imageNamed:@"关注红"] forState:UIControlStateNormal];
                
            }
            isFavorite=!isFavorite;
            break;
        case 1:
            
            self.tabBarController.selectedIndex=3;
            
            [self.navigationController popToRootViewControllerAnimated:YES];

            break;
        case 2:
            [self selectViewShowWithType:1];
            break;
        case 3:
        {
            CGFloat nowTimeStmp = [[ShareManager getNowTimeTimestamp] doubleValue];
            if (![_dataModel.seckillinfo  isEqual:[NSNull null]] && _dataModel.seckillinfo != nil && _dataModel.seckillinfo != NULL && nowTimeStmp <= [_dataModel.seckillinfo.starttime doubleValue]) {
            
                [JHSysAlertUtil presentAlertViewWithTitle:nil message:@"秒杀还未开始" confirmTitle:@"知道了" handler:nil];
            }
            else
            {
                [self selectViewShowWithType:2];
            }
        }
            break;
        default:
            break;
    }
}
#pragma mark--- 立即购买（需完善）
-(void)goToBuy
{
    ConfirmOrderViewController *VC = [[ConfirmOrderViewController alloc] init];
    VC.goodsID = self.goodsId;
    VC.optionID = [_dataModel.options[_selectView.selectBtn.tag-300] optionsId];
    VC.goodsNum = _selectView.countBtn.titleLabel.text;
    [self.navigationController pushViewController:VC animated:YES];

}
#pragma mark--- 加入购物车
-(void)addToCart
{
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    NSString *urlStr=[NSString stringWithFormat:@"r=apply.cart.add&token=%@",tokenStr];
    NSString *path = [HBBaseAPI appendAPIurl:urlStr];
    NSDictionary *paramDic;
    if (_dataModel.hasoption) {
        paramDic=@{@"id":self.goodsId,@"total":_selectView.countBtn.titleLabel.text,@"optionid":[_dataModel.options[_selectView.selectBtn.tag-300] optionsId]};
    }
    else
    {
        paramDic=@{@"id":self.goodsId,@"total":_selectView.countBtn.titleLabel.text};
    }
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:paramDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            [DBHUD ShowInView:self.view withTitle:@"添加到购物车成功"];
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        
    }];
}
//更新列表上的请选择数量
-(void)upDateSelect
{
    UIViewController *childVC=self.childViewControllers[0];
    HomepageGoodsDetailController *vc=(HomepageGoodsDetailController *)childVC;
    NSString *str;
    if (_dataModel.hasoption) {
        str=[NSString stringWithFormat:@"已选：数量*%@   %@",_selectView.countBtn.titleLabel.text,_selectView.selectBtn.titleLabel.text];
    }
    else
    {
        str=[NSString stringWithFormat:@"已选：数量*%@",_selectView.countBtn.titleLabel.text];
    }
    vc.selectText=str;
    [vc.goodsTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
}
-(void)okAction
{
    [self upDateSelect];
    switch (_selectView.selectType) {
        case 0:
            
            break;
        case 1:
            [self addToCart];
            break;
        case 2:
            [self goToBuy];
            break;
            
        default:
            break;
    }
}
#pragma mark----添加或移除关注
-(void)addOrRemoveAttentionWithUrl:(NSString *)urlStr
{
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    NSDictionary *pathDic;
    if ([urlStr isEqualToString:@"r=apply.favorite.toggle"]) {
//        添加关注
       pathDic=@{@"isFavorite":@1,@"id":self.goodsId,@"token":tokenStr};
    }
    else
    {
        //移除关注 r=apply.favorite.remove
        pathDic=@{@"isfavorite":@0,@"goodsid":_dataModel.goodsId,@"token":tokenStr};
    }
    NSString *path = [HBBaseAPI appendAPIurl:urlStr];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:pathDic WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        
    }];
}
-(void)selectViewShowWithType:(NSInteger )selectType
{
    if (!_selectView) {
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        [window addSubview:self.selectView];
        _selectView.goodsMessageModel=_dataModel;
        _selectView.selectType=selectType;
    }
    else
    {
        _selectView.hidden=NO;
        _selectView.selectType=selectType;
    }
}
#pragma mark------点击客服按钮
-(void)serviceAction
{
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    if (tokenStr.length<=0) {
        [self presentLoginViewController];
        return;
    }
    
    [self.indicatorView startAnimating];
    
    // 按钮连点控制
    if (self.isConnecting) {
        return;
    }
    self.isConnecting = YES;
    
    /**
     accessId:  接入客服系统的密钥， 登录web客服系统（渠道设置->移动APP客服里获取）
     userName:  用户名， 区分用户， 用户名可直接在后台会话列表显示
     userId:    用户ID， 区分用户（只能使用  数字 字母(包括大小写) 下划线）
     以上3个都是必填项
     */
    
    [QMConnect registerSDKWithAppKey:ServiceAppKey userName:[[NSUserDefaults standardUserDefaults] objectForKey:KUserMobile] userId:[[NSUserDefaults standardUserDefaults] objectForKey:KUserId]];
}

#pragma mark-----懒加载
- (MyTeamTopView *)topButtonView {
    if (!_topButtonView) {
        _topButtonView = [[MyTeamTopView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, 42)];
        [_topButtonView.stairShopkeeper setTitle:@"商品" forState:UIControlStateNormal];
        [_topButtonView.secondShopkeeper setTitle:@"详情" forState:UIControlStateNormal];
        MJWeakSelf
        _topButtonView.myTeamBlock = ^(NSInteger index) {
            [weakSelf chooseTheTitle:index];
        };
    }
    return _topButtonView;
}
-(HomepageGoodsDetailBottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[HomepageGoodsDetailBottomView alloc]initWithFrame:CGRectMake(0, KMAINSIZE.height-KNaviHeight-50-KBottomHeight, KMAINSIZE.width, 50)];
        
        MJWeakSelf
        _bottomView.bottomBlock = ^(NSInteger index) {
            [weakSelf bottomBtnClick:index];
        };
        
    }
    return _bottomView;
}
-(UIScrollView *)baseScrollView
{
    if (!_baseScrollView) {
        _baseScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 42, KMAINSIZE.width, KMAINSIZE.height-42-50-KNaviHeight-KBottomHeight)];
        _baseScrollView.delegate = self;
        _baseScrollView.pagingEnabled = YES;
        _baseScrollView.showsVerticalScrollIndicator=NO;
        _baseScrollView.contentSize = CGSizeMake(KMAINSIZE.width, (KMAINSIZE.height-42-50-KNaviHeight-KBottomHeight)*self.childViewControllers.count);
    }
    return _baseScrollView;
}
-(UIButton *)serviceBtn
{
    if (!_serviceBtn) {
        _serviceBtn=[[UIButton alloc]init];
        [_serviceBtn setImage:[UIImage imageNamed:@"客服"] forState:UIControlStateNormal];
        [_serviceBtn addTarget:self action:@selector(serviceAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _serviceBtn;
}
-(HomepageGoodsSelectView *)selectView
{
    if (!_selectView) {
        _selectView=[[HomepageGoodsSelectView alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KBottomHeight)];
        MJWeakSelf
        _selectView.selectBlock = ^{
            [weakSelf okAction];
        };
    }
    return _selectView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (isFavorite!=_dataModel.isFavorite) {
        if (isFavorite==NO) {
            
            [self addOrRemoveAttentionWithUrl:@"r=apply.favorite.remove"];
        }
        else
        {
            
            [self addOrRemoveAttentionWithUrl:@"r=apply.favorite.toggle"];
        }
    }
    
    self.isPushed = YES;
}

#pragma mark----客服注册成功
- (void)registerSuccess:(NSNotification *)sender {
    NSLog(@"注册成功");
    
    if ([QMManager defaultManager].selectedPush) {
        [self showChatRoomViewController:@"" processType:@"" entranceId:@""]; //
    }else{
        
        // 页面跳转控制
        if (self.isPushed) {
            return;
        }
        
        [QMConnect sdkGetWebchatScheduleConfig:^(NSDictionary * _Nonnull scheduleDic) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.dictionary = scheduleDic;
                if ([self.dictionary[@"scheduleEnable"] intValue] == 1) {
                    NSLog(@"日程管理");
                    [self starSchedule];
                }else{
                    NSLog(@"技能组");
                    [self getPeers];
                }
            });
        } failBlock:^{
            
        }];
    }
    
    [QMManager defaultManager].selectedPush = NO;
    
    
}
#pragma mark----客服注册失败
- (void)registerFailure:(NSNotification *)sender {
    NSLog(@"注册失败::%@", sender.object);
    self.isConnecting = NO;
    [self.indicatorView stopAnimating];
}

#pragma mark - 技能组选择
- (void)getPeers {
    [QMConnect sdkGetPeers:^(NSArray * _Nonnull peerArray) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *peers = peerArray;
            self.isConnecting = NO;
            [_indicatorView stopAnimating];
            if (peers.count == 1 && peers.count != 0) {
                [self showChatRoomViewController:[peers.firstObject objectForKey:@"id"] processType:@"" entranceId:@""];
            }else {
                [self showPeersWithAlert:peers messageStr:NSLocalizedString(@"title.type", nil)];
            }
        });
    } failureBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.indicatorView stopAnimating];
            self.isConnecting = NO;
        });
    }];
}

#pragma mark - 日程管理
- (void)starSchedule {
    self.isConnecting = NO;
    [_indicatorView stopAnimating];
    if ([self.dictionary[@"scheduleId"]  isEqual: @""] || [self.dictionary[@"processId"]  isEqual: @""] || [self.dictionary objectForKey:@"entranceNode"] == nil || [self.dictionary objectForKey:@"leavemsgNodes"] == nil) {
        [QMAlert showMessage:NSLocalizedString(@"title.sorryconfigurationiswrong", nil)];
    }else{
        NSDictionary *entranceNode = self.dictionary[@"entranceNode"];
        NSArray *entrances = entranceNode[@"entrances"];
        if (entrances.count == 1 && entrances.count != 0) {
            [self showChatRoomViewController:[entrances.firstObject objectForKey:@"processTo"] processType:[entrances.firstObject objectForKey:@"processType"] entranceId:[entrances.firstObject objectForKey:@"_id"]];
        }else{
            [self showPeersWithAlert:entrances messageStr:NSLocalizedString(@"title.schedule_type", nil)];
        }
    }
}

- (void)showPeersWithAlert: (NSArray *)peers messageStr: (NSString *)message {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:NSLocalizedString(@"title.type", nil) preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"button.cancel", nil) style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        self.isConnecting = NO;
    }];
    [alertController addAction:cancelAction];
    for (NSDictionary *index in peers) {
        UIAlertAction *surelAction = [UIAlertAction actionWithTitle:[index objectForKey:@"name"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([self.dictionary[@"scheduleEnable"] integerValue] == 1) {
                [self showChatRoomViewController:[index objectForKey:@"processTo"] processType:[index objectForKey:@"processType"] entranceId:[index objectForKey:@"_id"]];
            }else{
                [self showChatRoomViewController:[index objectForKey:@"id"] processType:@"" entranceId:@""];
            }
        }];
        [alertController addAction:surelAction];
    }
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 跳转聊天界面
- (void)showChatRoomViewController:(NSString *)peerId processType:(NSString *)processType entranceId:(NSString *)entranceId {
    QMChatRoomViewController *chatRoomViewController = [[QMChatRoomViewController alloc] init];
    chatRoomViewController.peerId = peerId;
    chatRoomViewController.isPush = NO;
    chatRoomViewController.avaterStr = @"";
    if ([self.dictionary[@"scheduleEnable"] intValue] == 1) {
        chatRoomViewController.isOpenSchedule = true;
        chatRoomViewController.scheduleId = self.dictionary[@"scheduleId"];
        chatRoomViewController.processId = self.dictionary[@"processId"];
        chatRoomViewController.currentNodeId = peerId;
        chatRoomViewController.processType = processType;
        chatRoomViewController.entranceId = entranceId;
    }else{
        chatRoomViewController.isOpenSchedule = false;
    }
    [self.navigationController pushViewController:chatRoomViewController animated:YES];
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CUSTOM_LOGIN_SUCCEED object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CUSTOM_LOGIN_ERROR_USER object:nil];
}

@end
