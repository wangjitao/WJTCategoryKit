//
//  UIViewController+HUD.m
//  MrCarEnterprise
//
//  Created by wjt on 2018/9/3.
//  Copyright © 2018年 izuche Co.,Ltd. All rights reserved.
//

#import "UIViewController+HUD.h"
#import "DefaultValueMacro.h"
#import "UIColor+Utilities.h"

#define afterDelayTime 3

#define kKeyWindow [UIApplication sharedApplication].keyWindow
@implementation UIViewController (HUD)

- (void)hudShow {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
    if (hud) {
        [hud hideAnimated:NO];
    }
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.bezelView.color = [UIColor colorWithHex:kHUDBackGroundColor andAlpha:0.8];
 #if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_9_0
    if (NSFoundationVersionNumber >= NSFoundationVersionNumber_iOS_9_0) {
       [[UIActivityIndicatorView appearanceWhenContainedInInstancesOfClasses:@[[MBProgressHUD class]]] setColor:[UIColor whiteColor]];
    }
#else
    [[UIActivityIndicatorView appearanceWhenContainedIn:[MBProgressHUD class], nil] setColor:[UIColor whiteColor]];
#endif
    
    hud.removeFromSuperViewOnHide = YES;
    hud.offset = CGPointMake(0, -50);
}

- (MBProgressHUD *)hudShowWithCustomView:(UIView *)customView {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
    if (hud) {
        [hud hideAnimated:NO];
    }
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //hud.bezelView.color = [UIColor hudBackgroundColor];
    hud.bezelView.color = [UIColor clearColor];
    hud.customView = customView;
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    //设置bezel颜色
    hud.bezelView.style = MBProgressHUDBackgroundStyleSolidColor;
    hud.offset = CGPointMake(0, -50);
    return hud;
}

- (void)hudHidden {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (MBProgressHUD *)mbProgressHud {
    
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
    if (!hud) {
        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.bezelView.color = [UIColor colorWithHex:0x418cf8 andAlpha:0.8];
        hud.removeFromSuperViewOnHide = YES;
        hud.offset = CGPointMake(0, -50);
    }
    return hud;
}

- (void)hudShowLongMsg:(NSString *)msg {
    
    MBProgressHUD *hud = [self mbProgressHud];
    UILabel * msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.65, 20)];
    //msgLabel.font = hud.label.font;
    //msgLabel.textColor = hud.label.textColor;
    msgLabel.font = SYSTEMFONT(14);
    msgLabel.textColor = [UIColor whiteColor];
    msgLabel.numberOfLines = 0;
    msgLabel.text = msg;
    [msgLabel sizeToFit];
    
    hud.bezelView.color = [UIColor colorWithHex:kHUDBackGroundColor andAlpha:0.8];
    hud.customView = msgLabel;
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = @"";
    [hud hideAnimated:YES afterDelay:afterDelayTime];
}

- (void)hudShowWithMsg:(NSString *)msg {
    
    if (msg.length == 0) {
        [self hudHidden];
        return;
    }
    
    CGSize strSize = [msg sizeWithAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]}];
    if (strSize.width > self.view.frame.size.width * 0.8) {
        [self hudShowLongMsg:msg];
        return;
    }
    
    MBProgressHUD *hud = [self mbProgressHud];
    hud.bezelView.color = [UIColor colorWithHex:kHUDBackGroundColor andAlpha:0.8];
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    hud.label.textColor = [UIColor whiteColor];
    hud.margin = 15.f;
    hud.userInteractionEnabled = NO;
    [hud hideAnimated:YES afterDelay:afterDelayTime];
}

- (void)hudShowWithMsg:(NSString *)msg image:(UIImage *)img {
    MBProgressHUD *hud = [self mbProgressHud];
    hud.bezelView.color = [UIColor colorWithHex:kHUDBackGroundColor andAlpha:0.8];
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:img];
    hud.label.text = msg;
    [hud hideAnimated:YES afterDelay:afterDelayTime];
}

- (void)hudShowWithSuccessMsg:(NSString *)msg {
    [self hudShowWithMsg:msg image:[UIImage imageNamed:@"nav_back"]];
}

- (void)hudShowNetworkError {
    [self hudShowWithMsg:@"网络有问题" image:[UIImage imageNamed:@"11-x"]];
}

- (void)hudShowLoadingWithMsg:(NSString *)msg {
    MBProgressHUD *hud = [self mbProgressHud];
    hud.bezelView.color = [UIColor colorWithHex:kHUDBackGroundColor andAlpha:0.8];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.label.text = msg;
    hud.label.textColor = [UIColor whiteColor];
}


- (void)hudShowOnWindowWithMsg:(NSString *)msg {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:kKeyWindow animated:YES];
    //hud.bezelView.color = [UIColor colorWithHex:0x171d2d andAlpha:0.8];
    hud.bezelView.color = [UIColor colorWithHex:kHUDBackGroundColor andAlpha:0.8];
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = msg;
    hud.label.textColor = [UIColor whiteColor];
    [hud hideAnimated:YES afterDelay:afterDelayTime];
}

- (void)showAlertControllerWithTitle:(NSString *)title message:(NSString *)msg viewController:(UIViewController *)vc {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:1];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [vc presentViewController:alert animated:YES completion:nil];
}

@end
