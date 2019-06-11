//
//  UIBarButtonItem+Utilities.h
//  OfficeSystem
//
//  Created by wangjt on 2017/1/12.
//  Copyright © 2017年 CIG Ad Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Utilities)

//返回按钮
+ (instancetype)navbarBackBtnItemWithImage:(NSString *)img
                                    action:(SEL)action
                                    target:(id)target;

- (instancetype)navbarBackBtnItemWithImage:(NSString *)img
                                    action:(SEL)action
                                    target:(id)target;

//导航右侧图片按钮
+ (instancetype)navbarRightBtnItemWithImage:(NSString *)img
                                     action:(SEL)action
                                     target:(id)target;

- (instancetype)navbarRightBtnItemWithImage:(NSString *)img
                                     action:(SEL)action
                                     target:(id)target;
//导航右侧文字按钮
+ (instancetype)navbarRightBtnItemWithTitle:(NSString *)img
                                     action:(SEL)action
                                     target:(id)target;

- (instancetype)navbarRightBtnItemWithTitle:(NSString *)img
                                     action:(SEL)action
                                     target:(id)target;
//右侧按钮
+ (instancetype)barBtnItemWithImage:(NSString *)img
                   highlightedImage:(NSString *)highlightedImg
                              title:(NSString *)title
                         titleColor:(UIColor *)color
                             action:(SEL)action
                             target:(id)target;

- (instancetype)initWithImage:(NSString *)img
             highlightedImage:(NSString *)highlightedImg
                        title:(NSString *)title
                   titleColor:(UIColor *)color
                       action:(SEL)action
                       target:(id)target;







+ (instancetype)barBtnItemWithImage:(NSString *)img
                   highlightedImage:(NSString *)highlightedImg
                             action:(SEL)action
                             target:(id)target;



- (instancetype)initWithImage:(NSString *)img
             highlightedImage:(NSString *)highlightedImg
                       action:(SEL)action
                       target:(id)target;



@end
