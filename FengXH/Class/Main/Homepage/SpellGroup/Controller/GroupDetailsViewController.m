//
//  GroupDetailsViewController.m
//  FengXH
//
//  Created by mac on 2018/8/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "GroupDetailsViewController.h"
#import "GroupDetailsMenu.h"
#import "GroupDetailsBaseViewController.h"//团详情 商品详情
#import "GroupDetailCollectionViewCell.h"
#import "FootCollectionReusableView.h"
#import "GroupEndCollectionViewCell.h"
#import "GroupInCollectionViewCell.h"
@interface GroupDetailsViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic ,strong)GroupDetailsMenu *mySpellHeaderView;
@property(nonatomic ,strong)UIScrollView *basicScrollView;
@property(nonatomic ,strong)UICollectionView *collectionView;
@property(nonatomic ,assign)NSInteger spellType;
@property(nonatomic ,strong)NSArray *ordersArr;
@property(nonatomic ,strong)NSDictionary *dataDic;
@property(nonatomic,strong) NSTimer *countDownTimer;
@end

@implementation GroupDetailsViewController
{
    NSInteger x;
    NSInteger secondsCountDown;
}
//static NSInteger  secondsCountDown;
- (void)viewWillDisappear:(BOOL)animated{
    [self.countDownTimer invalidate];
    self.countDownTimer = nil;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"团详情";
     
    [self Request];
    
    
}
- (void)setTiemView{
    NSDate *nowDate = [NSDate date]; // 当前日期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH-mm-ss";
    NSDate *creat = [formatter dateFromString:[_dataDic objectForKey:@"endtime"]];// 将传入的字符串转化成时间
    NSTimeInterval delta = [nowDate timeIntervalSinceDate:creat];
    secondsCountDown = -delta;
    self.countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
    
}
-(void)countDownAction{
    //倒计时-1
    secondsCountDown--;
    if(secondsCountDown < 0){
        [_countDownTimer invalidate];
        secondsCountDown = 0;
        
    }
    [self.collectionView reloadData];
}
- (void)footView{
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, KMAINSIZE.height-KBottomHeight-50-KNaviHeight, KMAINSIZE.width, 50)];
    footView.backgroundColor = [UIColor redColor];
    [self.view addSubview:footView];
    
    UIButton *shareBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, KMAINSIZE.width-62, 50)];
    [shareBtn setTitle:@"快邀请好友参团吧" forState:UIControlStateNormal];
    shareBtn.backgroundColor = KUIColorFromHex(0xec6258);
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    shareBtn.tag = 3001;
    [shareBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:shareBtn];
    
    UIButton *homeBtn = [[UIButton alloc]initWithFrame:CGRectMake(KMAINSIZE.width-62, 0, 62, 50)];
    [homeBtn setImage:[UIImage imageNamed:@"返回首页"] forState:UIControlStateNormal];
    homeBtn.tag = 3002;
    [homeBtn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:homeBtn];
}
- (void)btnAction:(UIButton *)selectBtn{
    if (selectBtn.tag == 3001) {
        NSLog(@"分享");
        NSString *linkURL = [[_dataDic objectForKey:@"requesturl"] objectForKey:@"link"];
        NSString *shareURL = [linkURL stringByReplacingOccurrencesOfString:@"https://" withString:@"https://www."];
        NSArray *arr = @[[[_dataDic objectForKey:@"requesturl"] objectForKey:@"imgUrl"]];
        [ShareManager shareWithTitle:[[_dataDic objectForKey:@"requesturl"] objectForKey:@"title"] andMessage:[[_dataDic objectForKey:@"requesturl"] objectForKey:@"desc"] andUrl:shareURL andImg:arr];
    }else{
        NSLog(@"返回首页");
        self.tabBarController.selectedIndex = 0;
        [self.navigationController popToRootViewControllerAnimated:YES];
        
    }
}
- (void)setType:(NSInteger)type{
    self.spellType = type;
}
- (void)Request{
    NSString * urlString = @"r=apply.groups.team.detail";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:@{@"token":tokenStr,@"teamid":self.teamId} WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            
            _dataDic = [responseDic objectForKey:@"result"];
            if (self.spellType == 0){
            [self setTiemView];
            }
            _ordersArr = [[responseDic objectForKey:@"result"] objectForKey:@"orders"];
            if ([[_dataDic objectForKey:@"last"] isEqualToString:@"团购已结束"]) {
                x = 0;
            }else{
                [self footView];
                x = 1;
            }
            [self.view addSubview:self.collectionView];
        }
        
        
        
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        
    }];
}


