//
//  QMChatRoomShowImageController.m
//  IMSDK-OC
//
//  Created by haochongfeng on 2017/5/17.
//  Copyright © 2017年 HCF. All rights reserved.
//

#import "QMChatRoomShowImageController.h"

@interface QMChatRoomShowImageController () <UIAlertViewDelegate,UINavigationControllerDelegate>

@end

@implementation QMChatRoomShowImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.bigImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    self.bigImageView.contentMode = UIViewContentModeScaleAspectFit;
    if ([self.picType isEqualToString:@"0"]) {
        NSString * filePath = [NSString stringWithFormat:@"%@/%@/%@",NSHomeDirectory(),@"Documents",self.picName];
        self.bigImageView.image = [UIImage imageWithContentsOfFile:filePath];
    }else {
        [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:self.picName] placeholderImage:self.image];
    }
    UITapGestureRecognizer * gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    UILongPressGestureRecognizer * pressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self.bigImageView addGestureRecognizer:pressGestureRecognizer];
    self.bigImageView.userInteractionEnabled = YES;
    [self.bigImageView addGestureRecognizer:gestureRecognizer];
    [self.view addSubview:self.bigImageView];
}

//长按保存图片
- (void)longPressAction:(UILongPressGestureRecognizer *)pressGestureRecognizer {
    if (pressGestureRecognizer.state == UIGestureRecognizerStateBegan) {
//        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"title.prompt", nil) message:NSLocalizedString(@"title.savePicture", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"button.cancel", nil) otherButtonTitles:NSLocalizedString(@"button.sure", nil), nil];
//        [alertView show];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"title.prompt", nil) message:NSLocalizedString(@"title.savePicture", nil) preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"button.cancel", nil) style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *sureAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"button.sure", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if ([self.picType isEqualToString:@"0"]) {
                NSString * filePath = [NSString stringWithFormat:@"%@/%@/%@/%@",NSHomeDirectory(),@"Documents",@"SaveFile",self.picName];
                UIImageWriteToSavedPhotosAlbum([UIImage imageWithContentsOfFile:filePath], nil, nil, nil);
            }else {
                NSURL * url = [NSURL URLWithString:self.picName];
                NSURLRequest * request = [NSURLRequest requestWithURL:url];
                NSURLSession *session = [NSURLSession sharedSession];
                [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                    UIImageWriteToSavedPhotosAlbum([UIImage imageWithData:data], nil, nil, nil);
                }];
            }
        }];
        [alertController addAction:cancelAction];
        [alertController addAction:sureAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

//返回
- (void)tapAction {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
