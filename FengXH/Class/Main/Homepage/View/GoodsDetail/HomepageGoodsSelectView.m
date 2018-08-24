//
//  HomepageGoodsSelectView.m
//  FengXH
//
//  Created by mac on 2018/8/1.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageGoodsSelectView.h"
#import "HomepageGoodsDetailModel.h"

@interface HomepageGoodsSelectView ()<UIGestureRecognizerDelegate>
{
    UIView *bgView;
    UILabel *lab1;
}
//logo
@property(nonatomic,strong)UIImageView *logoImgView;
//价钱
@property(nonatomic,strong)UILabel *priceLab;
//身份证输入框
@property(nonatomic,strong)UITextField *idCardTF;

//选择
@property(nonatomic,strong)UIView *optionsView;

@end


@implementation HomepageGoodsSelectView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.7f];
        
        UITapGestureRecognizer *tapGes=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeAction)];
        tapGes.delegate=self;
        [self addGestureRecognizer:tapGes];
        
        bgView=[[UIView alloc]init];
        bgView.backgroundColor=[UIColor whiteColor];
        [self addSubview:bgView];
        [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_offset(0);
            make.height.mas_offset(430);
        }];
        
        _logoImgView=[[UIImageView alloc]init];
        _logoImgView.backgroundColor=[UIColor whiteColor];
        [bgView addSubview:_logoImgView];
        [_logoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.width.height.mas_offset(90);
            make.top.mas_offset(-20);
        }];
        
        UIButton *closeBtn=[[UIButton alloc]init];
        [closeBtn setImage:[UIImage imageNamed:@"login_icon_shutdown"] forState:UIControlStateNormal];
        [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
        [bgView addSubview:closeBtn];
        [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.right.mas_offset(-10);
            make.height.width.mas_offset(40);
        }];
        
        _priceLab=[[UILabel alloc]init];
        _priceLab.textColor=KRedColor;
        _priceLab.font=KFont(18);
        [bgView addSubview:_priceLab];
        [_priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_logoImgView.mas_right).mas_offset(10);
            make.top.mas_offset(10);
            make.right.mas_equalTo(closeBtn.mas_left);
            make.height.mas_offset(22);
        }];
        
        //身份证
        lab1=[[UILabel alloc]init];
        lab1.textColor=KUIColorFromHex(0x333333);
        lab1.text=@"身份证";
        lab1.font=KFont(14);
        [bgView addSubview:lab1];
        [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.top.mas_equalTo(_logoImgView.mas_bottom).offset(30);
            make.width.mas_offset(80);
            make.height.mas_offset(20);
        }];
        
        _idCardTF=[[UITextField alloc]init];
        _idCardTF.placeholder=@"请输入身份证";
        _idCardTF.textColor=KUIColorFromHex(0x333333);
        _idCardTF.font=KFont(14);
        _idCardTF.borderStyle=UITextBorderStyleNone;
        [bgView addSubview:_idCardTF];
        [_idCardTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(lab1.mas_right).offset(10);
            make.right.mas_offset(-10);
            make.top.bottom.mas_equalTo(lab1);
        }];
        
        //小黑线
        UILabel *lineLab=[[UILabel alloc]init] ;
        lineLab.backgroundColor=KUIColorFromHex(0xb2b2b2);
        [bgView addSubview:lineLab];
        [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.height.mas_offset(1);
            make.top.mas_equalTo(lab1.mas_bottom).offset(10);
        }];
        
        //数量
        UILabel *lab2=[[UILabel alloc]init];
        lab2.textColor=KUIColorFromHex(0x333333);
        lab2.text=@"数量";
        lab2.font=KFont(14);
        [bgView addSubview:lab2];
        [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.top.mas_equalTo(lineLab.mas_bottom).offset(10);
            make.width.mas_offset(80);
            make.height.mas_offset(20);
        }];
        
        UIButton *frontBtn;//记录前一个button
        for (int i=0; i<3; i++) {
            UIButton *btn=[[UIButton alloc]init];
            btn.layer.borderWidth=0.5;
            btn.tag=i+200;
            btn.layer.borderColor=KUIColorFromHex(0xb2b2b2).CGColor;
            [btn setTitleColor:KUIColorFromHex(0x333333) forState:UIControlStateNormal];
            [bgView addSubview:btn];
            if (i==0) {
                [btn setTitle:@"+" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(countAction:) forControlEvents:UIControlEventTouchUpInside];
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.height.mas_offset(30);
                    make.right.mas_offset(-10);
                    make.top.mas_equalTo(lineLab.mas_bottom).offset(10);
                }];
            }
            else if (i==1)
            {
                btn.userInteractionEnabled=NO;
                [btn setTitle:@"1" forState:UIControlStateNormal];
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.height.mas_offset(30);
                    make.right.mas_equalTo(frontBtn.mas_left);
                    make.top.mas_equalTo(lineLab.mas_bottom).offset(10);
                }];
                _countBtn=btn;
            }
            else
            {
                [btn setTitle:@"-" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(countAction:) forControlEvents:UIControlEventTouchUpInside];
                [btn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.width.height.mas_offset(30);
                    make.right.mas_equalTo(frontBtn.mas_left);
                    make.top.mas_equalTo(lineLab.mas_bottom).offset(10);
                }];
            }
            
            frontBtn=btn;
        }
        
        
        //确定按钮
        UIButton *bottomBtn=[[UIButton alloc]init];
        [bottomBtn setTitle:@"确定" forState:UIControlStateNormal];
        [bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [bottomBtn addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
        bottomBtn.backgroundColor=KRedColor;
        [bgView addSubview:bottomBtn];
        [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_offset(0);
            make.height.mas_offset(40);
        }];
        
        
        
    }
    return self;
}
//手势代理方法
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([touch.view isDescendantOfView:bgView]) {
        return NO;
    }
    
    return YES;
    
}
//确定按钮点击事件
-(void)okAction
{
    
    if (_goodsMessageModel.hasoption&&_selectBtn==nil) {
        [JHSysAlertUtil presentAlertViewWithTitle:nil message:@"请选择规格" confirmTitle:@"知道了" handler:nil];
        return;
    }
    
    self.hidden=YES;
    if (self.selectBlock) {
        self.selectBlock();
    }
}
//关闭页面
-(void)closeAction
{
    self.hidden=YES;
}
//数量加减
-(void)countAction:(UIButton *)sender
{
    int count=[_countBtn.titleLabel.text intValue];
    if (sender.tag==200) {
        //+
        count++;
    }
    else
    {
        if (count==1) {
            return;
        }
        count--;
    }
    [_countBtn setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateNormal];
}
//
-(void)optionsAction:(UIButton *)sender
{
    NSInteger index=sender.tag-300;
    
    [_logoImgView setYy_imageURL:[NSURL URLWithString:[_goodsMessageModel.options[index] thumb]]];
    _priceLab.text=[_goodsMessageModel.options[index] marketprice];
    
    [_selectBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _selectBtn.backgroundColor=KUIColorFromHex(0xeeeeee);
    
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sender.backgroundColor=KRedColor;
    
    _selectBtn=sender;
}

-(void)setGoodsMessageModel:(HomepageGoodsDetailModel *)goodsMessageModel
{
    _goodsMessageModel=goodsMessageModel;
    [_logoImgView setYy_imageURL:[NSURL URLWithString:goodsMessageModel.thumb]];
    
    if (![goodsMessageModel.seckillinfo  isEqual:[NSNull null]] && goodsMessageModel.seckillinfo != nil && goodsMessageModel.seckillinfo != NULL ) {
        //是秒杀的商品
        _priceLab.text=goodsMessageModel.seckillinfo.price;
    }
    else
    {
        _priceLab.text=goodsMessageModel.marketprice;
    }
    
    if (goodsMessageModel.hasoption) {
        if (!_optionsView) {
            [self addSubview:self.optionsView];
            [_optionsView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_offset(0);
                make.top.mas_equalTo(_logoImgView.mas_bottom).offset(30);
                make.height.mas_offset((goodsMessageModel.options.count/5+(goodsMessageModel.options.count%5==0?0:1))*40+10);
            }];
            [self createOptionUI];
            [lab1 mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(_logoImgView.mas_bottom).offset((goodsMessageModel.options.count/5+(goodsMessageModel.options.count%5==0?0:1))*40+10+10+20);
            }];
           
        }
        
        
        
    }
}
-(void)createOptionUI
{
    for (int i=0; i<_goodsMessageModel.options.count; i++) {
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(i%5*((KMAINSIZE.width-60)/5+10)+10, i/5*40, (KMAINSIZE.width-60)/5, 30)];
        btn.backgroundColor=KUIColorFromHex(0xeeeeee);
        btn.layer.cornerRadius=4;
        btn.titleLabel.adjustsFontSizeToFitWidth=YES;
        btn.titleLabel.font=KFont(14);
        btn.layer.rasterizationScale = [UIScreen mainScreen].scale;
        btn.layer.shouldRasterize = YES;
        btn.tag=i+300;
        [btn setTitle:[_goodsMessageModel.options[i] titleStr] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(optionsAction:) forControlEvents:UIControlEventTouchUpInside];
        [_optionsView addSubview:btn];
    }
    
    //小黑线
    UILabel *lineLab=[[UILabel alloc]init] ;
    lineLab.backgroundColor=KUIColorFromHex(0xb2b2b2);
    [_optionsView addSubview:lineLab];
    [lineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(1);
        make.bottom.mas_equalTo(_optionsView.mas_bottom).offset(-10);
    }];
}
#pragma mark-----懒加载
-(UIView *)optionsView
{
    if (!_optionsView) {
        _optionsView=[[UIView alloc] init];
    }
    return _optionsView;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
