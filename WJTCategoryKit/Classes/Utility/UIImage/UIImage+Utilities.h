//
//  UIImage+Utilities.h
//  OfficeSystem
//
//  Created by wangjt on 2017/1/12.
//  Copyright © 2017年 CIG Ad Co.,Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utilities)

#pragma mark - Color
+ (UIImage *)imageWithColor:(UIColor *)color;

+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size;

/**
 *  图片透明度
 */
- (UIImage *)imageWithAlpha:(CGFloat)alpha;

/**
 *  图片圆角
 */
+ (id)createRoundedRectImage:(UIImage*)image
                        size:(CGSize)size
                      radius:(NSInteger)r;

+ (UIImage *)imageCompressForWidthScale:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;

@end
