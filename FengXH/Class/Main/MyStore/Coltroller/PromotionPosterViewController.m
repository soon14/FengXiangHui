//
//  PromotionPosterViewController.m
//  FengXH
//
//  Created by mac on 2018/7/26.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PromotionPosterViewController.h"

@interface PromotionPosterViewController ()
{
    NSString *shareImgStr;
}
//imgview
@property(nonatomic,strong)UIImageView *shareImgView;

@property(nonatomic,strong)UIScrollView *scrollView;
//scrollview内容view
@property(nonatomic,strong)UIView *containerView;
//如何赚钱
@property(nonatomic,strong)UILabel *makeMoneyLab;
//说明
@property(nonatomic,strong)UILabel *remarkLab;

@end

@implementation PromotionPosterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"推广海报";
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    //导航右侧分享按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share"] style:UIBarButtonItemStylePlain target:self action:@selector(shareAction)];
    [self.navigationItem.rightBarButtonItem setTintColor:KUIColorFromHex(0x9a9a9a)];
    
    [self createUI];
    
    [self httpRequest];
    
}
//数据请求
-(void)httpRequest
{
    NSString * urlString = @"r=apply.commission.qrcode";
    NSString *path = [HBBaseAPI appendAPIurl:urlString];
    NSString *tokenStr=[[NSUserDefaults standardUserDefaults] objectForKey:KUserToken];
    [DBHUD ShowProgressInview:self.view Withtitle:nil];
    [[HBNetWork sharedManager] requestWithMethod:POST WithPath:path WithParams:@{@"token":tokenStr} WithSuccessBlock:^(NSDictionary *responseDic) {
        [DBHUD Hiden:YES fromView:self.view];
        shareImgStr=responseDic[@"result"][@"img"];
        if ([responseDic[@"status"] integerValue] == 1) {
            [_shareImgView yy_setImageWithURL:[NSURL URLWithString:responseDic[@"result"][@"img"]] placeholder:nil options:YYWebImageOptionProgressiveBlur completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
                [_shareImgView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_offset(KMAINSIZE.width/image.size.width*image.size.height);
                }];
            }];
            
        } else {
            [DBHUD ShowInView:self.view withTitle:KRequestError];
        }
    } WithFailureBlock:^(NSError *error) {
        [DBHUD Hiden:YES fromView:self.view];
        [DBHUD ShowInView:self.view withTitle:KNetworkError];
    }];
}
-(void)shareAction
{
    [ShareManager shareWithTitle:nil andMessage:nil andUrl:nil andImg:@[shareImgStr]] ;
}

-(void)createUI
{
    _scrollView=[[UIScrollView alloc]init];
    [self.view addSubview:_scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        
    }];
    
    _containerView=[[UIView alloc]init];
    [_scrollView addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_scrollView);
        make.width.equalTo(_scrollView);
    }];
    
    _shareImgView=[[UIImageView alloc] init];
    [_scrollView addSubview:_shareImgView];
    [_shareImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(_scrollView);
        make.height.mas_equalTo(0);
    }];
    
    NSString *makeMoneyStr=@"如何赚钱\n\n第一步 转发商品链接或商品图片给微信好友；\n\n第二步 从你链接进入商城的好友，系统将自动锁定成你的客户，他们在微商城中购买任何商品，您都可以获得店主佣金；\n\n第三步 您可以在小店中心查看【我的团队】和【佣金明细】，好友确认收货后佣金方可提现。";
    _makeMoneyLab=[[UILabel alloc]init];
    _makeMoneyLab.textColor=[UIColor blackColor];
    _makeMoneyLab.numberOfLines=0;
    _makeMoneyLab.font=KFont(16);
    _makeMoneyLab.text=makeMoneyStr;
    [_scrollView addSubview:_makeMoneyLab];
    [_makeMoneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_shareImgView.mas_bottom).offset(10);
        make.left.equalTo(_scrollView).offset(10);
        make.right.equalTo(_scrollView).offset(-10);
        make.height.mas_equalTo(240);
    }];

    UIView *remarkView=[[UIView alloc]init];
    remarkView.backgroundColor=KUIColorFromHex(0xE9852B);
    [_scrollView addSubview:remarkView];
    [remarkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_makeMoneyLab.mas_bottom).offset(20);
        make.left.equalTo(_scrollView).offset(20);
        make.right.equalTo(_scrollView).offset(-20);
        make.height.mas_equalTo(130);
        make.bottom.equalTo(_containerView.mas_bottom).offset(-20);
    }];
    
    NSString *remarkStr=@"说明：分享后会带有独有推荐码，您的好友访问之后，系统会自动检查并记录客户关系。如果您的好友已被其他人发展成了客户，他就不能成为你的客户，以最早发展成为客户为准";
    _remarkLab=[[UILabel alloc]init];
    _remarkLab.textColor=[UIColor whiteColor];
    _remarkLab.text=remarkStr;
    _remarkLab.numberOfLines=0;
    _remarkLab.font=KFont(16);
    [_scrollView addSubview:_remarkLab];
    [_remarkLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(remarkView).offset(10);
        make.left.equalTo(remarkView).offset(20);
        make.right.equalTo(remarkView).offset(-20);
        make.bottom.equalTo(remarkView).offset(-10);
    }];
    
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
