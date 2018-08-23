//
//  PhoneViewController.m
//  FengXH
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PhoneViewController.h"
#import "HBNavigationController.h"
#import "PhoneCollectionViewCell.h"
#import "DialCollectionViewCell.h"
#import "PhoneRecordViewController.h"
@interface PhoneViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) UITextField *textLabel;
@property (nonatomic ,strong) NSArray *arr;
@property (nonatomic ,strong) NSArray *imgArr;
@end

@implementation PhoneViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *returnBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20+KTopHeight, 44, 44)];
    [returnBtn setImage:[UIImage imageNamed:@"erji_fanhui"] forState:UIControlStateNormal];
    [returnBtn addTarget:self action:@selector(btnTarget:) forControlEvents:UIControlEventTouchUpInside];
    returnBtn.tag = 6001;
    [self.view addSubview:returnBtn];
    [self setSubView];
    [self.view addSubview:self.collectionView];
    _arr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"*",@"0",@"#"];
    _imgArr = @[@"折扣商城",@"拨打电话",@"通话记录"];
}
- (void)btnTarget:(UIButton *)sender{
    
    if (sender.tag == 6001) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        if (self.textLabel.text.length>0) {
            self.textLabel.text = [_textLabel.text substringToIndex:_textLabel.text.length - 1];
        }
    }
    
}

- (void)setSubView{
    UIButton *deleteBtn = [[UIButton alloc]initWithFrame:CGRectMake(KMAINSIZE.width - 70*KScreenRatio, 96+KBottomHeight, 35*KScreenRatio, 20)];
    [deleteBtn setImage:[UIImage imageNamed:@"号码退回"] forState:UIControlStateNormal];
    deleteBtn.tag = 6002;
    [deleteBtn addTarget:self action:@selector(btnTarget:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:deleteBtn];
    
    _textLabel = [[UITextField alloc]initWithFrame:CGRectMake(50*KScreenRatio, 86+KBottomHeight, KMAINSIZE.width-120*KScreenRatio, 40)];
    _textLabel.textAlignment = NSTextAlignmentCenter;
    _textLabel.font = KFont(30);
    _textLabel.enabled = NO;
    if(self.phoneNum == nil){
        _textLabel.text = @"";
    }else{
        _textLabel.text = self.phoneNum;
    }
    
    
    [self.view addSubview:_textLabel];
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        flowLayout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200+KBottomHeight, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight) collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        //注册cell
        [_collectionView registerClass:[PhoneCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([PhoneCollectionViewCell class])];
        [_collectionView registerClass:[DialCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([DialCollectionViewCell class])];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
    }
    return _collectionView;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    return NO;
    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 12;
    }else{
        return 3;
    }
    
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section == 0) {
        PhoneCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([PhoneCollectionViewCell class]) forIndexPath:indexPath];
        [cell setTitle:_arr[indexPath.item] andLetter:nil];
        return cell;
    }else{
       DialCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([DialCollectionViewCell class]) forIndexPath:indexPath];
        [cell setImg:_imgArr[indexPath.item]];
        return cell;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(85*KScreenRatio, 75);
}
//边距设置:整体边距的优先级，始终高于内部边距的优先级
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 50*KScreenRatio, 10, 50*KScreenRatio);

}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        if (self.textLabel.text.length <13 ) {
            NSString *str = [NSString stringWithFormat:@"%@%@",self.textLabel.text,_arr[indexPath.item]];
            self.textLabel.text = str;
        }
        
    }else{
        if (indexPath.item == 0) {
            NSLog(@"商城");
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://shop.xmhualao.com/home/index?id=e1106916-a66c-4e9c-9693-3d9c6aeeb1b0"]];
        }else if (indexPath.item == 1){
            NSLog(@"通话");
            [self request];
        }else{
            NSLog(@"记录");
            PhoneRecordViewController *vc = [[PhoneRecordViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

    return 20;

}
- (void)request{
    
    
    NSString *url = @"r=apply.hlapi.dial";
    NSString *path = [HBBaseAPI appendAPIurl:url];
    
    NSString *token = [[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:@{@"token":token,@"num":self.textLabel.text} WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        if ([responseDic[@"status"] integerValue] == 1) {
            
            [DBHUD ShowInView:self.view withTitle:@"电话接通中..."];
//            [[NSUserDefaults standardUserDefaults] setObject:[NSDate date] forKey:self.lastUpdatedTimeKey];
        }
        [DBHUD ShowInView:self.view withTitle:[responseDic objectForKey:@"message"]];
        NSDate * date = [NSDate date];
        NSTimeInterval sec = [date timeIntervalSinceNow];
        NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
        
        //设置时间输出格式：
        NSDateFormatter * df = [[NSDateFormatter alloc] init ];
        [df setDateFormat:@"MM月dd日 HH:mm"];
        NSString * na = [df stringFromDate:currentDate];
        NSLog(@"%@",[responseDic objectForKey:@"message"]);
        
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"PhoneData"] == nil) {
            NSMutableArray *arr = [[NSMutableArray alloc]init];
            [arr addObject:@{@"phoneNum":self.textLabel.text,@"time":na}];
            [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"PhoneData"];
        }else{
            NSMutableArray *arr = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"PhoneData"]];
            [arr addObject:@{@"phoneNum":self.textLabel.text,@"time":na}];
            [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"PhoneData"];
        }
        
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
