//
//  PhotoHelper.m
//  FengXH
//
//  Created by mac on 2018/8/13.
//  Copyright © 2018年 HubinSun. All rights reserved.
//

#import "PhotoHelper.h"

@interface PhotoHelper ()

@property (strong, nonatomic)photoBlock block;// 返回block

@property (strong, nonatomic)UIImagePickerController *picker;

@property (weak, nonatomic)UIViewController *controller;

@end

@implementation PhotoHelper

+ (PhotoHelper *)sharedInstance {
    static PhotoHelper *sharedInstance=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)showPhotoActionViewWithBlock:(photoBlock)block {
    UINavigationController *navigation = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *visibleController = navigation.visibleViewController;
    [self showPhotoActionViewWithController:visibleController andWithBlock:block];
}

- (void)showPhotoActionViewWithController:(UIViewController *)controller andWithBlock:(photoBlock)block {
    
    _controller = controller;
    _block = block;
    [self takePhoto];
}


- (void)takePhoto {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypePhotoLibrary;
            type = UIImagePickerControllerSourceTypeCamera;
            [self showTakePhotoWithController:_controller imagePickerControllerSourceType:type andWithBlock:_block];
        }];
        UIAlertAction *photoLibraryAction = [UIAlertAction actionWithTitle:@"图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypePhotoLibrary;
            type = UIImagePickerControllerSourceTypePhotoLibrary;
            [self showTakePhotoWithController:_controller imagePickerControllerSourceType:type andWithBlock:_block];
        }];
        [alertController addAction:cameraAction];
        [alertController addAction:photoLibraryAction];
    } else {
        UIAlertAction *savedPhotosAlbumAction = [UIAlertAction actionWithTitle:@"图库" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImagePickerControllerSourceType type = UIImagePickerControllerSourceTypePhotoLibrary;
            type = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self showTakePhotoWithController:_controller imagePickerControllerSourceType:type andWithBlock:_block];
        }];
        [alertController addAction:savedPhotosAlbumAction];
    }
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    [_controller presentViewController:alertController animated:YES completion:nil];
    
}

- (void)showTakePhotoWithController:(UIViewController *)controller
    imagePickerControllerSourceType:(UIImagePickerControllerSourceType )type
                       andWithBlock:(photoBlock)block
{
    if (type != UIImagePickerControllerSourceTypeCamera &&
        type != UIImagePickerControllerSourceTypePhotoLibrary &&
        type != UIImagePickerControllerSourceTypeSavedPhotosAlbum) {
        return;
    }
    _block = block;
    
    self.picker.delegate = self;
    self.picker.allowsEditing = NO;
    self.picker.sourceType = type;
    self.picker.navigationBar.tintColor = KRedColor;
    if (@available(iOS 11, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }
    [controller presentViewController:_picker animated:YES completion:nil];
}

#pragma UIImagePickerControllerDelegate

//当一张图片后进入这里
-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    if (@available(iOS 11, *)) {
        UIScrollView.appearance.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:@"public.image"])
    {
        //先把图片转成NSData
        UIImage* newImage = [info objectForKey:UIImagePickerControllerEditedImage];
        if(newImage == nil){
            newImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        if (_block) {
            _block([self scaleImage:newImage]);
        }
        // 关闭相册界面
        [self.picker dismissViewControllerAnimated:YES completion:nil];
    }
}


// 取消选择照片:
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker

{
    //NSLog(@"您取消了选择图片");
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma mark 添加 get/set 方法


- (UIImagePickerController *)picker {
    
    if(!_picker) {
        
        _picker = [[UIImagePickerController alloc]init];
    }
    return _picker;
}

- (void)setAllowsEditing:(BOOL)allowsEditing {
    
    self.picker.allowsEditing = allowsEditing;
}

- (UIImage *)scaleImage:(UIImage *)image {
    float scale1 = 1;
    if (image.size.width > 640 * 0.7) {
        scale1 = 640.0*0.7/image.size.width;
    }
    float scale2 = 1;
    if (image.size.height > 1136 * 0.7) {
        scale2 = 1136.0*0.7/image.size.height;
    }
    float scale = scale1 < scale2 ? scale1 : scale2;
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width*scale,image.size.height*scale));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scale, image.size.height *scale)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}



@end
