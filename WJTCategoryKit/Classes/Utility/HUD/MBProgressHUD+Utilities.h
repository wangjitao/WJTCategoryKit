//
//  MBProgressHUD+Utilities.h
//  OfficeSystem
//
//  Created by 王纪涛 on 2017/3/19.
//  Copyright © 2017年 CIG Ad Co.,Ltd. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Utilities)

+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

/** MBProgressHUD 自定义View */
+ (MBProgressHUD *)showLoadingHUDWithView:(UIView *)view;

@end
