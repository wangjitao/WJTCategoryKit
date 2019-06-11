//
//  MBProgressHUD+Utilities.m
//  OfficeSystem
//
//  Created by 王纪涛 on 2017/3/19.
//  Copyright © 2017年 CIG Ad Co.,Ltd. All rights reserved.
//

#import "MBProgressHUD+Utilities.h"

@implementation MBProgressHUD (Utilities)

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];//快速显示一个提示信息
    hud.label.text = text;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];//设置图片
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:0.7];
}

#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view
{
    [self show:error icon:@"error.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}

+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}


#pragma mark -------------------------------------------
#pragma mark 显示loading
+ (MBProgressHUD *)showLoadingHUDWithView:(UIView *)view
{
    if (view == nil) {
        view = [[UIApplication sharedApplication].windows lastObject];
    }
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //hud.label.text = kLoadingText;
    //hud.label.font = [UIFont systemFontOfSize:kSystemFontSizeMiddle];
    hud.minSize = CGSizeMake(50, 50);
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    //hud.bezelView.color = [UIColor redColor];
    hud.removeFromSuperViewOnHide = YES;
    
    return hud;
}

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];//快速显示一个提示信息
    hud.mode = MBProgressHUDModeText;
    hud.label.text = message;
    
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:0.7];
    return hud;
}

+ (void)hideHUDForView:(UIView *)view
{
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

@end
