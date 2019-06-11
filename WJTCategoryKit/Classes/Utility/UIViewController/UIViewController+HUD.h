//
//  UIViewController+HUD.h
//  MrCarEnterprise
//
//  Created by wjt on 2018/9/3.
//  Copyright © 2018年 izuche Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIViewController (HUD)
//显示菊花，如不取消一直显示
- (void)hudShow;
///显示自定义loading样式,默认背景是无框透明，返回hud可继续进行定制
- (MBProgressHUD *)hudShowWithCustomView:(UIView *)customView;
//隐藏 HUD
- (void)hudHidden;

//提示消息，显示1秒
- (void)hudShowWithMsg:(NSString *)msg;

//提示消息，显示1秒，带图片
- (void)hudShowWithMsg:(NSString *)msg image:(UIImage *)img;
- (void)hudShowWithSuccessMsg:(NSString *)msg;
- (void)hudShowNetworkError;

//提示消息，如不取消一直显示
- (void)hudShowLoadingWithMsg:(NSString *)msg;
- (void)hudShowOnWindowWithMsg:(NSString *)msg;

- (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)msg viewController:(UIViewController *)vc;

@end
