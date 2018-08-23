//
//  PhotoHelper.h
//  FengXH
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^photoBlock) (id returnValue);

@interface PhotoHelper : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@property (assign, nonatomic)BOOL allowsEditing; // 是否可编辑



+ (PhotoHelper *)sharedInstance;


// window打开相机相册
- (void)showPhotoActionViewWithBlock: (photoBlock)block;

/**
 弹出框打开相机相册
 
 @param controller 当前的controller
 @param block      返回的图片
 */
- (void)showPhotoActionViewWithController: (UIViewController *)controller
                             andWithBlock: (photoBlock)block;

/**
 *  打开相机或相册
 *
 *
 */
- (void)showTakePhotoWithController: (UIViewController *)controller
    imagePickerControllerSourceType: (UIImagePickerControllerSourceType )type
                       andWithBlock: (photoBlock)block;



@end