#pragma mark - 顶部菜单型按钮
- (GroupDetailsMenu *)mySpellHeaderView {
    if (!_mySpellHeaderView) {
        _mySpellHeaderView = [[GroupDetailsMenu alloc]initWithType:1];
        _mySpellHeaderView.frame=CGRectMake(0, 0, KMAINSIZE.width, 42);
        MJWeakSelf
        _mySpellHeaderView.spellTypeBlock = ^(NSInteger index) {
            [weakSelf chooseTheTitle:index];
        };
    }
    return _mySpellHeaderView;
}
#pragma mark - 添加子控制器
- (void)AddChildViewControllers {
    GroupDetailsBaseViewController *allOrderVC = [[GroupDetailsBaseViewController alloc]initWithType:0];
    allOrderVC.dic = _dataDic;
    GroupDetailsBaseViewController *waitPaidVC = [[GroupDetailsBaseViewController alloc]initWithType:1];
    waitPaidVC.dic = _dataDic;
    [self addChildViewController:allOrderVC];
    [self addChildViewController:waitPaidVC];
    
    
}
#pragma mark - 底层 scrollView
- (UIScrollView *)basicScrollView {
    if (!_basicScrollView) {
        _basicScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 42, KMAINSIZE.width, KMAINSIZE.height-42)];
        _basicScrollView.delegate = self;
        _basicScrollView.pagingEnabled = YES;
        _basicScrollView.showsHorizontalScrollIndicator = NO;
        _basicScrollView.contentSize = CGSizeMake(self.childViewControllers.count*KMAINSIZE.width, KMAINSIZE.height-42);
    }
    return _basicScrollView;
}

#pragma mark -<UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (scrollView == self.basicScrollView) {
        NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
        UIViewController *chileview = self.childViewControllers[index];
        CGRect frame = {{scrollView.contentOffset.x , 0}, scrollView.frame.size};
        chileview.view.frame = frame;
        [scrollView addSubview:chileview.view];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

