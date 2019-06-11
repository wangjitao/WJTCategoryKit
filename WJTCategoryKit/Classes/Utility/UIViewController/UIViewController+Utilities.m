//
//  UIViewController+Utilities.m
//  OfficeSystem
//
//  Created by wangjt on 2017/2/14.
//  Copyright © 2017年 CIG Ad Co.,Ltd. All rights reserved.
//

#import "UIViewController+Utilities.h"
#import "DefaultValueMacro.h"
#import "UIColor+Utilities.h"

@implementation UIViewController (Utilities)

- (void)addRightButtonWithTitle:(NSString *)buttonTitle {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame= CGRectMake(0, 0, 40, 30);
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightButtonOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor colorWithHex:kBlackestColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:AdaptedHeightValue(14)];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (void)addRightButtonWithImage:(NSString *)buttonImage {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame= CGRectMake(0, 0, 40, 30);
    [button setImage:[UIImage imageNamed:buttonImage] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightButtonOnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor colorWithHex:kBlackestColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:AdaptedHeightValue(14)];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    UIBarButtonItem *flexSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:self
    
                                                                               action:nil];
    flexSpacer.width = -8;
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:flexSpacer,rightButton, nil]];
}

- (void)rightButtonOnClicked:(id)sender {
    
}


@end
