//
//  HomepageNinthCell.m
//  FengXH
//
//  Created by sun on 2018/7/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageNinthView.h"
#import "HomepageNinthItem.h"

@interface HomepageNinthView()

/** 商品 */
@property(nonatomic , strong)NSArray *goodsArr;
/** block */
@property(nonatomic , strong)NinthCellBlock itemClickBlock;
/** 购物车block */
@property(nonatomic , strong)NinthCellBlock cartClickBlock;

@end


@implementation HomepageNinthView

#pragma mark 静态初始化方法
+ (instancetype)direcWithtFrame:(CGRect)frame
                 GoodsInfoArray:(NSArray *)goodsInfoArray
                     NinthBlock:(NinthCellBlock)ninthBlock
                 CartClickBlock:(NinthCellBlock)cartBlock;
{
    return [[HomepageNinthView alloc]initWithtFrame:frame
                                     GoodsInfoArray:goodsInfoArray
                                         NinthBlock:ninthBlock
                                     CartClickBlock:(NinthCellBlock)cartBlock];
}

#pragma mark 默认初始化方法
- (instancetype)initWithtFrame:(CGRect)frame
                GoodsInfoArray:(NSArray *)goodsInfoArray
                    NinthBlock:(NinthCellBlock)ninthBlock
                CartClickBlock:(NinthCellBlock)cartBlock;
{
    if(self=[self initWithFrame:frame])
    {
        
        //
        self.goodsArr = goodsInfoArray;
        
        //设置图片点击的Block
        self.itemClickBlock = ninthBlock;
        self.cartClickBlock = cartBlock;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        self.direct = [[UIScrollView alloc]init];
        self.direct.frame = self.bounds;
        self.direct.scrollsToTop = NO;
        self.direct.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.direct];
        
    }
    return self;
}


- (void)setGoodsArr:(NSArray *)goodsArr {
    _goodsArr = goodsArr;
    [self addGoodsToScrollView];
}

#pragma mark 将商品到ScrollView
-(void)addGoodsToScrollView
{
    if (self.goodsArr.count==0)
    {
        return;
    }
    
    CGFloat itemWidth = KMAINSIZE.width/3;
    
    //设置ScrollView的contentSize
    if (self.goodsArr.count<4) {
        self.direct.contentSize = CGSizeMake(KMAINSIZE.width, 0);
    } else {
        self.direct.contentSize = CGSizeMake(self.goodsArr.count*itemWidth, 0);
    }
    
    for (NSInteger tag=0; tag<self.goodsArr.count; tag++) {
        HomepageNinthItem *itemView = [[HomepageNinthItem alloc]initWithFrame:CGRectMake(itemWidth*tag, 0, itemWidth, self.frame.size.height)];
        [itemView.goodsImageView setYy_imageURL:[NSURL URLWithString:@"https://img.vipfxh.com//images//7//2017//11//T05Kk0swbWk9xu8wfU068Y6fYYF006.jpg"]];
        //添加手势
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
        [self.direct addSubview:itemView];
        [itemView addGestureRecognizer:tap];
        //设置tag
        itemView.tag = tag;
        MJWeakSelf
        itemView.ninthItemBlock = ^(NSInteger index) {
            [weakSelf cartButtonAction:tag];
        };
    }
}

#pragma mark 购物车按钮被点击
- (void)cartButtonAction:(NSInteger)index {
    if (self.cartClickBlock) {
        self.cartClickBlock(index);
    }
}

#pragma mark 图片点击事件
-(void)imageClick:(UITapGestureRecognizer *)tap
{
    UIView *view=tap.view;
    if(self.itemClickBlock)
    {
        self.itemClickBlock(view.tag);
    }
}


@end
