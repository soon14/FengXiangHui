//
//  SpellOrderCommentViewController.m
//  FengXH
//
//  Created by mac on 2018/8/11.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "SpellOrderCommentViewController.h"
#import "SpellOrderCommentDiscussCell.h"
#import "SpellOrderCommentPhotoCell.h"
#import "StoreSettionFourthTableViewCell.h"
#import "SpellOrderCommentGradeCell.h"
#import "SpellOrderCommentWholeCell.h"
#import "SpellOrderCommentCheckImageView.h"

@interface SpellOrderCommentViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,StarGradeViewDelegate>

@property(nonatomic,strong)UICollectionView *commentCollectionView;

@property(nonatomic,strong)NSMutableArray *mImgArr;

@property(nonatomic,strong)SpellOrderCommentCheckImageView *checkImgView;


@end

@implementation SpellOrderCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title=@"评价";
    
    _mImgArr=[[NSMutableArray alloc]init];

    [self.view addSubview:self.commentCollectionView];
    
}
#pragma mark - <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 5;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==0||indexPath.section==2) {
        SpellOrderCommentWholeCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SpellOrderCommentWholeCell class]) forIndexPath:indexPath];
        if (indexPath.section==2) {
            cell.titleLab.text=@"晒图";
        }
        return cell;
    }
    else if (indexPath.section==1)
    {
        SpellOrderCommentGradeCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SpellOrderCommentGradeCell class]) forIndexPath:indexPath];
        cell.delegate=self;
        return cell;
    }
    else if (indexPath.section==3)
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
    else
    {
        SpellOrderCommentDiscussCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([SpellOrderCommentDiscussCell class]) forIndexPath:indexPath];
        
        return cell;
    }
    
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section==3) {
        return _mImgArr.count+1;
    }
    else
    {
        return 1;
    }
    
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section==3) {
        if (indexPath.row==_mImgArr.count) {
            if (_mImgArr.count<9) {
                //打开相机或者相册
                MJWeakSelf
                [[PhotoHelper sharedInstance] showPhotoActionViewWithController:self andWithBlock:^(id returnValue) {
                    
                    [weakSelf addPictureWithImage:returnValue];

                }];
            }
            else
            {
                KAlert(@"最多上传9张照片");
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
    
}

#pragma mark - <UICollectionViewDelegateFlowLayout>
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat collectionViewWidth = collectionView.frame.size.width;
    
    if (indexPath.section==0||indexPath.section==1||indexPath.section==2)
    {
        return CGSizeMake(collectionViewWidth, 60);
    }
    else if(indexPath.section==4)
    {
        return CGSizeMake(collectionViewWidth, 300);
    }
    else
    {
        return CGSizeMake(80, 80);
    }
    
    
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section==3) {
        return UIEdgeInsetsMake(10, 10, 10, 10);
    }
    else
    {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section==3) {
        return 10.0;
    }
    else
    {
        return CGFLOAT_MIN;
    }
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    if (section==3) {
        return 10.0;
    }
    else
    {
        return CGFLOAT_MIN;
    }
}

#pragma mark-----starDelegate
- (void)didSelectedIndex:(NSString *)index{
    
    NSLog(@"%@",index);
    
}
#pragma mark--------cheackImageView的Block
-(void)cancelAction
{
    _checkImgView.hidden=YES;
    [self.commentCollectionView reloadData];
}
-(void)deleteImgWithIndex:(NSInteger)index
{
    
    [_mImgArr removeObjectAtIndex:index];
    
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
        if (_mImgArr.count<9) {
            
            [_mImgArr insertObject:image atIndex:_mImgArr.count];
            //                [nameArr insertObject:[NSString stringWithFormat:@"%ld",nameArr.count] atIndex:nameArr.count];
        }
        else
        {
            KAlert(@"最多上传9张照片");
        }
    }
    
    [self.commentCollectionView reloadData];
    
}

#pragma mark-----commentCollectionView
-(UICollectionView *)commentCollectionView
{
    if (!_commentCollectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _commentCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, KMAINSIZE.width, KMAINSIZE.height-KNaviHeight-KBottomHeight) collectionViewLayout:flowLayout];
        _commentCollectionView.backgroundColor = [UIColor whiteColor];
        
        //注册评分cell
        [_commentCollectionView registerClass:[SpellOrderCommentGradeCell class] forCellWithReuseIdentifier:NSStringFromClass([SpellOrderCommentGradeCell class])];
        //注册cell
        [_commentCollectionView registerClass:[SpellOrderCommentWholeCell class] forCellWithReuseIdentifier:NSStringFromClass([SpellOrderCommentWholeCell class])];
        //注册晒图cell
        [_commentCollectionView registerClass:[SpellOrderCommentPhotoCell class] forCellWithReuseIdentifier:NSStringFromClass([SpellOrderCommentPhotoCell class])];
        //注册评论cell
        [_commentCollectionView registerClass:[SpellOrderCommentDiscussCell class] forCellWithReuseIdentifier:NSStringFromClass([SpellOrderCommentDiscussCell class])];
        
        _commentCollectionView.delegate=self;
        _commentCollectionView.dataSource=self;
        
    }
    return _commentCollectionView;
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