#pragma mark - 订单类型按钮被点击
- (void)chooseTheTitle:(NSInteger)index {
    CGPoint offset = self.basicScrollView.contentOffset;
    offset.x = index * self.basicScrollView.frame.size.width;
    [self.basicScrollView setContentOffset:offset animated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.basicScrollView) {
        CGFloat scale = scrollView.contentOffset.x/2;
        _mySpellHeaderView.moveLine.frame = CGRectMake(scale, 40, KMAINSIZE.width/2, 2);
        if (scale<KMAINSIZE.width/2/2) {
            [_mySpellHeaderView.firstBtn setTitleColor:KRedColor forState:UIControlStateNormal];
            [_mySpellHeaderView.secondBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            
        } else if (scale>KMAINSIZE.width/2/2 && scale<(KMAINSIZE.width/2/2)*2) {
            [_mySpellHeaderView.firstBtn setTitleColor:KUIColorFromHex(0x666666) forState:UIControlStateNormal];
            [_mySpellHeaderView.secondBtn setTitleColor:KRedColor forState:UIControlStateNormal];
            
        }
        
    }
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight-50*x) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        
        //注册cell
        [_collectionView registerClass:[GroupInCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([GroupInCollectionViewCell class])];
        [_collectionView registerClass:[GroupDetailCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([GroupDetailCollectionViewCell class])];
        [_collectionView registerClass:[GroupEndCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([GroupEndCollectionViewCell class])];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];


        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
    }
    return _collectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    if (self.spellType == 0) {
        return 4;
    }else{
        return 3;
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.spellType == 0) {
        if (section == 1) {
            return [[_dataDic objectForKey:@"n"] integerValue]+ _ordersArr.count;
        }else{
            return 1;
        }
    }else{
        if (section == 0) {
            return [[_dataDic objectForKey:@"n"] integerValue]+ _ordersArr.count;
        }else{
            return 1;
        }
    }
    
    
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.spellType == 0) {
        if (indexPath.section == 0) {
            NSString *str_hour = [NSString stringWithFormat:@"%02ld",(long)secondsCountDown/3600];//时
            NSString *str_minute = [NSString stringWithFormat:@"%02ld",(long)(secondsCountDown%3600)/60];//分
            NSString *str_second = [NSString stringWithFormat:@"%02ld",(long)secondsCountDown%60];//秒
            GroupInCollectionViewCell * cell1 = (GroupInCollectionViewCell *)cell;
            [cell1 setTime:str_hour AndStartTime:(NSString *)str_minute AndNum:[NSString stringWithFormat:@"%@",[_dataDic objectForKey:@"n"]] Andcount:str_second];
        }
        if (indexPath.section == 1) {
            GroupDetailCollectionViewCell * cell1 = (GroupDetailCollectionViewCell *)cell;
            if (indexPath.item<_ordersArr.count) {
                
                [cell1 setThumb:[_ordersArr[indexPath.item] objectForKey:@"avatar"] andMark:nil];
            }else{
                [cell1 setThumb:@"无头像" andMark:nil];
            }
        }
    }else{
        if (indexPath.section == 0) {
            GroupDetailCollectionViewCell * cell1 = (GroupDetailCollectionViewCell *)cell;
            if (indexPath.item<_ordersArr.count) {
                
                [cell1 setThumb:[_ordersArr[indexPath.item] objectForKey:@"avatar"] andMark:nil];
            }else{
                [cell1 setThumb:@"无头像" andMark:nil];
            }
        }
    }
    
    

}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.spellType == 0) {
        if (indexPath.section == 0) {
            GroupInCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GroupInCollectionViewCell class]) forIndexPath:indexPath];
            return cell;
        }else if (indexPath.section == 1) {
            GroupDetailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GroupDetailCollectionViewCell class]) forIndexPath:indexPath];
            return cell;
        }else if(indexPath.section == 2){
            GroupEndCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GroupEndCollectionViewCell class]) forIndexPath:indexPath];
            [cell setTitle:[_dataDic objectForKey:@"last"]];
            return cell;
        }else{
            UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
            [cell addSubview:self.mySpellHeaderView];
            
            //添加子控制器
            [self AddChildViewControllers];
            
            //添加滚动视图
            [cell addSubview:self.basicScrollView];
            
            [self scrollViewDidEndScrollingAnimation:self.basicScrollView];
            return cell;
        }
    }else{
        if (indexPath.section == 0) {
            GroupDetailCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GroupDetailCollectionViewCell class]) forIndexPath:indexPath];
            return cell;
        }else if(indexPath.section == 1){
            GroupEndCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GroupEndCollectionViewCell class]) forIndexPath:indexPath];
            [cell setTitle:[_dataDic objectForKey:@"last"]];
            return cell;
        }else{
            UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
            [cell addSubview:self.mySpellHeaderView];
            
            //添加子控制器
            [self AddChildViewControllers];
            
            //添加滚动视图
            [cell addSubview:self.basicScrollView];
            
            [self scrollViewDidEndScrollingAnimation:self.basicScrollView];
            return cell;
        }

    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.spellType == 0) {
        if (indexPath.section == 0) {
            return CGSizeMake(KMAINSIZE.width, 40);
        }else if (indexPath.section == 1){
            return CGSizeMake(45*KScreenRatio, 45);
        }
        else if(indexPath.section == 2){
            return CGSizeMake(KMAINSIZE.width, 50);
        }else{
            return CGSizeMake(KMAINSIZE.width, 670);
        }
    }else{
        if (indexPath.section == 0) {
            return CGSizeMake(45*KScreenRatio, 45);
        }else if(indexPath.section == 1){
            return CGSizeMake(KMAINSIZE.width, 50);
        }else{
            return CGSizeMake(KMAINSIZE.width, 670);
        }
    }
    
    
}
//边距设置:整体边距的优先级，始终高于内部边距的优先级
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    if (self.spellType == 0) {
        if (section == 1) {
            return UIEdgeInsetsMake(20, 60, 20, 60);
        }else{
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }else{
        if (section == 0) {
            return UIEdgeInsetsMake(20, 60, 20, 60);
        }else{
            return UIEdgeInsetsMake(0, 0, 0, 0);
        }
    }

    
}
//item 水平距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 40;
}
//item 垂直距离
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (self.spellType == 0) {
        if (section == 1) {
            return 40;
        }else{
            return 0;
        }
    }else{
        if (section == 0) {
            return 40;
        }else{
            return 0;
        }
    }
    
    
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
