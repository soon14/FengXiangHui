//
//  SpellOrderCommentCheckImageView.h
//  FengXH
//
//  Created by mac on 2018/8/11.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SpellOrderCheckImageViewBlock)(NSInteger index);

@interface SpellOrderCommentCheckImageView : UIView

@property(nonatomic,copy)SpellOrderCheckImageViewBlock cancelBlock;

@property(nonatomic,copy)SpellOrderCheckImageViewBlock deleteBlock;

-(void)upDateUIWithPicture:(NSArray *)pictureArr andIndex:(NSInteger)index;

@end
