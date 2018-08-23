//
//  HomepageGoodsDetailController.m
//  FengXH
//
//  Created by mac on 2018/7/27.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "HomepageGoodsDetailController.h"
#import "HomepageGoodsMessageCell.h"
#import "HomepageGoodsDetailModel.h"
#import "HomepageShopTableViewCell.h"
#import "HomepageGoodsBottomCell.h"
#import "HomepageDetailTableViewCell.h"


@interface HomepageGoodsDetailController ()<UITableViewDelegate,UITableViewDataSource>
// 类型
@property(nonatomic , assign)NSInteger goodsDetailType;

//详情所有图片高度
@property(nonatomic,strong)NSMutableArray *heightArr;


@end

@implementation HomepageGoodsDetailController

- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _goodsDetailType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
  
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_goodsDetailType==0) {
        
        return 4;
    }
    else
    {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (_goodsDetailType==0) {
        
        return 1;
    }
    else
    {
        return _dataModel.content.count;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section==0) {
        return CGFLOAT_MIN;
    } return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_goodsDetailType==0) {
        if (indexPath.section==0) {
            if (![_dataModel.discounts  isEqual:[NSNull null]] && _dataModel.discounts != nil && _dataModel.discounts != NULL && [_dataModel.discounts.discountsDefault intValue]>0) {
                return 510;
            }
                
            return 480;
        }
        else if (indexPath.section==1) {
            return 40;
        }
        else if (indexPath.section==2)
        {
            return 80;
        }
        else
        {
            return 50;
        }
    }
    else
    {
        
        return [self.heightArr[indexPath.row] floatValue];

    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_goodsDetailType==0) {
        if (indexPath.section==0) {
            HomepageGoodsMessageCell *goodsMessageCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomepageGoodsMessageCell class])];
            if (!goodsMessageCell) {
                goodsMessageCell = [[HomepageGoodsMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HomepageGoodsMessageCell class])];
            }
            goodsMessageCell.goodsMessageModel=_dataModel;
            return goodsMessageCell;
        }
        else if (indexPath.section==2)
        {
            HomepageShopTableViewCell *shopCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomepageShopTableViewCell class])];
            if (!shopCell) {
                shopCell = [[HomepageShopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HomepageShopTableViewCell class])];
            }
            shopCell.goodsShopModel=_dataModel.shopdetail;
            
            return shopCell;
        }
        else if (indexPath.section==3)
        {
            HomepageGoodsBottomCell *bottomCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomepageGoodsBottomCell class])];
            if (!bottomCell) {
                bottomCell = [[HomepageGoodsBottomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HomepageGoodsBottomCell class])];
            }
            
            return bottomCell;
        }
        else
        {
            UITableViewCell *selectCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class])];
            if (!selectCell) {
                selectCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([UITableViewCell class])];
                selectCell.selectionStyle=UITableViewCellSelectionStyleNone;
            }
            selectCell.textLabel.text= _selectText == nil ? @"请选择数量" : _selectText ;
            selectCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return selectCell;
        }
    }
    else
    {
        HomepageDetailTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([HomepageDetailTableViewCell class])];
        if (!detailCell) {
            detailCell = [[HomepageDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([HomepageDetailTableViewCell class])];
        }
        [detailCell.detailImgView setYy_imageURL:[NSURL URLWithString:_dataModel.content[indexPath.row]]];
        
        return detailCell;
    }
    
    
    
    
}

#pragma mark - didSelectRowAtIndexPath
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_goodsDetailType==0) {
        if (indexPath.section==1) {
            if (self.selectBlock) {
                self.selectBlock();
            }
        }
    }
}

-(void)reloadData
{
    if (_goodsDetailType==0) {
    
        [self.view addSubview:self.goodsTableView];

    }
    else
    {
        
        self.heightArr=[[NSMutableArray alloc]initWithCapacity:0];
        //创建一个分线程
        
        MJWeakSelf
 
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            for (NSInteger i = 0; i <_dataModel.content.count ; i++) {
                NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",_dataModel.content[i]]]];
                UIImage *image = [UIImage imageWithData:data];
                [weakSelf.heightArr addObject:[NSString stringWithFormat:@"%f",KMAINSIZE.width/image.size.width*image.size.height]];
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //线程组执行完毕后的操作 在这里写
                [weakSelf.view addSubview:weakSelf.goodsTableView];
                
            });
        });
        
        
        
    }
}


#pragma mark-----懒加载
- (UITableView *)goodsTableView {
    if (!_goodsTableView) {
        CGRect frame={{0, 0}, KMAINSIZE.width,KMAINSIZE.height-KNaviHeight-42-50-KBottomHeight};
        _goodsTableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
        _goodsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _goodsTableView.backgroundColor = KTableBackgroundColor;
        _goodsTableView.showsVerticalScrollIndicator = NO;
        _goodsTableView.dataSource = self;
        _goodsTableView.delegate = self;
        
        
    }
    return _goodsTableView;
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
