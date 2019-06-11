//
//  UIBarButtonItem+Utilities.m
//  OfficeSystem
//
//  Created by wangjt on 2017/1/12.
//  Copyright © 2017年 CIG Ad Co.,Ltd. All rights reserved.
//

#import "UIBarButtonItem+Utilities.h"

#import "MCNavigationItemCustomView.h"
#import "DefaultValueMacro.h"
#import "UIColor+Utilities.h"
#import "UIImage+Utilities.h"


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

@implementation UIBarButtonItem (Utilities)

//返回按钮
+ (instancetype)navbarBackBtnItemWithImage:(NSString *)img
                                    action:(SEL)action
                                    target:(id)target {
   return [[self alloc] navbarBackBtnItemWithImage:img action:action target:target];
}

- (instancetype)navbarBackBtnItemWithImage:(NSString *)img
                                    action:(SEL)action
                                    target:(id)target {
    
    MCNavigationItemCustomView *itemCustomView = [[MCNavigationItemCustomView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [itemCustomView addSubview:btn];
    
    if (@available(iOS 11.0, *)) {
        itemCustomView.alignmentRectInsetsOverride = UIEdgeInsetsMake(0, 20, 0, -(20));
        itemCustomView.translatesAutoresizingMaskIntoConstraints = NO;
        [itemCustomView.widthAnchor constraintEqualToConstant:44].active = YES;
        [itemCustomView.heightAnchor constraintEqualToConstant:44].active = YES;
    }
    
    return [[UIBarButtonItem alloc] initWithCustomView:itemCustomView];
}


//导航右侧图片按钮
+ (instancetype)navbarRightBtnItemWithImage:(NSString *)img
                                     action:(SEL)action
                                     target:(id)target {
    return [[self alloc] navbarRightBtnItemWithImage:img action:action target:target];
}

- (instancetype)navbarRightBtnItemWithImage:(NSString *)img
                                     action:(SEL)action
                                     target:(id)target {
    
    MCNavigationItemCustomView *itemCustomView = [[MCNavigationItemCustomView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 44, 44);
    [btn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [itemCustomView addSubview:btn];
    
    if (@available(iOS 11.0, *)) {
        itemCustomView.alignmentRectInsetsOverride = UIEdgeInsetsMake(0, -5, 0, 0);
        itemCustomView.translatesAutoresizingMaskIntoConstraints = NO;
        [itemCustomView.widthAnchor constraintEqualToConstant:44].active = YES;
        [itemCustomView.heightAnchor constraintEqualToConstant:44].active = YES;
    }
    
    return [[UIBarButtonItem alloc] initWithCustomView:itemCustomView];
}


//导航右侧文字按钮
+ (instancetype)navbarRightBtnItemWithTitle:(NSString *)img
                                     action:(SEL)action
                                     target:(id)target {
    return [[self alloc] navbarRightBtnItemWithTitle:img action:action target:target];
}

- (instancetype)navbarRightBtnItemWithTitle:(NSString *)img
                                     action:(SEL)action
                                     target:(id)target {
    
    MCNavigationItemCustomView *itemCustomView = [[MCNavigationItemCustomView alloc] initWithFrame:CGRectMake(0, 0,60, 44)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0,80, 44);
    [btn setTitle:img forState:UIControlStateNormal];
    btn.titleLabel.font = SYSTEMFONT(16);
    btn.titleLabel.textAlignment = NSTextAlignmentRight;
    [btn setTitleColor:[UIColor colorWithHex:kBlackColor] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [itemCustomView addSubview:btn];
    
    if (@available(iOS 11.0, *)) {
        itemCustomView.alignmentRectInsetsOverride = UIEdgeInsetsMake(0, -5, 0,18);
        itemCustomView.translatesAutoresizingMaskIntoConstraints = NO;
        [itemCustomView.widthAnchor constraintEqualToConstant:80].active = YES;
        [itemCustomView.heightAnchor constraintEqualToConstant:80].active = YES;
    }
    
    return [[UIBarButtonItem alloc] initWithCustomView:itemCustomView];
}

//右侧按钮
+ (instancetype)barBtnItemWithImage:(NSString *)img
                   highlightedImage:(NSString *)highlightedImg
                              title:(NSString *)title
                         titleColor:(UIColor *)color
                             action:(SEL)action
                             target:(id)target
{
    return [[self alloc] initWithImage:img
                      highlightedImage:highlightedImg
                                 title:title
                            titleColor:color
                                action:action
                                target:target];
}

#pragma clang diagnostic ignored "-Wobjc-designated-initializers"

- (instancetype)initWithImage:(NSString *)img
             highlightedImage:(NSString *)highlightedImg
                        title:(NSString *)title
                   titleColor:(UIColor *)color
                       action:(SEL)action
                       target:(id)target
{
    UIButton *btn = [[UIButton alloc] init];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    
    CGFloat alpha = 1;
    UIFont *font = [UIFont systemFontOfSize:16];
    
    [btn setTitleColor:[[UIColor whiteColor] colorWithAlphaComponent:alpha] forState:UIControlStateHighlighted];
    btn.titleLabel.font = font;
    
    CGFloat title_w = [title sizeWithAttributes:@{NSFontAttributeName : font}].width;
    btn.frame = CGRectMake(0, 0, title_w + btn.currentImage.size.width + 10, btn.currentImage.size.height);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    
    if (img&&(!title)) {
        UIImage *image = [[UIImage imageNamed:img] imageWithAlpha:alpha];
        btn.frame = CGRectMake(0, 0, 40, 40);
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [btn setImage:image forState:UIControlStateNormal];
    }
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}
















+ (instancetype)barBtnItemWithImage:(NSString *)img highlightedImage:(NSString *)highlightedImg action:(SEL)action target:(id)target
{
    return [[self alloc] initWithImage:img
                      highlightedImage:highlightedImg
                                action:action
                                target:target];
}


- (instancetype)initWithImage:(NSString *)img
             highlightedImage:(NSString *)highlightedImg action:(SEL)action target:(id)target
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [btn setImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}




@end
