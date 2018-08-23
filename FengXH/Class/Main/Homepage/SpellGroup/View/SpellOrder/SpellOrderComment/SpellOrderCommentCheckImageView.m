//
//  SpellOrderCommentCheckImageView.m
//  FengXH
//
//  Created by mac on 2018/8/11.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderCommentCheckImageView.h"

@interface SpellOrderCommentCheckImageView ()<UIScrollViewDelegate>

{
    NSInteger page;
}

@property(nonatomic,strong)UIScrollView *imgScroll;

@end

@implementation SpellOrderCommentCheckImageView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor blackColor];
        
        _imgScroll=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KBottomHeight-60)];
        _imgScroll.pagingEnabled=YES;
        _imgScroll.delegate=self;
        [self addSubview:_imgScroll];
        
        
        UIButton *cancel=[[UIButton alloc] initWithFrame:CGRectMake(20, KMAINSIZE.height-KBottomHeight-50, 70, 40)];
        [cancel setTitle:@"返回" forState:UIControlStateNormal];
        [cancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancel addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancel];

        
        
        UIButton *delete = [[UIButton alloc] initWithFrame:CGRectMake(KMAINSIZE.width-90, KMAINSIZE.height-KBottomHeight-50, 70, 40)];
        [delete setTitle:@"删除" forState:UIControlStateNormal];
        [delete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [delete addTarget:self action:@selector(deleteImg) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:delete];

        
    }
    
    return self;
}

-(void)upDateUIWithPicture:(NSArray *)pictureArr andIndex:(NSInteger)index
{
    
    for (UIImageView *imgView in _imgScroll.subviews) {
        if ([imgView isKindOfClass:[UIImageView class]]) {
            
            [imgView removeFromSuperview];

        }
        
    }
    
    
    _imgScroll.contentSize=CGSizeMake(KMAINSIZE.width*(pictureArr.count), KMAINSIZE.height-KBottomHeight-60);
    
    for (NSInteger i=0; i<pictureArr.count; i++) {
        UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(i*KMAINSIZE.width, 0, KMAINSIZE.width, KMAINSIZE.height-KBottomHeight-60)];
        img.tag=i+1;
        img.contentMode=UIViewContentModeScaleAspectFit;
        img.image=pictureArr[i];
        img.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0];
        [_imgScroll addSubview:img];
    }
    if (index>=pictureArr.count) {
        _imgScroll.contentOffset=CGPointMake((index-1)*KMAINSIZE.width, 0);
    }else{
        _imgScroll.contentOffset=CGPointMake(index*KMAINSIZE.width, 0);
    }
    
    page=index;
}
-(void)cancelAction
{
    if (self.cancelBlock) {
        self.cancelBlock(0);
    }
}
-(void)deleteImg
{
    
    UIAlertView *delete=[[UIAlertView alloc] initWithTitle: nil message:@"删除此张照片" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [delete show];
}
#pragma mark-----UIAlertView代理
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        
        if (self.deleteBlock) {
            self.deleteBlock(page);
        }
        
    }
    
}

#pragma mark------scrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    page=scrollView.contentOffset.x/KMAINSIZE.width;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
