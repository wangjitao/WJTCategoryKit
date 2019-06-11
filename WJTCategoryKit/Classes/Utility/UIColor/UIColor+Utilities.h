//
//  UIColor+Utilities.h
//  OfficeSystem
//
//  Created by wangjt on 2017/1/12.
//  Copyright © 2017年 CIG Ad Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Utilities)

#pragma mark - HEX

+ (UIColor *)colorWithHex:(UInt32)hex;
+ (UIColor *)colorWithHex:(UInt32)hex andAlpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)hexString;
- (NSString *)HEXString;

@end
