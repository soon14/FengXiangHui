//
//  HomepageSeventhView.m
//  FengXH
//
//  Created by sun on 2018/7/10.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageSeventhView.h"
#import "HomepageSeventhItem.h"

#define imageWidth 85

@interface HomepageSeventhView()

/** 商品 */
@property(nonatomic , strong)NSArray *goodsArr;
/** block */
@property(nonatomic , strong)SeventhCellBlock seventhClickBlock;

@end

@implementation HomepageSeventhView

#pragma mark 静态初始化方法
+ (instancetype)direcWithtFrame:(CGRect)frame
                 GoodsInfoArray:(NSArray *)goodsInfoArray
                   SeventhBlock:(SeventhCellBlock)seventhBlock;
{
    return [[HomepageSeventhView alloc]initWithtFrame:frame
                                       GoodsInfoArray:goodsInfoArray
                                         SeventhBlock:seventhBlock];
}

#pragma mark 默认初始化方法
- (instancetype)initWithtFrame:(CGRect)frame
                GoodsInfoArray:(NSArray *)goodsInfoArray
                  SeventhBlock:(SeventhCellBlock)seventhBlock;
{
    if(self=[self initWithFrame:frame])
    {
        
        //
        self.goodsArr = goodsInfoArray;
        
        //设置图片点击的Block
        self.seventhClickBlock = seventhBlock;
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
    
    //设置ScrollView的contentSize
    if (self.goodsArr.count<5) {
        self.direct.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 0);
    } else {
        self.direct.contentSize = CGSizeMake(self.goodsArr.count*imageWidth, 0);
    }
    
    for (NSInteger tag=0; tag<self.goodsArr.count; tag++) {
        HomepageSeventhItem *itemView = [[HomepageSeventhItem alloc]initWithFrame:CGRectMake(imageWidth*tag, 0, imageWidth, self.frame.size.height)];
        HomepageDataSecondKillGoodsModel *goodsModel = self.goodsArr[tag];
        [itemView.goodsImageView setYy_imageURL:[NSURL URLWithString:goodsModel.thumb]];
        [itemView.nowPriceLabel setText:[NSString stringWithFormat:@"¥%@",goodsModel.price]];
        
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥%@",goodsModel.marketprice] attributes:@{NSFontAttributeName:KFont(11), NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid), NSStrikethroughColorAttributeName:[UIColor lightGrayColor], NSBaselineOffsetAttributeName:@(0)}];
        [itemView.originPriceLabel setAttributedText:attString];
        
        //添加手势
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageClick:)];
        [self.direct addSubview:itemView];
        [itemView addGestureRecognizer:tap];
        //设置tag
        itemView.tag = tag;
    }
}

#pragma mark 图片点击事件
-(void)imageClick:(UITapGestureRecognizer *)tap
{
    UIView *view=tap.view;
    if(self.seventhClickBlock)
    {
        self.seventhClickBlock(view.tag);
    }
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
